/*
080triangle.c

Author: Robbie Young
Date: 20/09/22
Use: For use in Carleton's CS331 Computer Graphics Course
*/

#include <stdio.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include "040pixel.h"

/*
Draws and fills in the triangle with vertices (a[0], a[1]), (b[0], b[1]), and (c[0], c[1])
*/
void triRenderALeft(double a[2], double b[2], double c[2], double rgb[3]) {
    /* Case for when c[0] is in between a[0] and b[0] */
    if (c[0] < b[0]) {
        if (b[0] - a[0] != 0 && c[0] - a[0] != 0) {
        for (int x0 = ceil(a[0]) ;  x0 < floor(c[0]) ; x0++) {
            int bottom_x1 = ceil(a[1] + ((b[1] - a[1]) / (b[0] - a[0])) * (x0 - a[0]));
            int top_x1 = floor(a[1] + ((c[1] - a[1]) / (c[0] - a[0])) * (x0 - a[0]));
            for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                pixSetRGB(x0, x1, rgb[0], rgb[1], rgb[2]);
            }
        }
    }
        if (b[0] - a[0] != 0 && c[0] - b[0] != 0) {
            for (int x0 = floor(c[0]) ; x0 < floor(b[0]) ; x0++) {
                int bottom_x1 = ceil(a[1] + ((b[1] - a[1]) / (b[0] - a[0])) * (x0 - a[0]));
                int top_x1 = floor(c[1] + ((c[1] - b[1]) / (c[0] - b[0])) * (x0 - c[0]));
                for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                    pixSetRGB(x0, x1, rgb[0], rgb[1], rgb[2]);
                }
            }
        }
    } 

    /* Case for when b[0] is in between a[0] and c[0] */
    else {
        if (b[0] - a[0] != 0 && c[0] - a[0] != 0) {
            for (int x0 = ceil(a[0]) ;  x0 < floor(b[0]) ; x0++) {
                int bottom_x1 = ceil(a[1] + ((b[1] - a[1]) / (b[0] - a[0])) * (x0 - a[0]));
                int top_x1 = floor(a[1] + ((c[1] - a[1]) / (c[0] - a[0])) * (x0 - a[0]));
                for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                    pixSetRGB(x0, x1, rgb[0], rgb[1], rgb[2]);
                }
            }
        }
        if (c[0] - b[0] != 0 && c[0] - a[0] != 0) {
            for (int x0 = floor(b[0]) ; x0 < floor(c[0]) ; x0++) {
                int bottom_x1 = ceil(b[1] + ((c[1] - b[1]) / (c[0] - b[0])) * (x0 - b[0]));
                int top_x1 = floor(a[1] + ((c[1] - a[1]) / (c[0] - a[0])) * (x0 - a[0]));
                for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                    pixSetRGB(x0, x1, rgb[0], rgb[1], rgb[2]);
                }
            }
        }
    }
}

/*
Reorders vertices such that A is the left most point
*/
void triRender(double a[2], double b[2], double c[2], double rgb[3]) {
    if (a[0] <= b[0] && a[0] <= c[0]) {
        triRenderALeft(a, b, c, rgb);
    } else if (b[0] <= c[0] && b[0] <= a[0]) {
        triRenderALeft(b, c, a, rgb);
    } else {
        triRenderALeft(c, a, b, rgb);
    }
}