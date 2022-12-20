/*
080mainRasterizing.c

Author: Robbie Young
Date: 20/09/22
Use: For use in Carleton's CS331 Computer Graphics Course

Compiling instructions:
    MacOS:  clang 080mainRasterizing.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
    Ubuntu: cc 080mainRasterizing.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#include "080vector.c"
#include "080triangle.c"

/*
Checks all cases for 060triangle.c by changing the x and y coordinates of each vertex
Closing one window opens the next case until all cases have been iterated through
*/
int main(void) {
    double a[2], b[2], c[2];
    double rgb[3] = {1.0, 1.0, 1.0};
    for (double first = 100 ; first < 512 ; first = first + 200) {
        for (double second = 100 ; second < 512 ; second = second + 200) {
            for (double third = 100 ; third < 512 ; third = third + 200) {
                for (double fourth = 100 ; fourth < 512 ; fourth = fourth + 200) {
                    for (double fifth = 100 ; fifth < 512 ; fifth = fifth + 200) {
                        for (double sixth = 100 ; sixth < 512 ; sixth = sixth + 200) {
                            a[0] = first, a[1] = second, b[0] = third, b[1] = fourth, c[0] = fifth, c[1] = sixth;

                            /* Used to check if inputted points are given in clockwise order */
                            double checkClockwise = (b[0] - a[0]) * (b[1] + a[1]) + (c[0] - b[0]) * (c[1] + b[1]) + (a[0] - c[0]) * (a[1] + c[1]);
                            if (checkClockwise < 0) {
                                if (pixInitialize(512, 512, "Pixel Graphics") != 0)
                                    return 1;
                                pixClearRGB(0.0, 0.0, 0.0);
                                triRender(a, b, c, rgb);
                                for (int i = 0 ; i < 5 ; i++) {
                                    for (int j = 0 ; j < 5 ; j++) {
                                        pixSetRGB(a[0] + i, a[1] + j, 1, 0, 0);
                                        pixSetRGB(b[0] + i, b[1] + j, 0, 1, 0);
                                        pixSetRGB(c[0] + i, c[1] + j, 0, 0, 1);
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