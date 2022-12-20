/*
    270mainDepth.c
    Demo showing triRender's new ability to neglect to render fragments outside the window.
	Includes 270triangle.c, which performs the check in triRenderHelper().
    Designed by Josh Davis for Carleton College's CS311 - Computer Graphics.
	Adapted by Cole Weinstein and Robbie Young.
*/

/* On macOS, compile with...
    clang 270mainDepth.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 270mainDepth.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#define WINDOWWIDTH 512
#define WINDOWHEIGHT 512

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GLFW/glfw3.h>

#include "040pixel.h"

#include "250vector.c"
#include "250matrix.c"
#include "150texture.c"
#include "260depth.c"
#include "260shading.c"
#include "270triangle.c"
#include "260mesh.c"
#include "190mesh2D.c"
#include "250mesh3D.c"

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
#define VARYS 3
#define VARYT 4
#define UNIFR 0
#define UNIFG 1
#define UNIFB 2
#define UNIFMODELING 3
#define TEXR 0
#define TEXG 1
#define TEXB 2
#define DEPTHRESET 1000.0

void shadeVertex(
        int unifDim, const double unif[], int attrDim, const double attr[], 
        int varyDim, double vary[]) {
	double attrHomog[4] = {attr[0], attr[1], attr[2], 1.0};
	mat441Multiply((double(*)[4])(&unif[UNIFMODELING]), attrHomog, vary);
	vary[VARYS] = attr[ATTRS];
	vary[VARYT] = attr[ATTRT];
}

void shadeFragment(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int varyDim, const double vary[], double rgbd[4]) {
	double sample[tex[0]->texelDim];
	texSample(tex[0], vary[VARYS], vary[VARYT], sample);
	vecModulate(3, sample, &unif[UNIFR], rgbd);
	rgbd[0] = sample[TEXR] * unif[UNIFR];
	rgbd[1] = sample[TEXG] * unif[UNIFG];
	rgbd[2] = sample[TEXB] * unif[UNIFB];
	rgbd[3] = (-1)*vary[VARYZ];
}

shaShading sha;
texTexture texture;
const texTexture *textures[1] = {&texture};
const texTexture **tex = textures;
meshMesh meshBox, meshSphere;
depthBuffer buf;
double unifBox[3 + 16] = {
    0.0, 1.0, 0.0, 
	1.0, 0.0, 0.0, 0.0, 
	0.0, 1.0, 0.0, 0.0, 
	0.0, 0.0, 1.0, 0.0, 
	0.0, 0.0, 0.0, 1.0};
double unifSphere[3 + 16] = {
    1.0, 0.0, 0.0, 
	1.0, 0.0, 0.0, 0.0, 
	0.0, 1.0, 0.0, 0.0, 
	0.0, 0.0, 1.0, 0.0, 
	0.0, 0.0, 0.0, 1.0};
double rotationAngle = 0.0;
double translationBox[3] = {0.0, 0.0, 0.0};
double translationSphere[3] = {0.0, 0.0, 0.0};

void render(void) {
	pixClearRGB(0.0, 0.0, 0.0);
	depthClearDepths(&buf, DEPTHRESET);
	meshRender(&meshBox, &buf, &sha, unifBox, tex);
	meshRender(&meshSphere, &buf, &sha, unifSphere, tex);
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
	rotationAngle += (newTime - oldTime);
	double isom[4][4];
	double rotation[3][3];
	double axis[3] = {1 / sqrt(2), 0, 1 / sqrt(2)};
	mat33AngleAxisRotation(rotationAngle, axis, rotation);
	mat44Isometry(rotation, translationBox, isom);
	vecCopy(16, (double *)isom, &unifBox[UNIFMODELING]);
	mat44Isometry(rotation, translationSphere, isom);
	vecCopy(16, (double *)isom, &unifSphere[UNIFMODELING]);
	render();
}

int main(void) {
	if (pixInitialize(WINDOWWIDTH, WINDOWHEIGHT, "Three Dimensions") != 0)
		return 1;
	if (texInitializeFile(&texture, "jondich.jpeg") != 0) {
	    pixFinalize();
		return 2;
	}
	if (mesh3DInitializeBox(&meshBox, -128.0, 128.0, -64.0, 64.0, -80.0, -48.0) != 0) {
	    texFinalize(&texture);
	    pixFinalize();
		return 3;
	}
	if (mesh3DInitializeSphere(&meshSphere, 64, 50, 50) != 0) {
	    meshFinalize(&meshBox);
		texFinalize(&texture);
	    pixFinalize();
		return 3;
	}
	if (depthInitialize(&buf, WINDOWWIDTH, WINDOWHEIGHT) != 0) {
		meshFinalize(&meshBox);
		meshFinalize(&meshSphere);
		texFinalize(&texture);
	    pixFinalize();
		return 4;
	}
    texSetFiltering(&texture, texNEAREST);
    texSetLeftRight(&texture, texREPEAT);
    texSetTopBottom(&texture, texREPEAT);
    sha.unifDim = 3 + 16;
    sha.attrDim = 3 + 2 + 3;
    sha.varyDim = 3 + 2;
    sha.shadeVertex = shadeVertex;
    sha.shadeFragment = shadeFragment;
    sha.texNum = 1;
    render();
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
	depthFinalize(&buf);
    meshFinalize(&meshSphere);
	meshFinalize(&meshBox);
    texFinalize(&texture);
    pixFinalize();
    return 0;
}