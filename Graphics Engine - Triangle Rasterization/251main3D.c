
/*
    251main3D.c
    Test version of 250main3D.c, demoing landscape mesh.
    Designed by Josh Davis for Carleton College's CS311 - Computer Graphics. 
	Adapted by Cole Weinstein and Robbie Young.
*/

/* On macOS, compile with...
    clang 251main3D.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 251main3D.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GLFW/glfw3.h>

#include "040pixel.h"

#include "250vector.c"
#include "250matrix.c"
#include "150texture.c"
#include "220shading.c"
#include "250triangle.c"
#include "220mesh.c"
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
	double attrHomog[4] = {attr[0], attr[1], attr[2], 1.0};
	mat441Multiply((double(*)[4])(&unif[UNIFMODELING]), attrHomog, vary);
	vary[VARYS] = attr[ATTRS];
	vary[VARYT] = attr[ATTRT];
}

void shadeFragment(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int varyDim, const double vary[], double rgb[3]) {
	double sample[tex[0]->texelDim];
	texSample(tex[0], vary[VARYS], vary[VARYT], sample);
	//vecModulate(3, sample, &unif[UNIFR], rgb);
	rgb[0] = sample[TEXR] * unif[UNIFR];
	rgb[1] = sample[TEXG] * unif[UNIFG];
	rgb[2] = sample[TEXB] * unif[UNIFB];
}

shaShading sha;
texTexture texture;
const texTexture *textures[1] = {&texture};
const texTexture **tex = textures;
meshMesh mesh;
double unif[3 + 16] = {
    1.0, 1.0, 1.0, 
	1.0, 0.0, 0.0, 0.0, 
	0.0, 1.0, 0.0, 0.0, 
	0.0, 0.0, 1.0, 0.0, 
	0.0, 0.0, 0.0, 1.0};
double rotationAngle = 0.0;
double translationVector[2] = {256.0, 256.0};

void render(void) {
	pixClearRGB(0.0, 0.0, 0.0);
	meshRender(&mesh, &sha, unif, tex);
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
	unif[UNIFR] = sin(newTime);
	unif[UNIFG] = cos(oldTime);
	rotationAngle += (newTime - oldTime);
	double isom[4][4];
	double rotation[3][3];
	double axis[3] = {1.0 / sqrt(3.0), 1.0 / sqrt(3.0), 1.0 / sqrt(3.0)};
	mat33AngleAxisRotation(rotationAngle, axis, rotation);
	mat44Isometry(rotation, translationVector, isom);
	vecCopy(16, (double *)isom, &unif[UNIFMODELING]);
	render();
}

int main(void) {
	if (pixInitialize(512, 512, "Three Dimensions") != 0)
		return 1;
	if (texInitializeFile(&texture, "jondich.jpeg") != 0) {
	    pixFinalize();
		return 2;
	}
	double zs[3][3] = {{100.0, 10.0,  70.0}, 
	                   { -60.0, 50.0,  30.0}, 
                       { 40.0, 30.0, -10.0}};
	if (mesh3DInitializeLandscape(&mesh, 3, 100.0, (double *)zs) != 0) {
	    texFinalize(&texture);
	    pixFinalize();
		return 3;
	}
    texSetFiltering(&texture, texNEAREST);
    texSetLeftRight(&texture, texREPEAT);
    texSetTopBottom(&texture, texREPEAT);
    sha.unifDim = 3 + 16;
    sha.attrDim = 3 + 2 + 3;
    sha.varyDim = 2 + 2;
    sha.shadeVertex = shadeVertex;
    sha.shadeFragment = shadeFragment;
    sha.texNum = 1;
    render();
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
    meshFinalize(&mesh);
    texFinalize(&texture);
    pixFinalize();
    return 0;
}