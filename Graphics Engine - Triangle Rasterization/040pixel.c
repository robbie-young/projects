


/*
On macOS, compile with...
    clang -c 040pixel.c -Wno-deprecated
...and then link with a main program by for example...
    clang main.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit

On Ubuntu, compile with...
    cc -c 040pixel.c
...and then link with a main program by for example...
    cc main.c 040pixel.o -lglfw -lGL -lm -ldl
*/

/*
There is some missing error checking in this code.

I stopped revising midway through a revision that would allow width and height 
to be other than powers of 2. The idea was to make the OpenGL texture have 
width and height equal to pixPowerOfTwoCeil of the user width and height.
*/



/*** Private: infrastructure ***/

#include <stdio.h>
#include <stdlib.h>
#include <GLFW/glfw3.h>
#include <sys/time.h>

// Global variables.
GLFWwindow *pixWindow;
int pixOrigWidth, pixOrigHeight; // as initialized
int pixWinWidth, pixWinHeight; // after resizing; resizing now forbidden
int pixTexWidth, pixTexHeight; // for the underlying OpenGL texture
GLuint pixTexture;
GLfloat *pixPixels;
int pixNeedsRedisplay = 1;
GLuint pixAttrBuffer, pixTriBuffer;
GLuint pixProgram;
GLint pixUnifLoc, pixAttrLoc;
double pixOldTime, pixNewTime;
void (*pixUserKeyDownHandler)(int, int, int, int, int) = NULL;
void (*pixUserKeyUpHandler)(int, int, int, int, int) = NULL;
void (*pixUserKeyRepeatHandler)(int, int, int, int, int) = NULL;
void (*pixUserMouseDownHandler)(double, double, int, int, int, int, int) = NULL;
void (*pixUserMouseUpHandler)(double, double, int, int, int, int, int) = NULL;
void (*pixUserMouseMoveHandler)(double, double) = NULL;
void (*pixUserMouseScrollHandler)(double, double) = NULL;
void (*pixUserTimeStepHandler)(double, double) = NULL;

int pixPowerOfTwoFloor(int n) {
    int m = 1;
    while (m <= n)
        m *= 2;
    return m / 2;
}

int pixPowerOfTwoCeil(int n) {
    int m = 1;
    while (m < n)
        m *= 2;
    return m;
}

double pixTime(void) {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (double)tv.tv_sec + (double)tv.tv_usec * 0.000001;
}

GLuint pixBuildVertexFragmentProgram(const GLchar *vertexCode, 
        const GLchar *fragmentCode) {
    GLuint vertexShader, fragmentShader, program;
    vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vertexCode, 0);
    // !!check for errors from glCompileShader
    glCompileShader(vertexShader);
    fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragmentCode, 0);
    // !!check for errors from glCompileShader
    glCompileShader(fragmentShader);
    program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    return program;
}



/*** Private: GLFW handlers ***/

void pixHandleError(int error, const char *description) {
    fprintf(stderr, "error: pixHandleError: GLFW code %d, message...\n%s\n",
        error, description);
}

// key is GLFW_KEY_A, GLFW_KEY_B, etc. Or GLFW_KEY_UNKNOWN.
// scancode is a platform-dependent scan code for the key.
// action is GLFW_PRESS, GLFW_RELEASE, or GLFW_REPEAT.
// mods has bitwise masks for...
//     GLFW_MOD_SHIFT, GLFW_MOD_CONTROL, GLFW_MOD_ALT, or GLFW_MOD_SUPER
// ...which on macOS mean shift, control, option, command.
void pixHandleKey(GLFWwindow *window, int key, int scancode, int action,
        int mods) {
    int shiftIsDown, controlIsDown, altOptionIsDown, superCommandIsDown;
    shiftIsDown = mods & GLFW_MOD_SHIFT;
    controlIsDown = mods & GLFW_MOD_CONTROL;
    altOptionIsDown = mods & GLFW_MOD_ALT;
    superCommandIsDown = mods & GLFW_MOD_SUPER;
    if (action == GLFW_PRESS && pixUserKeyDownHandler != NULL)
        pixUserKeyDownHandler(key, shiftIsDown, controlIsDown, altOptionIsDown, 
            superCommandIsDown);
    else if (action == GLFW_RELEASE && pixUserKeyUpHandler != NULL)
        pixUserKeyUpHandler(key, shiftIsDown, controlIsDown, altOptionIsDown, 
            superCommandIsDown);
    else if (action == GLFW_REPEAT && pixUserKeyRepeatHandler != NULL)
        pixUserKeyRepeatHandler(key, shiftIsDown, controlIsDown, 
            altOptionIsDown, superCommandIsDown);
}

// button is GLFW_MOUSE_BUTTON_LEFT, GLFW_MOUSE_BUTTON_RIGHT, or...?
// action is GLFW_PRESS or GLFW_RELEASE
// mods has bitwise masks for...
//     GLFW_MOD_SHIFT, GLFW_MOD_CONTROL, GLFW_MOD_ALT, or GLFW_MOD_SUPER
// ...which on macOS mean shift, control, option, command.
void pixHandleMouseButton(GLFWwindow *window, int button, int action, 
        int mods) {
    // Get status of modifier keys.
    int shiftIsDown, controlIsDown, altOptionIsDown, superCommandIsDown;
    shiftIsDown = mods & GLFW_MOD_SHIFT;
    controlIsDown = mods & GLFW_MOD_CONTROL;
    altOptionIsDown = mods & GLFW_MOD_ALT;
    superCommandIsDown = mods & GLFW_MOD_SUPER;
    // Get the position of the mouse relative to lower left corner of window.
    double x, y;
    glfwGetCursorPos(window, &x, &y);
    int width, height;//!!!width, height
    glfwGetWindowSize(window, &width, &height);
    y = height - y;
    // Invoke the user's mouse-down or mouse-up handler.
    if (action == GLFW_PRESS && pixUserMouseDownHandler != NULL)
        pixUserMouseDownHandler(x, y, button, shiftIsDown, controlIsDown, 
            altOptionIsDown, superCommandIsDown);
    else if (action == GLFW_RELEASE && pixUserMouseUpHandler != NULL)
        pixUserMouseUpHandler(x, y, button, shiftIsDown, controlIsDown, 
            altOptionIsDown, superCommandIsDown);
}

// The origin is in the upper left corner of the window.
void pixHandleMouseMove(GLFWwindow *window, double x, double y) {
    if (pixUserMouseMoveHandler != NULL) {
        // Flip vertically, so that the origin is in the lower left.
        int width, height; //!!!width, height
        glfwGetWindowSize(window, &width, &height);
        pixUserMouseMoveHandler(x, height - y);
    }
}

// The origin is in the upper left corner of the window.
// A 1D scroll wheel will report 0.0 for xOffset.
void pixHandleMouseScroll(GLFWwindow *window, double xOffset, double yOffset) {
    if (pixUserMouseScrollHandler != NULL)
        // Flip vertically, so that the origin is in the lower left.
        pixUserMouseScrollHandler(xOffset, -yOffset);
}



/*** Private: initializer ***/

// Initialize the user interface and OpenGL.
int pixInitGLFWGL3W(const char *name) {
    glfwSetErrorCallback(pixHandleError);
    // !!error if glfwInit() returns GL_FALSE
    glfwInit();
    glfwWindowHint(GLFW_RESIZABLE, 0);
    // This code is commented-out because 2.1 is the default.
    //glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
    //glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1);
    //glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    pixWindow = glfwCreateWindow(pixOrigWidth, pixOrigHeight, name, NULL, NULL);
    glfwMakeContextCurrent(pixWindow);
    glfwSetKeyCallback(pixWindow, pixHandleKey);
    glfwSetCursorPosCallback(pixWindow, pixHandleMouseMove);
    glfwSetMouseButtonCallback(pixWindow, pixHandleMouseButton);
    glfwSetScrollCallback(pixWindow, pixHandleMouseScroll);
    // The following code used to be...
    //glViewport(0, 0, pixOrigWidth, pixOrigHeight);
    int width, height;
    glfwGetFramebufferSize(pixWindow, &width, &height);
    glViewport(0, 0, width, height);
    return 0;
}

// Create the texture.
int pixInitTexture() {
    // !!error if malloc returns NULL
    pixPixels = (GLfloat *)malloc(3 * pixOrigWidth * pixOrigHeight * 
        sizeof(GLfloat));
    // If we were using OpenGL 4.5, we might do this.
    //glCreateTextures(GL_TEXTURE_RECTANGLE, 1, &pixTexture);
    //glTextureStorage2D(pixTexture, 1, GL_RGB32F, pixTexWidth, pixTexHeight);
    //glBindTextureUnit(0, pixTexture);
    // But in OpenGL 2.1 we do this instead.
    glGenTextures(1, &pixTexture);
    glBindTexture(GL_TEXTURE_2D, pixTexture);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, pixOrigWidth, pixOrigHeight, 0, 
        GL_RGB, GL_FLOAT, pixPixels); //!!!worrying width, height
    // !!error if glGetError returns anything but GL_NO_ERROR
    //glGetError() != GL_NO_ERROR
    return 0;
}

/*
// Vertex shader.
uniform mat4 cameraMatrix;
attribute vec4 attribs;
varying vec2 texCoords;
void main(){
    gl_Position = cameraMatrix * vec4(attribs[0], attribs[1], 0.0, 1.0);
    texCoords = vec2(attribs[2], attribs[3]);
}
// Fragment shader.
varying vec2 texCoords;
uniform sampler2D texture0;
void main(){
    gl_FragColor = texture2D(texture0, texCoords);
}
*/
// Build the shader program and leave it bound.
int pixInitShaders() {
    GLchar vertexCode[] = "uniform mat4 cameraMatrix;attribute vec4 attribs;varying vec2 texCoords;void main(){gl_Position = cameraMatrix * vec4(attribs[0], attribs[1], 0.0, 1.0);texCoords = vec2(attribs[2], attribs[3]);}";
    GLchar fragmentCode[] = "varying vec2 texCoords;uniform sampler2D texture0;void main(){gl_FragColor = texture2D(texture0, texCoords);}";
    pixProgram = pixBuildVertexFragmentProgram(vertexCode, fragmentCode);
    glUseProgram(pixProgram);
    // Load identifiers for sampler units, for some reason before validating.
    glUniform1i(glGetUniformLocation(pixProgram, "texture0"), 0);
    //!!validateShaderProgram(self.drawingProgram)
    pixUnifLoc = glGetUniformLocation(pixProgram, "cameraMatrix");
    pixAttrLoc = glGetAttribLocation(pixProgram, "attribs");
    return 0;
}

// Make a rectangle from two triangles. Leave the OpenGL buffers bound.
int pixInitMesh() {
    //double widthFrac = 1.0;
    //double heightFrac = 1.0;
    double widthFrac = (double)pixOrigWidth / pixTexWidth;
    double heightFrac = (double)pixOrigHeight / pixTexHeight;
    GLfloat attributes[4 * 4] = {
        0.0, 0.0, 0.0, 0.0,
        pixOrigWidth, 0.0, widthFrac, 0.0, 
        pixOrigWidth, pixOrigHeight, widthFrac, heightFrac,
        0.0, pixOrigHeight, 0.0, heightFrac};
    GLushort triangles[2 * 3] = {0, 1, 2, 0, 2, 3};
    glGenBuffers(1, &pixAttrBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, pixAttrBuffer);
    glBufferData(GL_ARRAY_BUFFER, 4 * 4 * sizeof(GLfloat),
        (GLvoid *)attributes, GL_STATIC_DRAW);
    glGenBuffers(1, &pixTriBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, pixTriBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, 2 * 3 * sizeof(GLushort),
        (GLvoid *)triangles, GL_STATIC_DRAW);
    glVertexAttribPointer(pixAttrLoc, 4, GL_FLOAT, 0, 4 * sizeof(GLfloat), 0);
    glEnableVertexAttribArray(pixAttrLoc);
    return 0;
}



/*** Public: miscellaneous ***/

/* A pixel system program usually proceeds through these five steps:
    A. pixInitialize is invoked to set up certain resources.
    B. Other pixel system functions are invoked to configure the user interface. 
    C. pixRun is invoked. While it runs, user interface callbacks registered in 
       step B are invoked automatically.
    D. The user elects to quit the program, thus causing pixRun to terminate.
    E. pixFinalize is invoked to clean up the resources.
Sometimes a pixel system program makes multiple loops through these five steps. 
The important thing is that invocations of pixInitialize and pixFinalize come in 
non-overlapping pairs. The pixel system is designed to support only one active 
window at a time. */

/* Initializes the pixel system. This function must be called before any other 
pixel system functions. The width and height parameters describe the size of 
the window. They should be powers of 2. The name parameter is a string for the 
window's title. Returns an error code, which is 0 if no error occurred. Upon 
success, don't forget to call pixFinalize later, to clean up the pixel system. 
*/
int pixInitialize(int width, int height, const char *name) {
    int error = 0;
    pixTexWidth = pixPowerOfTwoFloor(width);
    pixTexHeight = pixPowerOfTwoFloor(height);
    pixOrigWidth = pixTexWidth;
    pixOrigHeight = pixTexHeight;
    pixWinWidth = pixOrigWidth;
    pixWinHeight = pixOrigHeight;
    if (pixOrigWidth != width || pixOrigHeight != height) {
        fprintf(stderr, "warning: pixInitialize: ");
        fprintf(stderr, "forcing width, height to be powers of 2.\n");
    }
    // !!when errors happen midway through, should deallocate resources so far
    error = pixInitGLFWGL3W(name);
    if (!error)
        error = pixInitTexture();
    if (!error)
        error = pixInitShaders();
    if (!error)
        error = pixInitMesh();
    pixNewTime = pixTime();
    //fprintf(stderr, "pixInitialize: OpenGL %s, GLSL %s.\n", 
    //    glGetString(GL_VERSION), glGetString(GL_SHADING_LANGUAGE_VERSION));
    return 0;
}

/* Runs the event loop. First, any pending user events are processed by their 
corresponding callbacks. Second, the time step callback is invoked. Third, if 
any drawing has occurred, then the screen is updated to reflect that drawing. 
When the user elects to quit, this function terminates. */
void pixRun(void) {
    while (glfwWindowShouldClose(pixWindow) == GL_FALSE) {
        glfwPollEvents();
        pixOldTime = pixNewTime;
        pixNewTime = pixTime();
        if (pixUserTimeStepHandler != NULL)
            pixUserTimeStepHandler(pixOldTime, pixNewTime);
        if (pixNeedsRedisplay) {
            // In OpenGL 4.5 we might do this.
            //glTextureSubImage2D(pixTexture, 0, 0, 0, pixOrigWidth, 
            //    pixOrigHeight, GL_RGB, GL_FLOAT, pixPixels);
            // But in OpenGL 2.1 we do this.
            glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, pixOrigWidth, 
                pixOrigHeight, GL_RGB, GL_FLOAT, pixPixels);
            GLfloat matrix[] = {
                2.0 / pixWinWidth, 0.0, 0.0, -1.0,
                0.0, 2.0 / pixWinHeight, 0.0, -1.0,
                0.0, 0.0, -1.0, 0.0,
                0.0, 0.0, 0.0, 1.0};
            glUniformMatrix4fv(pixUnifLoc, 1, GL_TRUE, matrix);
            glDrawElements(GL_TRIANGLES, 3 * 2, GL_UNSIGNED_SHORT, 0);
            glfwSwapBuffers(pixWindow);
            pixNeedsRedisplay = 0;
        }
    }
}

/* Deallocates the resources supporting the window. After this function is 
called, pixInitialize must be called again, before any further use of the pixel 
system. */
void pixFinalize(void) {
    glDisableVertexAttribArray(pixAttrLoc);
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
    glDeleteBuffers(1, &pixTriBuffer);
    glDeleteBuffers(1, &pixAttrBuffer);
    //glUseProgram(0);
    glDeleteProgram(pixProgram);
    glDeleteTextures(1, &pixTexture);
    free(pixPixels);
    glfwDestroyWindow(pixWindow);
    glfwTerminate();
}

/* Returns the red channel of the pixel at coordinates (x, y). Coordinates are 
relative to the lower left corner of the window. */
double pixGetR(int x, int y) {
    if (0 <= x && x < pixOrigWidth && 0 <= y && y < pixOrigHeight)
        return pixPixels[3 * (x + pixOrigWidth * y)];
    else
        return -1.0;
}

/* Returns the green channel of the pixel at coordinates (x, y). Coordinates 
are relative to the lower left corner of the window. */
double pixGetG(int x, int y) {
    if (0 <= x && x < pixOrigWidth && 0 <= y && y < pixOrigHeight)
        return pixPixels[3 * (x + pixOrigWidth * y) + 1];
    else
        return -1.0;
}

/* Returns the blue channel of the pixel at coordinates (x, y). Coordinates are 
relative to the lower left corner of the window. */
double pixGetB(int x, int y) {
    if (0 <= x && x < pixOrigWidth && 0 <= y && y < pixOrigHeight)
        return pixPixels[3 * (x + pixOrigWidth * y) + 2];
    else
        return -1.0;
}

/* Sets the pixel at coordinates (x, y) to the given RGB color. Coordinates are 
relative to the lower left corner of the window. */
void pixSetRGB(int x, int y, double red, double green, double blue) {
    if (0 <= x && x < pixOrigWidth && 0 <= y && y < pixOrigHeight) {
        int index = 3 * (x + pixOrigWidth * y);
        pixPixels[index] = red;
        pixPixels[index + 1] = green;
        pixPixels[index + 2] = blue;
        pixNeedsRedisplay = 1;
    }
}

/* Sets all pixels to the given RGB color. */
void pixClearRGB(double red, double green, double blue) {
    int index, bound;
    bound = 3 * pixOrigWidth * pixOrigHeight;
    for (index = 0; index < bound; index += 3) {
        pixPixels[index] = red;
        pixPixels[index + 1] = green;
        pixPixels[index + 2] = blue;
    }
    pixNeedsRedisplay = 1;
}

/* data must be an array of width * height * 3 doubles, so that it can hold RGB 
for each pixel in the window. This function copies the current window contents 
out to the data array. Pixel (i, j) (measured from the lower left) ends up at 
data[(i + width * j) * 3] and the two doubles following that. */
void pixCopyRGB(double *data) {
    int k = 0;
    for (int j = 0; j < pixOrigHeight; j += 1)
        for (int i = 0; i < pixOrigWidth; i += 1) {
            data[k++] = pixGetR(i, j);
            data[k++] = pixGetG(i, j);
            data[k++] = pixGetB(i, j);
        }
}

/* Inverse of pixCopyRGB. This function pastes the contents of the data array 
into the window. */
void pixPasteRGB(double *data) {
    int k = 0;
    for (int j = 0; j < pixOrigHeight; j += 1)
        for (int i = 0; i < pixOrigWidth; i += 1) {
            pixSetRGB(i, j, data[k], data[k + 1], data[k + 2]);
            k += 3;
        }
}



/*** Public: callbacks ***/

/* Sets a callback function for keys' being pressed. Invoked using something 
like
    pixSetKeyDownHandler(myKeyDownHandler);
where myKeyDownHandler is defined something like 
    void myKeyDownHandler(int key, int shiftIsDown, int controlIsDown,
        int altOptionIsDown, int superCommandIsDown);
The key parameter is GLFW_KEY_A, GLFW_KEY_B, ..., or GLFW_KEY_UNKNOWN, which 
are defined in GLFW/glfw3.h. The other parameters are flags describing the 
state of the modifier keys when the key was pressed. */
void pixSetKeyDownHandler(void (*handler)(int, int, int, int, int)) {
    pixUserKeyDownHandler = handler;
}

/* Sets a callback function for keys' being released. For details, see 
pixSetKeyDownHandler. */
void pixSetKeyUpHandler(void (*handler)(int, int, int, int, int)) {
    pixUserKeyUpHandler = handler;
}

/* Sets a callback function for keys' being held down. For details, see 
pixSetKeyDownHandler. */
void pixSetKeyRepeatHandler(void (*handler)(int, int, int, int, int)) {
    pixUserKeyRepeatHandler = handler;
}

/* Sets a callback function for mouse buttons' being pressed. Invoked using 
something like
    pixSetMouseDownHandler(myMouseDownHandler);
where myMouseDownHandler is defined something like 
    void myMouseDownHandler(double x, double y, int button, int shiftIsDown, 
        int controlIsDown, int altOptionIsDown, int superCommandIsDown);
The x and y parameters are the position of the mouse relative to the lower left 
corner of the window. The button parameter is GLFW_MOUSE_BUTTON_LEFT, 
GLFW_MOUSE_BUTTON_RIGHT, or something like that. Those values are defined in 
GLFW/glfw3.h. The other parameters are flags describing the state of the 
modifier keys when the mouse button was pressed. */
void pixSetMouseDownHandler(void (*handler)(double, double, int, int, int, int, 
        int)) {
    pixUserMouseDownHandler = handler;
}

/* Sets a callback function for mouse buttons' being released. For details, see 
pixSetMouseDownHandler. */
void pixSetMouseUpHandler(void (*handler)(double, double, int, int, int, int, 
        int)) {
    pixUserMouseUpHandler = handler;
}

/* Sets a callback function for the mouse's being moved. Invoked using 
something like
    pixSetMouseMoveHandler(myMouseMoveHandler);
where myMouseMoveHandler is defined something like 
    void myMouseMoveHandler(double x, double y);
The x and y parameters are relative to the lower left corner of the window. */
void pixSetMouseMoveHandler(void (*handler)(double, double)) {
    pixUserMouseMoveHandler = handler;
}

/* Sets a callback function for the mouse's being scrolled. Invoked using 
something like 
    pixSetMouseScrollHandler(myMouseScrollHandler);
where myMouseScrollHandler is defined something like 
    void myMouseScrollHandler(double xOffset, double yOffset);
A vertical scroll wheel will always report 0.0 for xOffset. A scrolling gesture 
on a trackpad might generate non-zero values for both xOffset and yOffset. */
void pixSetMouseScrollHandler(void (*handler)(double, double)) {
    pixUserMouseScrollHandler = handler;
}

/* Sets a callback function that fires once per animation frame, after all of 
the user interface callbacks. Invoked using something like 
    pixSetTimeStepHandler(myTimeStepHandler);
where myTimeStepHandler is defined something like
    void myTimeStepHandler(double oldTime, double newTime);
oldTime was the time for the previous frame; newTime is the time for the 
current frame. Both times are in seconds since the epoch (something like 1970). 
*/
void pixSetTimeStepHandler(void (*handler)(double, double)) {
    pixUserTimeStepHandler = handler;
}

