/*0
60mainRasterizing.c

Author: Robbie Young
Date: 20/09/22
Use: For use in Carleton's CS331 Computer Graphics Course
Credits: https://stackoverflow.com/questions/1165647/how-to-determine-if-a-list-of-polygon-points-are-in-clockwise-order

Compiling instructions:
    MacOS:  clang 060mainRasterizing.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
    Ubuntu: cc 060mainRasterizing.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#include "060triangle.c"

/*
Checks all cases for 060triangle.c by changing the x and y coordinates of each vertex
Closing one window opens the next case until all cases have been iterated through
*/
int main(void) {
    double a0, a1, b0, b1, c0, c1;
    double red = 1.0, green = 1.0, blue = 1.0;
    for (double first = 100 ; first < 512 ; first = first + 200) {
        for (double second = 100 ; second < 512 ; second = second + 200) {
            for (double third = 100 ; third < 512 ; third = third + 200) {
                for (double fourth = 100 ; fourth < 512 ; fourth = fourth + 200) {
                    for (double fifth = 100 ; fifth < 512 ; fifth = fifth + 200) {
                        for (double sixth = 100 ; sixth < 512 ; sixth = sixth + 200) {
                            a0 = first, a1 = second, b0 = third, b1 = fourth, c0 = fifth, c1 = sixth;

                            /* Used to check if inputted points are given in clockwise order */
                            double checkClockwise = (b0 - a0) * (b1 + a1) + (c0 - b0) * (c1 + b1) + (a0 - c0) * (a1 + c1);
                            if (checkClockwise < 0) {
                                if (pixInitialize(512, 512, "Pixel Graphics") != 0)
                                    return 1;
                                pixClearRGB(0.0, 0.0, 0.0);
                                triRender(a0, a1, b0, b1, c0, c1, red, green, blue);
                                for (int i = 0 ; i < 5 ; i++) {
                                    for (int j = 0 ; j < 5 ; j++) {
                                        pixSetRGB(a0 + i, a1 + j, 1, 0, 0);
                                        pixSetRGB(b0 + i, b1 + j, 0, 1, 0);
                                        pixSetRGB(c0 + i, c1 + j, 0, 0, 1);
                                    }
                                }
                                pixRun();
                                pixFinalize();
                            }
                        }
                    }
                }
            }
        }
    }
    return 0;
}