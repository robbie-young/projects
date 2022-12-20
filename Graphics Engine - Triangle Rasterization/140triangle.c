/*
    140triangle.c
    C file to rasterize a given triangle and render it with a given texture (modulated with a given color).
    Written by Cole Weinstein and Robbie Young for Carleton College's CS311 - Computer Graphics, taught by Josh Davis.
*/

/* Include statements go here. */
#include <stdio.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include "040pixel.h"

void createA(const double a[2], const double b[2], const double c[2], double m[2][2]) {
    double bMinusA[2];
    double cMinusA[2];
    vecSubtract(2, b, a, bMinusA);
    vecSubtract(2, c, a, cMinusA);
    mat22Columns(bMinusA, cMinusA, m);
}

void setPixelColor(
    const double x[2], const double a[2], const double invertedItpCoeffs[2][2], 
    const double alpha[2], const double betaMinusAlpha[2], const double gammaMinusAlpha[2], 
    const double rgb[3], const texTexture *tex) {
    // variables which depend on the position of x, and therefore need to be calculated every time setPixelColor() is called.
    double xMinusA[2];
    double pq[2];
    double smallVec1[2]; // represents p(beta - alpha)
    double smallVec2[2]; // represents q(gamma - alpha)
    double smallVecSum[2]; // represents smallVec1 + smallVec2
    double chi[2];  // interpolated texture coordinate for x
    double retrievedTexel[3]; // sampled texel at coordinates (chi[0], chi[1]) in texture
    double rrggbb[3]; // final rgb values for current pixel

    // computes p and q.
    vecSubtract(2, x, a, xMinusA);
    mat221Multiply(invertedItpCoeffs, xMinusA, pq);

    // linearly interpolates the color at current pixel.
    vecScale(2, pq[0], betaMinusAlpha, smallVec1);
    vecScale(2, pq[1], gammaMinusAlpha, smallVec2);
    vecAdd(2, smallVec1, smallVec2, smallVecSum);
    vecAdd(2, alpha, smallVecSum, chi);

    // retrieves texel at interpolated coordinates.
    texSample(tex, chi[0], chi[1], retrievedTexel);
    
    // modulates the interpolated color with the passed-in rgb color.
    vecModulate(3, retrievedTexel, rgb, rrggbb);

    //sets the pixel to the modulated color.
    pixSetRGB((int)x[0], (int)x[1], rrggbb[0], rrggbb[1], rrggbb[2]);
}

/* Given a triangle and knowledge of its left-most vertex, rasterizes the triangle and renders it. */
void triRenderHelper(
        const double a[2], const double b[2], const double c[2], 
        const double rgb[3], const texTexture *tex, const double alpha[2], 
        const double beta[2], const double gamma[2]) {
    
    // array for coordinates of current pixel. (used later)
    double x[2];
    x[0] = ceil(a[0]);
    
    // some variables used throughout the function (and calls to setPixelColor()) that do not require x[] and can be calculated immediately. these are used entirely in setPixelColor(), but we calculate them here to avoid a bunch of repeated calculations later.

    // creates the matrix A (to find p and q for the purposes of linear interpolation) and inverts it.
    double interpolateCoeffs[2][2];
    double invertedItpCoeffs[2][2];
    createA(a, b, c, interpolateCoeffs);
    mat22Invert(interpolateCoeffs, invertedItpCoeffs);

    // computes 'beta - alpha' and 'gamma - alpha', used later in linear interpolation calculations.
    double betaMinusAlpha[2];
    double gammaMinusAlpha[2];
    vecSubtract(2, beta, alpha, betaMinusAlpha);
    vecSubtract(2, gamma, alpha, gammaMinusAlpha);

    // now, we render the triangle. the first three cases deal with triangles which have
    // vertical sides and thus only require one horizontally iteratting loop. the vertically
    // iterating loop starts at the ceiling of the bottom edge, determined by the order of the
    // vertices, then runs until the floor of the top edge.
    
    // if a[0] == c[0], then the left edge (side ac) is vertical and we don't have to worry about rendering it.
    // since a -> b -> c is clockwise, we know a[1] < c[1].
    if (a[0] == c[0]) {
        while (x[0] <= floor(b[0])){
            x[1] = ceil(a[1] + (b[1]-a[1])/(b[0]-a[0])*(x[0]-a[0]));
            while (x[1] <= floor(c[1] + (b[1]-c[1])/(b[0]-c[0])*(x[0]-c[0]))) {
                setPixelColor(x, a, invertedItpCoeffs, alpha, betaMinusAlpha, gammaMinusAlpha, rgb, tex);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    // o.w., if a[0] == b[0], then the left edge (side ab) is vertical and we don't have to worry about rendering it.
    // sice a -> b -> c is clockwise, we know that a[1] > b[1].
    else if (a[0] == b[0]) {
        while (x[0] <= floor(c[0])){
            x[1] = ceil(b[1] + (c[1]-b[1])/(c[0]-b[0])*(x[0]-b[0]));
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0]))) {
                setPixelColor(x, a, invertedItpCoeffs, alpha, betaMinusAlpha, gammaMinusAlpha, rgb, tex);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    // o.w., if b[0] == c[0], then the right edge (side bc) is vertical and we don't have to worry about rendering it.
    // (can't be left edge this time since a known to be left-most vertex.)
    // sice a -> b -> c is clockwise, we know that c[1] > b[1].
    else if (b[0] == c[0]) {
        while (x[0] <= floor(c[0])){
            x[1] = ceil(a[1] + (b[1]-a[1])/(b[0]-a[0])*(x[0]-a[0]));
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0]))) {
                setPixelColor(x, a, invertedItpCoeffs, alpha, betaMinusAlpha, gammaMinusAlpha, rgb, tex);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    
    // the next two cases deal with triangles which have no vertical sides and thus require
    // two horizontally iterating loops. in summary, these loops together iterate over the
    // edge of the triangle covering the largest horizontal distance, and individually iterate
    // over the other two edges of the triangle, again, determined by the order of the vertices.
    
    // if b[0] < c[0], then loop from a[0] to c[0], reframing checks around b[0].
    else if (b[0] < c[0]) {
        while (x[0] <= floor(b[0])){
            x[1] = ceil(a[1] + (a[1]-b[1])/(a[0]-b[0])*(x[0]-a[0]));
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0]))) {
                setPixelColor(x, a, invertedItpCoeffs, alpha, betaMinusAlpha, gammaMinusAlpha, rgb, tex);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
        while (x[0] <= floor(c[0])){
            x[1] = ceil(c[1] + (c[1]-b[1])/(c[0]-b[0])*(x[0]-c[0]));
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0]))) {
                setPixelColor(x, a, invertedItpCoeffs, alpha, betaMinusAlpha, gammaMinusAlpha, rgb, tex);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    // o.w., c[0] < b[0], so loop from a[0] to b[0] and reframe checks around c[0].
    else {
        while (x[0] <= floor(c[0])){
            x[1] = ceil(a[1] + (b[1]-a[1])/(b[0]-a[0])*(x[0]-a[0]));
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0]))) {
                setPixelColor(x, a, invertedItpCoeffs, alpha, betaMinusAlpha, gammaMinusAlpha, rgb, tex);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
        while (x[0] <= floor(b[0])){
            x[1] = ceil(a[1] + (b[1]-a[1])/(b[0]-a[0])*(x[0]-a[0]));
            while (x[1] <= floor(b[1] + (c[1]-b[1])/(c[0]-b[0])*(x[0]-b[0]))) {
                setPixelColor(x, a, invertedItpCoeffs, alpha, betaMinusAlpha, gammaMinusAlpha, rgb, tex);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
}

/* Determines left-most vertex of a triangle and calls triRenderHelper() to render the triangle. */
void triRender(
        const double a[2], const double b[2], const double c[2], 
        const double rgb[3], const texTexture *tex, const double alpha[2], 
        const double beta[2], const double gamma[2]) {
    if (a[0] <= b[0] && a[0] <= c[0])
        triRenderHelper(a, b, c, rgb, tex, alpha, beta, gamma);
    else if(b[0] <= a[0] && b[0] <= c[0])
        triRenderHelper(b, c, a, rgb, tex, beta, gamma, alpha);
    else
        triRenderHelper(c, a, b, rgb, tex, gamma, alpha, beta);
}