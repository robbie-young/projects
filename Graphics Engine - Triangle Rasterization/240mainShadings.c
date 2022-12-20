/*
    240mainShadings.c
    ---
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/

/* On macOS, compile with...
    clang 240mainShadings.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 240mainShadings.c 040pixel.o -lglfw -lGL -lm -ldl
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
#define MOVEHORI 0
#define MOVEVERT 1
#define CARROTTOP 528.0
#define CARROTBOTTOM 496.0
#define CARROTLEFT 496.0
#define CARROTRIGHT 528.0
#define JONDICHTOP 64.0
#define JONDICHBOTTOM 0.0
#define JONDICHLEFT 0.0
#define JONDICHRIGHT 64.0
#define JDAVISTOP 1024.0
#define JDAVISBOTTOM 960.0
#define JDAVISLEFT 960.0
#define JDAVISRIGHT 1024.0

void shadeVertexCarrot(
        int unifDim, const double unif[], int attrDim, const double attr[], 
        int varyDim, double vary[]) {
    double translatedAttrX = attr[ATTRX] - unif[UNIFMODELING+2];
    double translatedAttrY = attr[ATTRY] - unif[UNIFMODELING+5];
    double attrHomog[3] = {translatedAttrX, translatedAttrY, 1};
    double varyHomog[3];
    mat331Multiply((double(*)[3])(&unif[UNIFMODELING]), attrHomog, varyHomog);
    vecCopy(2, varyHomog, vary);
    vary[VARYS] = attr[ATTRS];
    vary[VARYT] = attr[ATTRT];
}

void shadeVertexProfs(
        int unifDim, const double unif[], int attrDim, const double attr[], 
        int varyDim, double vary[]) {
    double attrHomog[3] = {attr[ATTRX], attr[ATTRY], 1};
    double varyHomog[3];
    mat331Multiply((double(*)[3])(&unif[UNIFMODELING]), attrHomog, varyHomog);
    vecCopy(2, varyHomog, vary);
    vary[VARYS] = attr[ATTRS];
    vary[VARYT] = attr[ATTRT];
}

void shadeVertexWinCon(
    int unifDim, const double unif[], int attrDim, const double attr[],
    int varyDim, double vary[]) {
    vary[VARYX] = attr[ATTRX];
    vary[VARYY] = attr[ATTRY];
    vary[VARYS] = attr[ATTRS];
    vary[VARYT] = attr[ATTRT];
}

void shadeFragmentDefault(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int varyDim, const double vary[], double rgb[3]) {
    double sample[tex[0]->texelDim];
    texSample(tex[0], vary[VARYS], vary[VARYT], sample);
    vecModulate(3, sample, &unif[UNIFR], rgb);
}

void shadeFragmentWinCon(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int varyDim, const double vary[], double rgb[3]) {
    double sample[tex[0]->texelDim];
    texSample(tex[0], vary[VARYS], vary[VARYT], sample);
    for (int i = 0; i < tex[0]->texelDim; i++) {
        sample[i] = 1 - sample[i];
    }
    vecModulate(3, sample, &unif[UNIFR], rgb);
}

shaShading shaCarrot, shaProfs, shaWinCon;
texTexture texCarrot, texJondich, texJdavis, texWinCon;
const texTexture *textures[4] = {&texCarrot, &texJondich, &texJdavis, &texWinCon};
const texTexture **tex = textures;
meshMesh meshCarrot, meshJondich, meshJdavis, meshWinCon;
double unifCarrot[3 + 9] = {1.0, 1.0, 1.0};
double unifJondich[3 + 9] = {1.0, 1.0, 1.0};
double unifJdavis[3 + 9] = {1.0, 1.0, 1.0};
double unifWinCon[3] = {1.0, 1.0, 0.0};
double rotationCarrot = 0;
double rotationProfs = 0;
double translationCarrot[2] = {512.0, 512.0};
double translationJondich[2] = {0.0, 0.0};
double translationJdavis[2] = {0.0, 0.0};

int gameWon = 0;

int initializeTextures() {
    if (texInitializeFile(&texCarrot, "carrot.png") != 0) {
        return 2;
    }
    if (texInitializeFile(&texJondich, "jondich.jpeg") != 0) {
        texFinalize(&texCarrot);
        return 2;
    }
    if (texInitializeFile(&texJdavis, "jdavis.jpg") != 0) {
        texFinalize(&texCarrot);
        texFinalize(&texJondich);
        return 2;
    }
    if (texInitializeFile(&texWinCon, "winner.png") != 0) {
        texFinalize(&texCarrot);
        texFinalize(&texJondich);
        texFinalize(&texJdavis);
        return 2;
    }
    return 0;
}

int initializeMeshes() {
    if (mesh2DInitializeRectangle(&meshCarrot, CARROTLEFT, CARROTRIGHT, CARROTBOTTOM, CARROTTOP) != 0) {
        return 3;
    }
    if (mesh2DInitializeRectangle(&meshJondich, JONDICHLEFT, JONDICHRIGHT, JONDICHBOTTOM, JONDICHTOP) != 0) {
        meshFinalize(&meshCarrot);
        return 3;
    }
    if (mesh2DInitializeRectangle(&meshJdavis, JDAVISLEFT, JDAVISRIGHT, JDAVISBOTTOM, JDAVISTOP) != 0) {
        meshFinalize(&meshCarrot);
        meshFinalize(&meshJondich);
        return 3;
    }
    if (mesh2DInitializeRectangle(&meshWinCon, 256.0, 768.0, 448.0, 576.0) != 0) {
        meshFinalize(&meshCarrot);
        meshFinalize(&meshJondich);
        meshFinalize(&meshJdavis);
        return 3;
    }
    return 0;
}

void finalizeMeshes() {
    meshFinalize(&meshCarrot);
    meshFinalize(&meshJondich);
    meshFinalize(&meshJdavis);
    meshFinalize(&meshWinCon);
}

void finalizeTextures() {
    texFinalize(&texCarrot);
    texFinalize(&texJondich);
    texFinalize(&texJdavis);
    texFinalize(&texWinCon);
}

void setTextureSettings() {
    texSetFiltering(&texCarrot, texNEAREST);
    texSetLeftRight(&texCarrot, texREPEAT);
    texSetTopBottom(&texCarrot, texREPEAT);
    
    texSetFiltering(&texJondich, texNEAREST);
    texSetTopBottom(&texJondich, texREPEAT);
    texSetLeftRight(&texJondich, texREPEAT);

    texSetFiltering(&texJdavis, texNEAREST);
    texSetLeftRight(&texJdavis, texREPEAT);
    texSetTopBottom(&texJdavis, texREPEAT);

    texSetFiltering(&texWinCon, texNEAREST);
    texSetLeftRight(&texWinCon, texREPEAT);
    texSetTopBottom(&texWinCon, texREPEAT);
}

void setShadingSettings(shaShading *sha, int unifCount, int attrCount, int varyCount, int texCount, void (*v), void (*f)) {
    sha->unifDim = unifCount;
    sha->attrDim = attrCount;
    sha->varyDim = varyCount;
    sha->texNum = texCount;
    sha->shadeVertex = v;
    sha->shadeFragment = f;
}



void render(void) {
    pixClearRGB(0.0, 0.0, 0.0);
    meshRender(&meshCarrot, &shaCarrot, unifCarrot, tex);
    meshRender(&meshJondich, &shaProfs, unifJondich, &textures[1]);
    meshRender(&meshJdavis, &shaProfs, unifJdavis, &textures[2]);
}

void renderWinCon(void) {
    pixClearRGB(0.0, 0.0, 0.0);
    meshRender(&meshWinCon, &shaWinCon, unifWinCon, &textures[3]);
}

void handleKeyUp(
        int key, int shiftIsDown, int controlIsDown, int altOptionIsDown, 
        int superCommandIsDown) {
    if (gameWon == 1) {
        return;
    }
    if (key == GLFW_KEY_ENTER) {
        if (texCarrot.filtering == texLINEAR){
            texSetFiltering(&texCarrot, texNEAREST);
            texSetFiltering(&texJondich, texNEAREST);
            texSetFiltering(&texJdavis, texNEAREST);
        }
        else {
            texSetFiltering(&texCarrot, texLINEAR);
            texSetFiltering(&texJondich, texLINEAR);
            texSetFiltering(&texJdavis, texLINEAR);
        }
        render();
    }
    if (key == GLFW_KEY_W) {
        translationJondich[MOVEVERT] += 10;
    }
    if (key == GLFW_KEY_S) {
        translationJondich[MOVEVERT] -= 10;
    }
    if (key == GLFW_KEY_A) {
        translationJondich[MOVEHORI] -= 10;
    }
    if (key == GLFW_KEY_D) {
        translationJondich[MOVEHORI] += 10;
    }
    if (key == GLFW_KEY_UP) {
        translationJdavis[MOVEVERT] += 10;
    }
    if (key == GLFW_KEY_DOWN) {
        translationJdavis[MOVEVERT] -= 10;
    }
    if (key == GLFW_KEY_LEFT) {
        translationJdavis[MOVEHORI] -= 10;
    }
    if (key == GLFW_KEY_RIGHT) {
        translationJdavis[MOVEHORI] += 10;
    }
}

void checkWinCon() {
    double jondichTopPlusT = JONDICHTOP + translationJondich[MOVEVERT];
    double jondichBottomPlusT = JONDICHBOTTOM + translationJondich[MOVEVERT];
    double jondichRightPlusT = JONDICHRIGHT + translationJondich[MOVEHORI];
    double jondichLeftPlusT = JONDICHLEFT + translationJondich[MOVEHORI];
        
    double jdavisTopPlusT = JDAVISTOP + translationJdavis[MOVEVERT];
    double jdavisBottomPlusT = JDAVISBOTTOM + translationJdavis[MOVEVERT];
    double jdavisRightPlusT = JDAVISRIGHT + translationJdavis[MOVEHORI];
    double jdavisLeftPlusT = JDAVISLEFT + translationJdavis[MOVEHORI];

    if (((jondichTopPlusT > CARROTTOP && jondichBottomPlusT < CARROTTOP) 
     || (jondichTopPlusT > CARROTBOTTOM && jondichBottomPlusT < CARROTBOTTOM))
     && (jondichRightPlusT > CARROTRIGHT && jondichLeftPlusT < CARROTRIGHT)
     || (jondichRightPlusT > CARROTLEFT && jondichLeftPlusT < CARROTLEFT)) {
        printf("Jondich wins!\n");
        gameWon = 1;
    }

    else if (((jdavisTopPlusT > CARROTTOP && jdavisBottomPlusT < CARROTTOP) 
     || (jdavisTopPlusT > CARROTBOTTOM && jdavisBottomPlusT < CARROTBOTTOM))
     && (jdavisRightPlusT > CARROTRIGHT && jdavisLeftPlusT < CARROTRIGHT)
     || (jdavisRightPlusT > CARROTLEFT && jdavisLeftPlusT < CARROTLEFT)) {
        printf("Jdavis wins!\n");
        gameWon = 1;
    }
}

void handleTimeStep(double oldTime, double newTime) {
    if (gameWon == 1) {
        renderWinCon();
        return;
    }
    
    rotationCarrot += 0.1;
    double isom[3][3];
    mat33Isometry(rotationCarrot, translationCarrot, isom);
    vecCopy(9, (double *)isom, &unifCarrot[UNIFMODELING]);

    unifJondich[UNIFR] = sin(newTime);
    unifJondich[UNIFG] = cos(oldTime);
    mat33Isometry(0.0, translationJondich, isom);
    vecCopy(9, (double *)isom, &unifJondich[UNIFMODELING]);

    unifJdavis[UNIFG] = sin(newTime);
    unifJdavis[UNIFB] = cos(oldTime);
    mat33Isometry(0.0, translationJdavis, isom);
    vecCopy(9, (double *)isom, &unifJdavis[UNIFMODELING]);

    render();
    checkWinCon();
}

int main(void) {
    if (pixInitialize(1024, 1024, "Shader Program") != 0)
        return 1;
    if (initializeTextures() != 0) {
        pixFinalize();
        return 2;
    }
    if (initializeMeshes() != 0) {
        texFinalize(&texCarrot);
        texFinalize(&texJondich);
        texFinalize(&texJdavis);
        texFinalize(&texWinCon);
        pixFinalize();
        return 3;
    }
    
    setTextureSettings();

    setShadingSettings(&shaCarrot, 6, 4, 4, 1,shadeVertexCarrot, shadeFragmentDefault);
    setShadingSettings(&shaProfs, 6, 4, 4, 1, shadeVertexProfs, shadeFragmentDefault);
    setShadingSettings(&shaWinCon, 6, 4, 4, 1, shadeVertexWinCon, shadeFragmentWinCon);

    render();
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
    finalizeMeshes();
    finalizeTextures();
    pixFinalize();
    return 0;
}