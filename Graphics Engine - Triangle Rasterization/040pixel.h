


/* This is a C header file. It declares the names, input parameters, and return 
types for all public functions in the 040pixel.o library. It does not show how 
those functions are implemented. The implementation details are hidden in 
040pixel.c, which compiles to 040pixel.o. */

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



/*** Miscellaneous ***/

/* Initializes the pixel system. This function must be called before any other 
pixel system functions. The width and height parameters describe the size of 
the window. They should be powers of 2. The name parameter is a string for the 
window's title. Returns an error code, which is 0 if no error occurred. Upon 
success, don't forget to call pixFinalize later, to clean up the pixel system. 
*/
int pixInitialize(int width, int height, const char *name);

/* Runs the event loop. First, any pending user events are processed by their 
corresponding callbacks. Second, the time step callback is invoked. Third, if 
any drawing has occurred, then the screen is updated to reflect that drawing. 
When the user elects to quit, this function terminates. */
void pixRun(void);

/* Deallocates the resources supporting the window. After this function is 
called, pixInitialize must be called again, before any further use of the pixel 
system. */
void pixFinalize(void);

/* Returns the red channel of the pixel at coordinates (x, y). Coordinates are 
relative to the lower left corner of the window. */
double pixGetR(int x, int y);

/* Returns the green channel of the pixel at coordinates (x, y). Coordinates 
are relative to the lower left corner of the window. */
double pixGetG(int x, int y);

/* Returns the blue channel of the pixel at coordinates (x, y). Coordinates are 
relative to the lower left corner of the window. */
double pixGetB(int x, int y);

/* Sets the pixel at coordinates (x, y) to the given RGB color. Coordinates are 
relative to the lower left corner of the window. */
void pixSetRGB(int x, int y, double red, double green, double blue);

/* Sets all pixels to the given RGB color. */
void pixClearRGB(double red, double green, double blue);

/* data must be an array of width * height * 3 doubles, so that it can hold RGB 
for each pixel in the window. This function copies the current window contents 
out to the data array. Pixel (i, j) (measured from the lower left) ends up at 
data[(i + width * j) * 3] and the two doubles following that. */
void pixCopyRGB(double *data);

/* Inverse of pixCopyRGB. This function pastes the contents of the data array 
into the window. */
void pixPasteRGB(double *data);



/*** Callbacks ***/

/* Sets a callback function for keys' being pressed. Invoked using something 
like
    pixSetKeyDownHandler(myKeyDownHandler);
where myKeyDownHandler is defined something like 
    void myKeyDownHandler(int key, int shiftIsDown, int controlIsDown,
        int altOptionIsDown, int superCommandIsDown);
The key parameter is GLFW_KEY_A, GLFW_KEY_B, ..., or GLFW_KEY_UNKNOWN, which 
are defined in GLFW/glfw3.h. The other parameters are flags describing the 
state of the modifier keys when the key was pressed. */
void pixSetKeyDownHandler(void (*handler)(int, int, int, int, int));

/* Sets a callback function for keys' being released. For details, see 
pixSetKeyDownHandler. */
void pixSetKeyUpHandler(void (*handler)(int, int, int, int, int));

/* Sets a callback function for keys' being held down. For details, see 
pixSetKeyDownHandler. */
void pixSetKeyRepeatHandler(void (*handler)(int, int, int, int, int));

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
        int));

/* Sets a callback function for mouse buttons' being released. For details, see 
pixSetMouseDownHandler. */
void pixSetMouseUpHandler(void (*handler)(double, double, int, int, int, int, 
        int));

/* Sets a callback function for the mouse's being moved. Invoked using 
something like
    pixSetMouseMoveHandler(myMouseMoveHandler);
where myMouseMoveHandler is defined something like 
    void myMouseMoveHandler(double x, double y);
The x and y parameters are relative to the lower left corner of the window. */
void pixSetMouseMoveHandler(void (*handler)(double, double));

/* Sets a callback function for the mouse's being scrolled. Invoked using 
something like 
    pixSetMouseScrollHandler(myMouseScrollHandler);
where myMouseScrollHandler is defined something like 
    void myMouseScrollHandler(double xOffset, double yOffset);
A vertical scroll wheel will always report 0.0 for xOffset. A scrolling gesture 
on a trackpad might generate non-zero values for both xOffset and yOffset. */
void pixSetMouseScrollHandler(void (*handler)(double, double));

/* Sets a callback function that fires once per animation frame, after all of 
the user interface callbacks. Invoked using something like 
    pixSetTimeStepHandler(myTimeStepHandler);
where myTimeStepHandler is defined something like
    void myTimeStepHandler(double oldTime, double newTime);
oldTime was the time for the previous frame; newTime is the time for the 
current frame. Both times are in seconds since the epoch (something like 1970). 
*/
void pixSetTimeStepHandler(void (*handler)(double, double));

