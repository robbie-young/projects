/*
    320mainInterpolating.c
    A demonstration of how our current engine is affected by perspective bending.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/


/* On macOS, compile with...
    clang 320mainInterpolating.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 320mainInterpolating.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#define WINDOWWIDTH 512.0
#define WINDOWHEIGHT 512.0

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GLFW/glfw3.h>

#include "040pixel.h"

#include "250vector.c"
#include "280matrix.c"
#include "150texture.c"
#include "260shading.c"
#include "260depth.c"
#include "270triangle.c"
#include "280mesh.c"
#include "190mesh2D.c"
#include "250mesh3D.c"
#include "300isometry.c"
#include "300camera.c"

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
	vary[VARYS] = attr[ATTRS];
	vary[VARYT] = attr[ATTRT];
}

void shadeFragment(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int varyDim, const double vary[], double rgbd[4]) {
	double sample[tex[0]->texelDim];
	texSample(tex[0], vary[VARYS], vary[VARYT], sample);
	vecCopy(3, sample, rgbd);
	rgbd[3] = vary[VARYZ];
}

depthBuffer buf;
shaShading sha;
texTexture texture;
const texTexture *textures[1] = {&texture};
const texTexture **tex = textures;
meshMesh box;
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

void render(void) {
	pixClearRGB(1.0, 0.0, 1.0);
	depthClearDepths(&buf, 1000000000.0);
	double projInvIsom[4][4];
	camGetProjectionInverseIsometry(&cam, projInvIsom);
    vecCopy(16, (double *)projInvIsom, &unif[UNIFPROJINVISOM]);
	meshRender(&box, &buf, viewport, &sha, unif, tex);
}

void handleKeyUp(
        int key, int shiftIsDown, int controlIsDown, int altOptionIsDown, 
        int superCommandIsDown) {
	if (key == GLFW_KEY_ENTER) {
		if (texture.filtering == texLINEAR)
			texSetFiltering(&texture, texNEAREST);
		else
			texSetFiltering(&texture, texLINEAR);
	}
}

void handleTimeStep(double oldTime, double newTime) {
	if (floor(newTime) - floor(oldTime) >= 1.0)
		printf("handleTimeStep: %f frames/sec\n", 1.0 / (newTime - oldTime));
	render();
}

int main(void) {
    /* Marshal resources. */
	if (pixInitialize(512, 512, "Perspective Correction?") != 0)
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
	if (mesh3DInitializeBox(&box, -1.0, 1.0, -1.0, 1.0, -1.0, 1.0) != 0) {
	    texFinalize(&texture);
	    depthFinalize(&buf);
	    pixFinalize();
		return 3;
	}
	/* Configure texture. */
    texSetFiltering(&texture, texNEAREST);
    texSetLeftRight(&texture, texCLIP);
    texSetTopBottom(&texture, texCLIP);
    /* Configure shader program. */
    sha.unifDim = 16 + 16;
    sha.attrDim = 3 + 2 + 3;
    sha.varyDim = 4 + 2;
    sha.shadeVertex = shadeVertex;
    sha.shadeFragment = shadeFragment;
    sha.texNum = 1;
    /* Configure viewport and camera. */
    mat44Viewport(512, 512, viewport);
    camSetProjectionType(&cam, camPERSPECTIVE);
    camSetFrustum(&cam, M_PI / 6.0, 10.0, 10.0, 512, 512);
    double target[3] = {0.0, 0.0, 0.0};
    camLookAt(&cam, target, 10.0, M_PI / 3.0, M_PI / 4.0);
	/* Run user interface. */
    render();
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
    /* Clean up. */
    meshFinalize(&box);
    texFinalize(&texture);
    depthFinalize(&buf);
    pixFinalize();
    return 0;
}