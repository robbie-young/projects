/*
110mainInterpolating.c

Author: Robbie Young
Date: 20/09/22
Use: For use in Carleton's CS331 Computer Graphics Course
Credit: Based off of provided file by Josh Davis
*/


/* On macOS, compile with...
    clang 110mainInterpolating.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 110mainInterpolating.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#include <stdio.h>
#include <math.h>
#include "040pixel.h"
#include "110triangle.c"

double a[2] = {144.0, -156.0};
double b[2] = {244.0, 244.0};
double c[2] = {-226.0, -226.0};
double rgb[3] = {0.0, 1.0, 1.0};
double angle = 0.0;
double alpha[3] = {1.0, 0.0, 0.0};
double beta[3] = {0.0, 1.0, 0.0};
double gamma[3] = {0.0, 0.0, 1.0};

void handleTimeStep(double oldTime, double newTime) {
    if (floor(newTime) - floor(oldTime) >= 1.0)
        printf("handleTimeStep: %f frames/sec\n", 1.0 / (newTime - oldTime));
    double transl[2] = {256.0, 256.0};
    double aa[2], bb[2], cc[2], rrggbb[3], rot[2][2];
    angle += (newTime - oldTime) / 10.0;
    mat22Rotation(angle, rot);
    mat221Multiply(rot, a, aa);
    mat221Multiply(rot, b, bb);
    mat221Multiply(rot, c, cc);
    vecAdd(2, transl, aa, aa);
    vecAdd(2, transl, bb, bb);
    vecAdd(2, transl, cc, cc);
    vecScale(3, (2.0 + sin(newTime)) / 3.0, rgb, rrggbb);
    pixClearRGB(0.0, 0.0, 0.0);
    triRender(aa, bb, cc, rrggbb, alpha, beta, gamma);
}

int main(void) {
    if (pixInitialize(512, 512, "Testing") != 0)
        return 1;
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
    pixFinalize();
    return 0;
}

