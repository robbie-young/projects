/*
    280mainViewProj.c
    Demo showcasing new camera and orthographic projection abilities.
    Designed by Josh Davis for Carleton College's CS311 - Computer Graphics.
	Adapted by Cole Weinstein and Robbie Young.
*/

/* On macOS, compile with...
    clang 280mainViewProj.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 280mainViewProj.c 040pixel.o -lglfw -lGL -lm -ldl
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
	double varyHomog[4] = {0.0, 0.0, 0.0, 0.0};
	mat441Multiply((double(*)[4])(&unif[UNIFMODELING]), attrHomog, varyHomog);
	mat441Multiply((double(*)[4])(&unif[UNIFPROJECTION]), varyHomog, vary);
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
	vecModulate(3, sample, &unif[UNIFR], rgbd);
	rgbd[0] = sample[TEXR] * unif[UNIFR];
	rgbd[1] = sample[TEXG] * unif[UNIFG];
	rgbd[2] = sample[TEXB] * unif[UNIFB];
	rgbd[3] = vary[VARYZ];
}

shaShading sha;
texTexture texture;
const texTexture *textures[1] = {&texture};
const texTexture **tex = textures;
meshMesh meshBox, meshSphere;
depthBuffer buf;
double unifBox[3 + 16 + 16] = {
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
double unifSphere[3 + 16 + 16] = {
	// uniform RGB
    1.0, 0.0, 0.0,
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
double rotationAngle = 0.0;
double translationBox[3] = {256.0, 256.0, 0.0}, translationSphere[3] = {256.0, 256.0, 0.0};
double viewport[4][4];
camCamera cam;
double viewingVolume[6] = {0.0, WINDOWWIDTH, 0.0, WINDOWHEIGHT, -200.0, -100.0};

void render(void) {
	pixClearRGB(0.0, 0.0, 0.0);
	depthClearDepths(&buf, DEPTHRESET);
	meshRender(&meshBox, &buf, viewport, &sha, unifBox, tex);
	meshRender(&meshSphere, &buf, viewport, &sha, unifSphere, tex);
	// depthFinalize(&buf);
    // meshFinalize(&meshSphere);
	// meshFinalize(&meshBox);
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
	// initialize a bunch of things, including the texture in use and each of the meshes.
if (pixInitialize(WINDOWWIDTH, WINDOWHEIGHT, "Three Dimensions") != 0)
		return 1;
	if (texInitializeFile(&texture, "jondich.jpeg") != 0) {
	    pixFinalize();
		return 2;
	}
	if (mesh3DInitializeBox(&meshBox, -128.0, 128.0, -64.0, 64.0, -70.0, -54.0) != 0) {
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
	
	// initializes the camera to the desired viewing volume.
	// in this demo, the camera captures an orthographic projection, with projection
	// parameters defined in the global array viewingVolume[].
	camSetProjectionType(&cam, camORTHOGRAPHIC);
	camSetProjection(&cam, viewingVolume);
	// the projection matrix is calculated in the camera, then copied to each of the meshes' uniforms.
	double proj[4][4];
	camGetOrthographic(&cam, proj);
	vecCopy(16, (double *)proj, &unifBox[UNIFPROJECTION]);
	vecCopy(16, (double *)proj, &unifSphere[UNIFPROJECTION]);
	// initializes the viewport matrix.
	mat44Viewport(WINDOWWIDTH, WINDOWHEIGHT, viewport);
    
	// sets texture settings.
	texSetFiltering(&texture, texNEAREST);
    texSetLeftRight(&texture, texREPEAT);
    texSetTopBottom(&texture, texREPEAT);
    
	// sets shaShading information.
	sha.unifDim = 3 + 16 + 16;
    sha.attrDim = 3 + 2 + 3;
    sha.varyDim = 4 + 2;
    sha.shadeVertex = shadeVertex;
    sha.shadeFragment = shadeFragment;
    sha.texNum = 1;
	
	// pixel functions that run while the window is open and make sub calls
	// to render the scene.
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
	
	// clean up everything once the window is closed.
	depthFinalize(&buf);
    meshFinalize(&meshSphere);
	meshFinalize(&meshBox);
    texFinalize(&texture);
    pixFinalize();
    return 0;
}