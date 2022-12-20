/*
050mainPainting.c

Author: Robbie Young
Date: 20/09/22
Use: For use in Carleton's CS331 Computer Graphics Course

Compiling instructions:
    MacOS:  clang 050mainPainting.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
    Ubuntu: cc 050mainLinking.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#include <stdio.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include "040pixel.h"

double red = 1.0, green = 1.0, blue = 1.0;
int mouseIsDown = 0;
int brushSize = 1;

/*
Handler for when a key is pressed. Supports the following functions, formatted as 'key' : function
    'r' : changes brush colour to red
    'g' : changes brush colour to green
    'b' : changes brush colour to blue
    'c' : changes brush colour to cyan
    'm' : changes brush colour to magenta
    'y' : changes brush colour to yellow
    'k' : changes brush colour to black
    'w' : changes brush colour to white
    'q' : clears window (sets all pixels to black)
    'o' : decreases brush size
    'p' : increases brush size
*/
void handleKeyUp(int key, int shiftIsDown, int controlIsDown,
        int altOptionIsDown, int superCommandIsDown) {
    switch(key) {
        case GLFW_KEY_R:
            red = 1.0;
            green = 0.0;
            blue = 0.0;
            break;
        case GLFW_KEY_G: 
            red = 0.0;
            green = 1.0;
            blue = 0.0;
            break;
        case GLFW_KEY_B:
            red = 0.0;
            green = 0.0;
            blue = 1.0;
            break;
        case GLFW_KEY_C:
            red = 0.0;
            green = 1.0;
            blue = 1.0;
            break;
        case GLFW_KEY_M:
            red = 1.0;
            green = 0.0;
            blue = 1.0;
            break;
        case GLFW_KEY_Y:
            red = 1.0;
            green = 1.0;
            blue = 0.0;
            break;
        case GLFW_KEY_K:
            red = 0.0;
            green = 0.0;
            blue = 0.0;
            break;
        case GLFW_KEY_W:
            red = 1.0;
            green = 1.0;
            blue = 1.0;
            break;
        case GLFW_KEY_Q:
            pixClearRGB(0.0, 0.0, 0.0);
            break;
        case GLFW_KEY_O:
            if (brushSize > 1) {
                brushSize--;
                break;
            }
        case GLFW_KEY_P:
            brushSize++;
            break;
    }
        }

/*
Handler for mouse buttons being pressed down, updates global variable when left click is pressed down
*/
void handleMouseDown(double x, double y, int button, int shiftIsDown, 
        int controlIsDown, int altOptionIsDown, int superCommandIsDown) {
    if (button == GLFW_MOUSE_BUTTON_1) {
        mouseIsDown = 1;
    }
}

/*
Handler for mouse buttons being released, updates global variable when any mouse button is released
*/
void handleMouseUp(double x, double y, int button, int shiftIsDown, 
        int controlIsDown, int altOptionIsDown, int superCommandIsDown) {
    mouseIsDown = 0;
}

/*
Handler for mouse movement, sets pixel only while left click is benig pressed
*/
void handleMouseMove(double x, double y) {
    if (mouseIsDown == 1) {
        for (int n = 0 ; n < brushSize ; n++) {
            for (int m = 0 ; m < brushSize ; m++) {
                pixSetRGB(x + n, y + m, red, green, blue);
            }
        }
    }
}

int main(void) {
    if (pixInitialize(512, 512, "Pixel Graphics") != 0)
        return 1;
    pixSetKeyUpHandler(handleKeyUp);
    pixSetMouseDownHandler(handleMouseDown);
    pixSetMouseUpHandler(handleMouseUp);
    pixSetMouseMoveHandler(handleMouseMove);
    pixClearRGB(0.0, 0.0, 0.0);
    pixRun();
    pixFinalize();
    return 0;
}