/*
    310mainCamera.c
    Demo showcasing camera rotation and translation in the scene with user input.
	In designing our scene, we can now think of the camera as a tangible object to be moved around.
    Designed by Josh Davis for Carleton College's CS311 - Computer Graphics.
	Written by Cole Weinstein and Robbie Young.
*/

/* On macOS, compile with...
    clang 310mainCamera.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 310mainCamera.c 040pixel.o -lglfw -lGL -lm -ldl
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
#define UNIFR 0
#define UNIFG 1
#define UNIFB 2
#define UNIFMODELING 3
#define UNIFPROJINVISOM 19
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
	mat441Multiply((double(*)[4])(&unif[UNIFPROJINVISOM]), modelHomog, vary);
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
	rgbd[1] = sample[TEXG] * 0.05 + unif[UNIFG] * 0.95;
	rgbd[2] = sample[TEXB] * 0.05 + unif[UNIFB] * 0.95;
	rgbd[0] = sample[TEXR] * 0.05 + unif[UNIFR] * 0.95;
	rgbd[3] = vary[VARYZ];
}

shaShading sha;
texTexture texture;
const texTexture *textures[1] = {&texture};
const texTexture **tex = textures;
meshMesh meshGround, meshHouse, meshTrunk, meshLeaves;
depthBuffer buf;
double unifGround[3 + 16 + 16], unifHouse[3 + 16 + 16], unifTrunk[3 + 16 + 16], unifLeaves[3 + 16 + 16];
double rotationAngleScene = 0.0;
double rotationAngleHouse = M_PI/4.0;
double rotationAngleTrunk = -M_PI/2.0;
double rotationAngleLeaves = -M_PI/2.0;
double noTranslation[3] = {0.0, 0.0, 0.0};
double translationGround[3] = {0.0, -2.0, -12.0};
double translationHouse[3] = {-1.0, -0.8, -10.0};
double translationTrunk[3] = {1.4, -0.8, -12.0};
double translationLeaves[3] = {1.4, 0.2, -12.0};
double viewport[4][4];
double xAxis[3] = {1.0, 0.0, 0.0}, yAxis[3] = {0.0, 1.0, 0.0}, zAxis[3] = {0.0, 0.0, 1.0};
camCamera cam;
double rho = 10.0, phi = 0.0, theta = -M_PI / 2.0;
double target[3] = {0.0, 0.0, -10.0};

/* Helper function to initialize the unif matrix for a certain mesh, setting a default modeling and projection transformation and taking rgb values as inputs */
void initializeUnif(double r, double g, double b, double unif[]) {
	double unifCopy[3 + 16 + 16] = {
		// uniform RGB
		r, g, b,
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
	vecCopy(3 + 16 + 16, unifCopy, unif);
}

/* Helper function to set the camera projection and copy new projection matrix 
into the uniforms of each mesh. */
void updateCam() {
	camSetFrustum(&cam, M_PI/6.0, 10.0, 10.0, WINDOWWIDTH, WINDOWHEIGHT);
	camLookAt(&cam, target, rho, phi, theta);
	// projection matrix calculated in the camera, copied to each of the meshes' uniforms.
	double projInvIsom[4][4];
	camGetProjectionInverseIsometry(&cam, projInvIsom);
	vecCopy(16, (double *)projInvIsom, &unifGround[UNIFPROJINVISOM]);
	vecCopy(16, (double *)projInvIsom, &unifHouse[UNIFPROJINVISOM]);
	vecCopy(16, (double *)projInvIsom, &unifTrunk[UNIFPROJINVISOM]);
	vecCopy(16, (double *)projInvIsom, &unifLeaves[UNIFPROJINVISOM]);
}

void render(void) {
	pixClearRGB(0.0, 0.0, 0.0);
	depthClearDepths(&buf, DEPTHRESET);
	meshRender(&meshGround, &buf, viewport, &sha, unifGround, tex);
	meshRender(&meshHouse, &buf, viewport, &sha, unifHouse, tex);
	meshRender(&meshTrunk, &buf, viewport, &sha, unifTrunk, tex);
	meshRender(&meshLeaves, &buf, viewport, &sha, unifLeaves, tex);
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

	if (key == GLFW_KEY_P) {
		if (cam.projectionType == camORTHOGRAPHIC) {
			camSetProjectionType(&cam, camPERSPECTIVE);
			updateCam();
		} else {
			camSetProjectionType(&cam, camORTHOGRAPHIC);
			updateCam();
		}
	}

	if (key == GLFW_KEY_LEFT) {
		theta -= M_PI / 16.0;
		if (theta < -M_PI)
			theta += 2 * M_PI;
		updateCam();
	}

	if (key == GLFW_KEY_RIGHT) {
		theta += M_PI / 16.0;
		if (theta > M_PI)
			theta -= 2 * M_PI;
		updateCam();
	}

	if (key == GLFW_KEY_DOWN && phi > -M_PI / 4.0) {
		phi -= M_PI / 16.0;
		updateCam();
	}

	if (key == GLFW_KEY_UP && phi < M_PI / 4.0) {
		phi += M_PI / 16.0;
		updateCam();
	}

	if (key == GLFW_KEY_L && rho > 1.0) {
		rho -= 1.0;
		updateCam();
	}

	if (key == GLFW_KEY_O) {
		rho += 1;
		updateCam();
	}
}

void handleTimeStep(double oldTime, double newTime) {
	if (floor(newTime) - floor(oldTime) >= 1.0)
		printf("handleTimeStep: %f frames/sec\n", 1.0 / (newTime - oldTime));
	double isomGround[4][4], isomHouse[4][4], isomTrunk[4][4], isomLeaves[4][4];
	double rotationScene[3][3], rotationHouse[3][3], rotationTrunk[3][3], rotationLeaves[3][3];
	
	mat33AngleAxisRotation(rotationAngleScene, xAxis, rotationScene);
	
	mat44Isometry(rotationScene, translationGround, isomGround);
	vecCopy(16, (double *)isomGround, &unifGround[UNIFMODELING]);
	
	mat33AngleAxisRotation(rotationAngleHouse, yAxis, rotationHouse);
	mat44Isometry(rotationHouse, translationHouse, isomHouse);
	vecCopy(16, (double *)isomHouse, &unifHouse[UNIFMODELING]);
	
	mat33AngleAxisRotation(rotationAngleTrunk, xAxis, rotationTrunk);
	mat44Isometry(rotationTrunk, translationTrunk, isomTrunk);
	vecCopy(16, (double *)isomTrunk, &unifTrunk[UNIFMODELING]);
	
	mat33AngleAxisRotation(rotationAngleLeaves, xAxis, rotationLeaves);
	mat44Isometry(rotationLeaves, translationLeaves, isomLeaves);
	vecCopy(16, (double *)isomLeaves, &unifLeaves[UNIFMODELING]);

	render();
}

void finalizeAll(
		int finalizeTexture, texTexture *texList[], int texCount, 
		int finalizeMesh, meshMesh *meshList[], int meshCount, int finalizeDepth) {
	
	if (finalizeDepth == 1) {
		depthFinalize(&buf);
	}

	if (finalizeMesh == 1) {
		for (int i = 0 ; i < meshCount ; i++) {
			meshFinalize(meshList[i]);
		}
	}
	
	if (finalizeTexture == 1) {
		for (int i = 0 ; i < texCount ; i++) {
			texFinalize(texList[i]);
		}
	}
    
    pixFinalize();
}

int main(void) {
	// initialize a bunch of things, including the texture in use and each of the meshes.
	int texCount = 0, meshCount = 0;
	texTexture *texList[1];
	meshMesh *meshList[5];
	if (pixInitialize(WINDOWWIDTH, WINDOWHEIGHT, "Three Dimensions") != 0)
		return 1;
	if (texInitializeFile(&texture, "jondich.jpg") != 0) {
	    finalizeAll(0, texList, texCount, 0, meshList, meshCount, 0);
		return 2;
	}
	texList[texCount] = &texture;
	texCount += 1;
	if (mesh3DInitializeBox(&meshGround, -3.0, 3.0, -0.6, 0.6, -3.0, 3.0) != 0) {
	    finalizeAll(1, texList, texCount, 0, meshList, meshCount, 0);
		return 3;
	}
	meshList[meshCount] = &meshGround;
	meshCount += 1;
	if (mesh3DInitializeBox(&meshHouse, -0.6, 0.6, -0.6, 0.6, -0.6, 0.6) != 0) {
		finalizeAll(1, texList, texCount, 1, meshList, meshCount, 0);
		return 4;
	}
	meshList[meshCount] = &meshHouse;
	meshCount += 1;
	if (mesh3DInitializeCylinder(&meshTrunk, .25, 2, 30) != 0) {
		finalizeAll(1, texList, texCount, 1, meshList, meshCount, 0);
		return 5;
	}
	meshList[meshCount] = &meshTrunk;
	meshCount += 1;
	if (mesh3DInitializeSphere(&meshLeaves, .6, 15, 15) != 0) {
		finalizeAll(1, texList, texCount, 1, meshList, meshCount, 0);
		return 5;
	}
	meshList[meshCount] = &meshLeaves;
	meshCount += 1;
		if (depthInitialize(&buf, WINDOWWIDTH, WINDOWHEIGHT) != 0) {
		finalizeAll(1, texList, texCount, 1, meshList, meshCount, 0);
		return 4;
	}

	// sets texture settings.
	texSetFiltering(&texture, texNEAREST);
    texSetLeftRight(&texture, texCLIP);
    texSetTopBottom(&texture, texCLIP);
    
	// sets shaShading information.
	sha.unifDim = 3 + 16 + 16;
    sha.attrDim = 3 + 2 + 3;
    sha.varyDim = 4 + 2;
    sha.shadeVertex = shadeVertex;
    sha.shadeFragment = shadeFragment;
    sha.texNum = 1;

	// initialize the uniforms for each mesh.
	initializeUnif(0.3, 1.0, 0.3, unifGround);
	initializeUnif(1.0, 0.3, 0.5, unifHouse);
	initializeUnif(0.8, 0.5, 0.2, unifTrunk);
	initializeUnif(0.6, 1.0, 0.6, unifLeaves);

	// initializes the camera to the desired viewing volume.
	// in this demo, the camera captures an perspective projection, with projection
	// parameters defined by camSetFrustum().
	// the user can change the projection type by pressing the 'P' key.
	camSetProjectionType(&cam, camPERSPECTIVE);
	updateCam();
    // initializes the viewport matrix.
	mat44Viewport(WINDOWWIDTH, WINDOWHEIGHT, viewport);
	
	// pixel functions that run while the window is open and make sub calls
	// to render the scene.	
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
	
	// clean up everything once the window is closed.
	finalizeAll(1, texList, texCount, 1, meshList, meshCount, 1);
    return 0;
}