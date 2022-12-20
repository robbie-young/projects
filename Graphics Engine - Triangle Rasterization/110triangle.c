/*
110triangle.c

Author: Robbie Young
Date: 20/09/22
Use: For use in Carleton's CS331 Computer Graphics Course
*/

#include <stdio.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include "040pixel.h"
#include "080vector.c"
#include "100matrix.c"

/*
Helper method for setting pixel to interpolated colour
*/
void pixSetHelp(
    double x0, double x1, const double a[2], const double inverseA[2][2], 
    const double alpha[3], const double betaMinusAlpha[3], 
    const double gammaMinusAlpha[3], const double rgb[3]) {
        double xMinusA[2] = {x0 - a[0], x1 - a[1]};
        
        double pq[2];
        mat221Multiply(inverseA, xMinusA, pq);

        double pBetaMinusAlpha[3], qGammaMinusAlpha[3];
        vecScale(3, pq[0], betaMinusAlpha, pBetaMinusAlpha);
        vecScale(3, pq[1], gammaMinusAlpha, qGammaMinusAlpha);

        double rgbFinal[3];
        vecAdd(3, pBetaMinusAlpha, qGammaMinusAlpha, rgbFinal);
        vecAdd(3, rgbFinal, alpha, rgbFinal);
        vecModulate(3, rgbFinal, rgb, rgbFinal);
        pixSetRGB(x0, x1, rgbFinal[0], rgbFinal[1], rgbFinal[2]);
}

/*
Draws and fills in the triangle with vertices (a[0], a[1]), (b[0], b[1]), and (c[0], c[1])
*/
void triRenderALeft(
    const double a[2], const double b[2], const double c[2], 
        const double rgb[3], const double alpha[3], const double beta[3], 
        const double gamma[3]) {
            double bMinusA[2], cMinusA[2], A[2][2], inverseA[2][2], betaMinusAlpha[3], gammaMinusAlpha[3], pq[2];
            vecSubtract(2, b, a, bMinusA);
            vecSubtract(2, c, a, cMinusA);
            mat22Columns(bMinusA, cMinusA, A);
            mat22Invert(A, inverseA);
            vecSubtract(3, beta, alpha, betaMinusAlpha);
            vecSubtract(3, gamma, alpha, gammaMinusAlpha);

            /* Case for when c[0] is in between a[0] and b[0] */
            if (c[0] < b[0]) {
                if (b[0] - a[0] != 0 && c[0] - a[0] != 0) {
                    for (int x0 = ceil(a[0]) ;  x0 < floor(c[0]) ; x0++) {
                        int bottom_x1 = ceil(a[1] + ((b[1] - a[1]) / (b[0] - a[0])) * (x0 - a[0]));
                        int top_x1 = floor(a[1] + ((c[1] - a[1]) / (c[0] - a[0])) * (x0 - a[0]));
                        for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                            pixSetHelp(x0, x1, a, inverseA, alpha, betaMinusAlpha, gammaMinusAlpha, rgb);
                        }
                    }
                }
                if (b[0] - a[0] != 0 && c[0] - b[0] != 0) {
                    for (int x0 = floor(c[0]) ; x0 < floor(b[0]) ; x0++) {
                        int bottom_x1 = ceil(a[1] + ((b[1] - a[1]) / (b[0] - a[0])) * (x0 - a[0]));
                        int top_x1 = floor(c[1] + ((c[1] - b[1]) / (c[0] - b[0])) * (x0 - c[0]));
                        for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                            pixSetHelp(x0, x1, a, inverseA, alpha, betaMinusAlpha, gammaMinusAlpha, rgb);
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
                            pixSetHelp(x0, x1, a, inverseA, alpha, betaMinusAlpha, gammaMinusAlpha, rgb);
                        }
                    }
                }
                if (c[0] - b[0] != 0 && c[0] - a[0] != 0) {
                    for (int x0 = floor(b[0]) ; x0 < floor(c[0]) ; x0++) {
                        int bottom_x1 = ceil(b[1] + ((c[1] - b[1]) / (c[0] - b[0])) * (x0 - b[0]));
                        int top_x1 = floor(a[1] + ((c[1] - a[1]) / (c[0] - a[0])) * (x0 - a[0]));
                        for (int x1 = bottom_x1 ;  x1 < top_x1 ; x1++) {
                            pixSetHelp(x0, x1, a, inverseA, alpha, betaMinusAlpha, gammaMinusAlpha, rgb);
                        }
                    }
                }
            }
}

/*
Reorders vertices such that A is the left most point
*/
void triRender(
        const double a[2], const double b[2], const double c[2], 
        const double rgb[3], const double alpha[3], const double beta[3], 
        const double gamma[3]) {
            if (a[0] <= b[0] && a[0] <= c[0]) {
                triRenderALeft(a, b, c, rgb, alpha, beta, gamma);
            } else if (b[0] <= c[0] && b[0] <= a[0]) {
                triRenderALeft(b, c, a, rgb, alpha, beta, gamma);
            } else {
                triRenderALeft(c, a, b, rgb, alpha, beta, gamma);
            }
        }