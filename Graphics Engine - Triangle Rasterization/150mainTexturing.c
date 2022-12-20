/*
    150mainTexturing.c
    Test main file for 140triangle.c and 150texture.c, demonstrating nearest-neighbor and linear
    filtering abilities with regards to texture mapping.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
    Adapted by Cole Weinstein and Robbie Young.
*/

/* On macOS, compile with...
    clang 150mainTexturing.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 150mainTexturing.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#include <stdio.h>
#include <math.h>
#include "040pixel.h"

#include "080vector.c"
#include "100matrix.c"
#include "150texture.c"
#include "140triangle.c"

double a[2] = {144.0, -156.0};
double b[2] = {244.0, 244.0};
double c[2] = {-226.0, -226.0};
double rgb[3] = {0.5, 1.0, 0.0};
double alpha[2] = {1.0, 0.0};
double beta[2] = {1.0, 1.0};
double _gamma[2] = {0.0, 1.0};
double angle = 0.0;
texTexture texture;

/* Changes filtering type between linear and nearest-neighbor when 'ENTER' key is pressed. */
void handleKeyUp(int key, int shiftIsDown, int controlIsDown,
        int altOptionIsDown, int superCommandIsDown) {
            if (key == GLFW_KEY_ENTER) {
                if ((&texture)->filtering == texLINEAR){
                    printf("Switching to Nearest-Neighbor Filtering.\n");
                    (&texture)->filtering = texNEAREST;
                } else {
                    printf("Switching to Linear Filtering.\n");
                    (&texture)->filtering = texLINEAR;
                }
            }    
        }

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
    vecCopy(3, rgb, rrggbb);
    pixClearRGB(0.0, 0.0, 0.0);
    triRender(aa, bb, cc, rrggbb, &texture, alpha, beta, _gamma);
}

int main(void) {
    if (pixInitialize(512, 512, "Interpolator >:)") != 0)
        return 1;
    // initializes texture.
    if (texInitializeFile(&texture, "./jondich.jpeg") != 0)
        return 1;
    // sets default filtering to nearest-neighbor.
    (&texture)->filtering = texNEAREST;
    pixSetTimeStepHandler(handleTimeStep);
    pixSetKeyUpHandler(handleKeyUp);
    pixRun();
    // cleans up texture.
    texFinalize(&texture);
    pixFinalize();
    return 0;
}