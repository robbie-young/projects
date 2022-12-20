/*
060triangle.c

Author: Robbie Young
Date: 19/09/22
Use: For use in Carleton's CS331 Computer Graphics Course
*/

#include <stdio.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include "040pixel.h"

/*
Draws and fills in the triangle with vertices (a0, a1), (b0, b1), and (c0, c1)
*/
void triRenderALeft(
        double a0, double a1, double b0, double b1, double c0, double c1, 
        double r, double g, double b) {
            /* Case for when c0 is in between a0 and b0 */
            if (c0 < b0) {
                if (b0 - a0 != 0 && c0 - a0 != 0) {
                for (int x0 = ceil(a0) ;  x0 < floor(c0) ; x0++) {
                    int bottom_x1 = ceil(a1 + ((b1 - a1) / (b0 - a0)) * (x0 - a0));
                    int top_x1 = floor(a1 + ((c1 - a1) / (c0 - a0)) * (x0 - a0));
                    for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                        pixSetRGB(x0, x1, r, g, b);
                    }
                }
            }
                if (b0 - a0 != 0 && c0 - b0 != 0) {
                    for (int x0 = floor(c0) ; x0 < floor(b0) ; x0++) {
                        int bottom_x1 = ceil(a1 + ((b1 - a1) / (b0 - a0)) * (x0 - a0));
                        int top_x1 = floor(c1 + ((c1 - b1) / (c0 - b0)) * (x0 - c0));
                        for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                            pixSetRGB(x0, x1, r, g, b);
                        }
                    }
                }
            } 

            /* Case for when b0 is in between a0 and c0 */
            else {
                if (b0 - a0 != 0 && c0 - a0 != 0) {
                    for (int x0 = ceil(a0) ;  x0 < floor(b0) ; x0++) {
                        int bottom_x1 = ceil(a1 + ((b1 - a1) / (b0 - a0)) * (x0 - a0));
                        int top_x1 = floor(a1 + ((c1 - a1) / (c0 - a0)) * (x0 - a0));
                        for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                            pixSetRGB(x0, x1, r, g, b);
                        }
                    }
                }
                if (c0 - b0 != 0 && c0 - a0 != 0) {
                    for (int x0 = floor(b0) ; x0 < floor(c0) ; x0++) {
                        int bottom_x1 = ceil(b1 + ((c1 - b1) / (c0 - b0)) * (x0 - b0));
                        int top_x1 = floor(a1 + ((c1 - a1) / (c0 - a0)) * (x0 - a0));
                        for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                            pixSetRGB(x0, x1, r, g, b);
                        }
                    }
                }
            }
        }

/*
Reorders vertices such that A is the left most point
*/
void triRender(
        double a0, double a1, double b0, double b1, double c0, double c1, 
        double r, double g, double b) {
            if (a0 <= b0 && a0 <= c0) {
                triRenderALeft(a0, a1, b0, b1, c0, c1, r, g, b);
            } else if (b0 <= c0 && b0 <= a0) {
                triRenderALeft(b0, b1, c0, c1, a0, a1, r, g, b);
            } else {
                triRenderALeft(c0, c1, a0, a1, b0, b1, r, g, b);
            }
        }