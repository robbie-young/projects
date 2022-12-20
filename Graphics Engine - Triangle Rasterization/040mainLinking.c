


/* In this tutorial our compiler invocation becomes more complicated. First, we 
need 040pixel.h and 040pixel.o to be in the same directory as 040mainLinking.c. 
Then, on macOS, we compile with...

    clang 040mainLinking.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit

On Ubuntu, we compile with...

    cc 040mainLinking.c 040pixel.o -lglfw -lGL -lm -ldl

This invocation causes our compiled code to be 'linked' with other pieces 
of software, that have been compiled elsewhere. What are they? 040pixel.o is a 
library that I have written, to provide a simple foundation for the first and 
third projects in this graphics course. GLFW is a cross-platform, minimalist 
user interface toolkit, that we can use to build simple OpenGL applications. 
Often it is not pre-installed, but it is easy to install. OpenGL is a 
cross-platform, standardized library for interacting with graphics hardware. It 
comes pre-installed on macOS and Linux, and is easily installed on Windows. On 
macOS, all of this interacts with macOS-specific libraries called Cocoa and 
IOKit. */

/* Notice that we include 040pixel.h below. The file name is enclosed in 
quotation marks rather than angle brackets, to tell the C compiler to search for 
the file in the working directory. This 040pixel.h documents all of the public 
functionality of the library 040pixel.o. We also include glfw3.h. */
#include <stdio.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include "040pixel.h"

/* This function is a user interface 'callback'. Once we register it with the 
user interface infrastructure, it is called whenever the user releases a 
keyboard key. For details, see the pixSetKeyUpHandler documentation. */
void handleKeyUp(int key, int shiftIsDown, int controlIsDown,
        int altOptionIsDown, int superCommandIsDown) {
    printf("handleKeyUp: %d, shift %d, control %d, altOpt %d, supComm %d\n",
        key, shiftIsDown, controlIsDown, altOptionIsDown, superCommandIsDown);
    if (key == GLFW_KEY_A)
        printf("handleKeyUp: I see that you pressed the A key. Interesting!\n");
    if (key == GLFW_KEY_RIGHT)
        printf("handleKeyUp: You pressed the right-arrow key. Keep up the good work.\n");
}

/* Similarly, the following callbacks handle some mouse interactions. */
void handleMouseUp(double x, double y, int button, int shiftIsDown, 
        int controlIsDown, int altOptionIsDown, int superCommandIsDown) {
    printf("handleMouseUp: %d, shift %d, control %d, altOpt %d, supComm %d\n",
        button, shiftIsDown, controlIsDown, altOptionIsDown, 
        superCommandIsDown);
}

void handleMouseMove(double x, double y) {
    printf("handleMouseMove: x %f, y %f\n", x, y);
}

void handleMouseScroll(double xOffset, double yOffset) {
    printf("handleMouseScroll: xOffset %f, yOffset %f\n", xOffset, yOffset);
}

/* This callback is called once per animation frame. As parameters it receives 
the time for the current frame and the time for the previous frame. Both times 
are measured in seconds since some distant past time. */ 
void handleTimeStep(double oldTime, double newTime) {
    if (floor(newTime) - floor(oldTime) >= 1.0)
        printf("handleTimeStep: %f frames/s\n", 1.0 / (newTime - oldTime));
}

/* You can also set callbacks for key down, key repeat, and mouse down. See 
040pixel.h for details. */

int main(void) {
    /* Make a 512 x 512 window with the title 'Pixel Graphics'. This function 
    returns 0 if no error occurred. */
    if (pixInitialize(512, 512, "Pixel Graphics") != 0)
        return 1;
    /* Register the callbacks (defined above) with the user interface, so that 
    they are called as needed during pixRun (invoked below). */
    pixSetKeyUpHandler(handleKeyUp);
    pixSetMouseUpHandler(handleMouseUp);
    pixSetMouseMoveHandler(handleMouseMove);
    pixSetMouseScrollHandler(handleMouseScroll);
    pixSetTimeStepHandler(handleTimeStep);
    /* Clear the window to black. */
    pixClearRGB(0.0, 0.0, 0.0);
    /* Draw the graph of y = 500 sin (x / 50) in yellow. Notice that pixSetRGB 
    ignores attempts to set pixels outside the window. */
    int i;
    for (i = 0; i < 512; i = i + 1)
        pixSetRGB(i, 500.0 * sin(i / 50.0), 1.0, 1.0, 0.0);
    /* Run the event loop. The callbacks that were registered above are 
    invoked as needed. */
    pixRun();
    /* In this course, whenever you call an 'initialize' function to set up some 
    resources, you must later call a matching 'finalize' function to clean up 
    those resources. */
    pixFinalize();
    return 0;
}

