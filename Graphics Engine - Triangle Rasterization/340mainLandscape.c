/*
	340mainLandscape.c
	A demo 
*/


/* On macOS, compile with...
    clang 340mainLandscape.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 340mainLandscape.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#define WINDOWWIDTH 512.0
#define WINDOWHEIGHT 512.0

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include <time.h>

#include "040pixel.h"

#include "250vector.c"
#include "280matrix.c"
#include "150texture.c"
#include "260shading.c"
#include "260depth.c"
#include "270triangle.c"
#include "330mesh.c"
#include "190mesh2D.c"
#include "250mesh3D.c"
#include "300isometry.c"
#include "300camera.c"
#include "340landscape.c"

#define LANDSIZE 40

#define ATTRX 0
#define ATTRY 1
#define ATTRZ 2
#define ATTRS 3
#define ATTRT 4
#define ATTRN 5
#define ATTRO 6
#define ATTRP 7
#define VARYX 0
#define VARYY 1
#define VARYZ 2
#define VARYW 3
#define VARYS 4
#define VARYT 5
#define VARYN 6
#define VARYO 7
#define VARYP 8
#define UNIFMODELING 0
#define UNIFPROJINVISOM 16
#define TEXR 0
#define TEXG 1
#define TEXB 2

/* The first four entries of vary are assumed to be X, Y, Z, W. */
void shadeVertex(
        int unifDim, const double unif[], int attrDim, const double attr[], 
        int varyDim, double vary[]) {
	double attrHomog[4] = {attr[ATTRX], attr[ATTRY], attr[ATTRZ], 1.0};
	double modHomog[4];
	mat441Multiply((double(*)[4])(&unif[UNIFMODELING]), attrHomog, modHomog);
	mat441Multiply((double(*)[4])(&unif[UNIFPROJINVISOM]), modHomog, vary);
	vecCopy(5, &attr[ATTRS], &vary[VARYS]);
}

void shadeFragment(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int varyDim, const double vary[], double rgbd[4]) {
	double sample[tex[0]->texelDim];
	texSample(tex[0], vary[VARYS], vary[VARYT], sample);
	sample[0] = sample[1] * 0.2 + 0.8;
	sample[1] = sample[1] * 0.2 + 0.6;
	sample[2] = 0.3;
	double intensity = vary[VARYP] / vecLength(3, &vary[VARYN]);
	vecScale(3, intensity, sample, rgbd);
	rgbd[3] = vary[VARYZ];
}

depthBuffer buf;
shaShading sha;
texTexture texture;
const texTexture *textures[1] = {&texture};
const texTexture **tex = textures;
meshMesh landMesh;
double unif[16 + 16] = {
	1.0, 0.0, 0.0, 0.0, 
	0.0, 1.0, 0.0, 0.0, 
	0.0, 0.0, 1.0, 0.0, 
	0.0, 0.0, 0.0, 1.0, 
	1.0, 0.0, 0.0, 0.0, 
	0.0, 1.0, 0.0, 0.0, 
	0.0, 0.0, 1.0, 0.0, 
	0.0, 0.0, 0.0, 1.0};
double viewport[4][4];
camCamera cam;
double angle = M_PI * 0.25;

void render(void) {
	pixClearRGB(0.8, 0.8, 1.0);
	depthClearDepths(&buf, 1000000000.0);
	double projInvIsom[4][4];
	camGetProjectionInverseIsometry(&cam, projInvIsom);
    vecCopy(16, (double *)projInvIsom, &unif[UNIFPROJINVISOM]);
	meshRender(&landMesh, &buf, viewport, &sha, unif, tex);
}

void handleKeyUp(
        int key, int shiftIsDown, int controlIsDown, int altOptionIsDown, 
        int superCommandIsDown) {
	if (key == GLFW_KEY_ENTER) {
		if (texture.filtering == texLINEAR)
			texSetFiltering(&texture, texNEAREST);
		else
			texSetFiltering(&texture, texLINEAR);
	} else if (key == GLFW_KEY_P) {
	    if (cam.projectionType == camORTHOGRAPHIC)
		    camSetProjectionType(&cam, camPERSPECTIVE);
		else
		    camSetProjectionType(&cam, camORTHOGRAPHIC);
        camSetFrustum(&cam, M_PI / 6.0, 10.0, 10.0, 512, 512);
	}
}

void handleKeyDownAndRepeat(
        int key, int shiftIsDown, int controlIsDown, int altOptionIsDown, 
        int superCommandIsDown) {
    double position[3];
    vecCopy(3, cam.isometry.translation, position);
    if (key == GLFW_KEY_W) {
        double delta[3] = {cos(angle), sin(angle), 0.0};
        vecAdd(3, position, delta, position);
    } else if (key == GLFW_KEY_S) {
        double delta[3] = {cos(angle), sin(angle), 0.0};
        vecSubtract(3, position, delta, position);
    } else if (key == GLFW_KEY_A)
        angle += M_PI / 12.0;
    else if (key == GLFW_KEY_D)
        angle -= M_PI / 12.0;
    else if (key == GLFW_KEY_Q)
        position[2] -= 1.0;
    else if (key == GLFW_KEY_E)
        position[2] += 1.0;
    camLookFrom(&cam, position, M_PI * 0.6, angle);
}

void handleTimeStep(double oldTime, double newTime) {
	if (floor(newTime) - floor(oldTime) >= 1.0)
		printf("handleTimeStep: %f frames/sec\n", 1.0 / (newTime - oldTime));
	render();
}

int main(void) {
    /* Randomly generate a grid of elevation data. */
    double landData[LANDSIZE * LANDSIZE];
    landFlat(LANDSIZE, landData, 0.0);
    time_t t;
	srand((unsigned)time(&t));
    for (int i = 0; i < 12; i += 1)
		landFaultRandomly(LANDSIZE, (double *)landData, 1.0 - i * 0.04);
	for (int i = 0; i < 4; i += 1)
		landBlur(LANDSIZE, (double *)landData);
	for (int i = 0; i < 4; i += 1)
		landBump(LANDSIZE, (double *)landData, landInt(0, LANDSIZE - 1), 
		    landInt(0, LANDSIZE - 1), 5.0, 1.0);
    /* Marshal resources. */
	if (pixInitialize(512, 512, "Landscape") != 0)
		return 1;
	if (depthInitialize(&buf, 512, 512) != 0) {
	    pixFinalize();
		return 5;
	}
	if (texInitializeFile(&texture, "awesome.png") != 0) {
	    depthFinalize(&buf);
	    pixFinalize();
		return 2;
	}
	if (mesh3DInitializeLandscape(&landMesh, LANDSIZE, 1.0, landData) != 0) {
	    texFinalize(&texture);
	    depthFinalize(&buf);
	    pixFinalize();
		return 3;
	}
	/* Manually re-assign texture coordinates. */
	for (int i = 0; i < landMesh.vertNum; i += 1) {
	    double *vertPtr = meshGetVertexPointer(&landMesh, i);
	    double attr[landMesh.attrDim];
	    vecCopy(landMesh.attrDim, vertPtr, attr);
	    attr[ATTRS] = 0.0;
	    attr[ATTRT] = attr[ATTRZ];
	    meshSetVertex(&landMesh, i, attr);
	}
	/* Configure texture. */
    texSetFiltering(&texture, texNEAREST);
    texSetLeftRight(&texture, texREPEAT);
    texSetTopBottom(&texture, texREPEAT);
    /* Configure shader program. */
    sha.unifDim = 16 + 16;
    sha.attrDim = 3 + 2 + 3;
    sha.varyDim = 4 + 2 + 3;
    sha.shadeVertex = shadeVertex;
    sha.shadeFragment = shadeFragment;
    sha.texNum = 1;
    /* Configure viewport and camera. */
    mat44Viewport(512, 512, viewport);
    camSetProjectionType(&cam, camPERSPECTIVE);
    camSetFrustum(&cam, M_PI / 6.0, 10.0, 10.0, 512, 512);
    double position[3] = {-5.0, -5.0, 20.0};
    camLookFrom(&cam, position, M_PI * 0.6, angle);
	/* Run user interface. */
    render();
    pixSetKeyDownHandler(handleKeyDownAndRepeat);
    pixSetKeyRepeatHandler(handleKeyDownAndRepeat);
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
    /* Clean up. */
    meshFinalize(&landMesh);
    texFinalize(&texture);
    depthFinalize(&buf);
    pixFinalize();
    return 0;
}