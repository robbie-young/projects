/*
    281mainViewProj.c
    Demo showing triRender's new ability to neglect to render fragments outside the window.
	Includes 270triangle.c, which performs the check in triRenderHelper().
    Designed by Josh Davis for Carleton College's CS311 - Computer Graphics.
	Adapted by Cole Weinstein and Robbie Young.
*/

/* On macOS, compile with...
    clang 281mainViewProj.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 281mainViewProj.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#define WINDOWWIDTH 512
#define WINDOWHEIGHT 512

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GLFW/glfw3.h>

#include "040pixel.h"

#include "250vector.c"
#include "280matrix.c"
#include "150texture.c"
#include "260depth.c"
#include "260shading.c"
#include "270triangle.c"
#include "280mesh.c"
#include "190mesh2D.c"
#include "250mesh3D.c"
#include "280camera.c"

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
#define UNIFR 0
#define UNIFG 1
#define UNIFB 2
#define UNIFMODELING 3
#define UNIFPROJECTION 19
#define TEXR 0
#define TEXG 1
#define TEXB 2
#define DEPTHRESET 1000.0

/* Outputs vary[] based on the other parameters, which are unaltered. Like 
shadeFragment, this function should not access any variables other than its 
parameters and any local variables that it declares. 

Currently, the first four elements of the vary[] output are X, Y, Z, and W.
(The fifth and six elements are then S and T texture coordinates.)*/
void shadeVertex(
        int unifDim, const double unif[], int attrDim, const double attr[], 
        int varyDim, double vary[]) {
	double attrHomog[4] = {attr[ATTRX], attr[ATTRY], attr[ATTRZ], 1.0};
	double modelHomog[4] = {0.0, 0.0, 0.0, 0.0};
	mat441Multiply((double(*)[4])(&unif[UNIFMODELING]), attrHomog, modelHomog);
	mat441Multiply((double(*)[4])(&unif[UNIFPROJECTION]), modelHomog, vary);
	vary[VARYS] = attr[ATTRS];
	vary[VARYT] = attr[ATTRT];
}

/* attr has already been interpolated from the vertex attributes. tex is an 
array of texNum elements, each of which is of type texTexture *. rgb is the 
output parameter. The other parameters should be self-explanatory. 

This function is not allowed to read from any variables other than its arguments and local 
variables. It is not allowed to write to any variables except for its rgb 
parameter and local variables. In particular, it cannot use any global 
variables. */
void shadeFragment(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int varyDim, const double vary[], double rgbd[4]) {
	double sample[tex[0]->texelDim];
	texSample(tex[0], vary[VARYS], vary[VARYT], sample);
	rgbd[0] = sample[TEXR] * 0.4 + unif[UNIFR] * 0.6;
	rgbd[1] = sample[TEXG] * 0.4 + unif[UNIFG] * 0.6;
	rgbd[2] = sample[TEXB] * 0.4 + unif[UNIFB] * 0.6;
	rgbd[3] = vary[VARYZ];
}

shaShading sha;
texTexture texture;
const texTexture *textures[1] = {&texture};
const texTexture **tex = textures;
meshMesh meshGround;
depthBuffer buf;
double unifGround[3 + 16 + 16] = {
    // uniform RGB
	0.0, 1.0, 0.0,
	// uniform modeling transformation
	1.0, 0.0, 0.0, 0.0,
	0.0, 1.0, 0.0, 0.0,
	0.0, 0.0, 1.0, 0.0,
	0.0, 0.0, 0.0, 1.0,
	// uniform projection transformation
	1.0, 0.0, 0.0, 0.0,
	0.0, 1.0, 0.0, 0.0,
	0.0, 0.0, 1.0, 0.0,
	0.0, 0.0, 0.0, 1.0};
double rotationAngle = -M_PI / 2.0;
double noTranslation[3] = {0.0, 0.0, 0.0};
double translationGround[3] = {0.0, -20.0, -25.0};
double viewport[4][4];
camCamera cam;

void render(void) {
	pixClearRGB(0.0, 0.0, 0.0);
	depthClearDepths(&buf, DEPTHRESET);
	meshRender(&meshGround, &buf, viewport, &sha, unifGround, tex);
	// depthFinalize(&buf);
	// meshFinalize(&meshGround);
    // texFinalize(&texture);
    // pixFinalize();
	// exit(0);
}

void handleKeyUp(
        int key, int shiftIsDown, int controlIsDown, int altOptionIsDown, 
        int superCommandIsDown) {
	if (key == GLFW_KEY_ENTER) {
		if (texture.filtering == texLINEAR)
			texSetFiltering(&texture, texNEAREST);
		else
			texSetFiltering(&texture, texLINEAR);
		render();
	}
}

void handleTimeStep(double oldTime, double newTime) {
	if (floor(newTime) - floor(oldTime) >= 1.0)
		printf("handleTimeStep: %f frames/sec\n", 1.0 / (newTime - oldTime));
	// double zIsom[4][4];
	double isom[4][4];
	double rotation[3][3];
	double xAxis[3] = {1.0, 0.0, 0.0};
	mat33AngleAxisRotation(rotationAngle, xAxis, rotation);
	mat44Isometry(rotation, translationGround, isom);
	vecCopy(16, (double *)isom, &unifGround[UNIFMODELING]);
	render();
}

int main(void) {
	if (pixInitialize(WINDOWWIDTH, WINDOWHEIGHT, "Three Dimensions") != 0)
		return 1;
	if (texInitializeFile(&texture, "jondich.jpg") != 0) {
	    pixFinalize();
		return 2;
	}
	if (mesh3DInitializeBox(&meshGround, -50.0, 50.0, -10.0, 10.0, -3.0, 3.0) != 0) {
	    texFinalize(&texture);
	    pixFinalize();
		return 3;
	}
	if (depthInitialize(&buf, WINDOWWIDTH, WINDOWHEIGHT) != 0) {
		meshFinalize(&meshGround);
		texFinalize(&texture);
	    pixFinalize();
		return 4;
	}
	camSetProjectionType(&cam, camORTHOGRAPHIC);
	camSetFrustum(&cam, M_PI/6.0, 10.0, 10.0, WINDOWWIDTH, WINDOWHEIGHT);
	double proj[4][4];
	camGetPerspective(&cam, proj);
	vecCopy(16, (double *)proj, &unifGround[UNIFPROJECTION]);
    texSetFiltering(&texture, texNEAREST);
    texSetLeftRight(&texture, texREPEAT);
    texSetTopBottom(&texture, texREPEAT);
    sha.unifDim = 3 + 16 + 16;
    sha.attrDim = 3 + 2 + 3;
    sha.varyDim = 4 + 2;
    sha.shadeVertex = shadeVertex;
    sha.shadeFragment = shadeFragment;
    sha.texNum = 1;
	mat44Viewport(WINDOWWIDTH, WINDOWHEIGHT, viewport);
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
	depthFinalize(&buf);
	meshFinalize(&meshGround);
    texFinalize(&texture);
    pixFinalize();
    return 0;
}