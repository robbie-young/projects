/*
    241mainShadings.c
    *OBSELETE* A version of 240mainShadings, testing some other things.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/

/* On macOS, compile with...
    clang 241mainShadings.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 241mainShadings.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GLFW/glfw3.h>

#include "040pixel.h"

#include "080vector.c"
#include "230matrix.c"
#include "150texture.c"
#include "220shading.c"
/* New! We no longer need to include these files after shadeFragment and 
shadeVertex. So instead we include them up here. It's good C style to have all 
#includes in one section near the top of the file. */
#include "220triangle.c"
#include "220mesh.c"
#include "190mesh2D.c"

#define ATTRX 0
#define ATTRY 1
#define ATTRS 2
#define ATTRT 3
#define VARYX 0
#define VARYY 1
#define VARYS 2
#define VARYT 3
#define UNIFR 0
#define UNIFG 1
#define UNIFB 2
#define UNIFMODELING 3
#define TEXR 0
#define TEXG 1
#define TEXB 2

void shadeVertex(
        int unifDim, const double unif[], int attrDim, const double attr[], 
        int varyDim, double vary[]) {
    double attrHomog[3] = {attr[ATTRX], attr[ATTRY], 1};
    double varyHomog[3];
    mat331Multiply((double(*)[3])(&unif[UNIFMODELING]), attrHomog, varyHomog);
    vecCopy(2, varyHomog, vary);
    vary[VARYS] = attr[ATTRS];
    vary[VARYT] = attr[ATTRT];
}

void shadeFragment(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int varyDim, const double vary[], double rgb[3]) {
    double sample[tex[0]->texelDim];
    texSample(tex[0], vary[VARYS], vary[VARYT], sample);
    vecModulate(3, sample, &unif[UNIFR], rgb);
}

shaShading shaCarrot;
texTexture texCarrot;
const texTexture *textures[1] = {&texCarrot};
const texTexture **tex = textures;
meshMesh meshCarrot;
double unif[3 + 9] = {1.0, 1.0, 1.0};
double rotation = 0;
double translation[2] = {0.0, 0.0};

void render(void) {
    pixClearRGB(0.0, 0.0, 0.0);
    meshRender(&meshCarrot, &shaCarrot, unif, tex);
}

void handleKeyUp(
        int key, int shiftIsDown, int controlIsDown, int altOptionIsDown, 
        int superCommandIsDown) {
    if (key == GLFW_KEY_ENTER) {
        if (texCarrot.filtering == texLINEAR){
            texSetFiltering(&texCarrot, texNEAREST);
        }
        else {
            texSetFiltering(&texCarrot, texLINEAR);
        }
        render();
    }
}

void handleTimeStep(double oldTime, double newTime) {
    if (floor(newTime) - floor(oldTime) >= 1.0)
        printf("handleTimeStep: %f frames/sec\n", 1.0 / (newTime - oldTime));


    unif[UNIFR] = sin(newTime);
    unif[UNIFG] = cos(oldTime);
    double isom[3][3];
    mat33Isometry(rotation, translation, isom);
    vecCopy(9, (double *)isom, &unif[UNIFMODELING]);
    render();
}

int main(void) {
    if (pixInitialize(512, 512, "Shader Program") != 0)
        return 1;
    if (texInitializeFile(&texCarrot, "jondich.jepg") != 0) {
        pixFinalize();
        return 2;
    }
    if (mesh2DInitializeRectangle(&meshCarrot, 225.0, 275.0, 225.0, 275.0) != 0) {
        texFinalize(&texCarrot);
        pixFinalize();
        return 3;
    }
    
    texSetFiltering(&texCarrot, texNEAREST);
    texSetLeftRight(&texCarrot, texREPEAT);
    texSetTopBottom(&texCarrot, texREPEAT);

    shaCarrot.unifDim = 6;
    shaCarrot.attrDim = 4;
    shaCarrot.varyDim = 4;
    shaCarrot.texNum = 1;
    shaCarrot.shadeVertex = shadeVertex;
    shaCarrot.shadeFragment = shadeFragment;
    
    render();
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
    
    meshFinalize(&meshCarrot);
    texFinalize(&texCarrot);
    pixFinalize();
    return 0;
}