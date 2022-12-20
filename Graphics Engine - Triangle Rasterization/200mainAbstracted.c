/*
    200mainAbstracted.c
    Implements rendering an image using a mesh. Attributes translated to varyings by shadeVertex().
    Adapted by Cole Weinstein and Robbie Young.
	Wrtten by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/


/* On macOS, compile with...
    clang 200mainAbstracted.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 200mainAbstracted.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GLFW/glfw3.h>

#include "040pixel.h"

#include "080vector.c"
#include "100matrix.c"
#include "150texture.c"
#include "200shading.c"

/* It is important that shadeFragment correctly parse the data that we give it. 
To help avoid errors in communication, we set up some constants. Notice that the 
documentation for the new triRender requires ATTRX to be 0 and ATTRY to be 1. */
#define ATTRX 0
#define ATTRY 1
#define ATTRS 2
#define ATTRT 3
#define ATTRR 4
#define ATTRG 5
#define ATTRB 6

#define VARYX 0
#define VARYY 1
#define VARYS 2
#define VARYT 3
#define VARYR 4
#define VARYG 5
#define VARYB 6

#define UNIFR 0
#define UNIFG 1
#define UNIFB 2
#define UNIFROT 3
#define UNIFTRANSLX 4
#define UNIFTRANSLY 5

/* attr has already been interpolated from the vertex attributes. tex is an 
array of texNum elements, each of which is of type texTexture *. rgb is the 
output parameter. The other parameters should be self-explanatory. This function 
is not allowed to read from any variables other than its arguments and local 
variables. It is not allowed to write to any variables except for its rgb 
parameter and local variables. In particular, it cannot use any global 
variables. */
void shadeFragment(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int varyDim, const double vary[], double rgb[3]) {
	// array used as output for modulating textures.
	double sample[3];
	// samples from each texture in tex and modulates each retrieved value.
	for (int i = 0; i < texNum; i++){
		texSample(tex[i], vary[VARYS], vary[VARYT], sample);
		vecModulate(3, sample, rgb, rgb);
	}

	// modulates the texture values with the values defined in the attribute array.
	double interpColor[3];
	vec3Set(vary[VARYR], vary[VARYG], vary[VARYB], interpColor);
	vecModulate(3, interpColor, rgb, rgb);

	// modulates the interpolated/sampled values with the uniform color.
	// stores final value in rgb.
	double unifColor[3];
	vec3Set(unif[UNIFR], unif[UNIFG], unif[UNIFB], unifColor);
	vecModulate(3, unifColor, rgb, rgb);
}

/* Outputs vary, based on the other parameters, which are unaltered. Like 
shadeFragment, this function should not access any variables other than its 
parameters and any local variables that it declares. */
void shadeVertex(
        int unifDim, const double unif[], int attrDim, const double attr[], 
        int varyDim, double vary[]) {
	double rot[2][2];
	mat22Rotation(unif[UNIFROT], rot);
	mat221Multiply(rot, attr, vary);
    vary[VARYX] += unif[UNIFTRANSLX];
    vary[VARYY] += unif[UNIFTRANSLY];
    vary[VARYS] = attr[ATTRS];
    vary[VARYT] = attr[ATTRT];
	vary[VARYR] = attr[ATTRR];
	vary[VARYG] = attr[ATTRG];
	vary[VARYB] = attr[ATTRB];
}

/* We have to include triangle.c after defining shadeFragment, because triRender 
refers to shadeFragment. (Later in the course we handle this issue better.) */
#include "200triangle.c"
#include "200mesh.c"

/* This struct is initialized in main() below. */
shaShading sha;
/* Here we make an array of one texTexture pointer, in such a way that the 
const qualifier can be enforced throughout the surrounding code. C is confusing 
for stuff like this. Don't worry about mastering C at this level. It doesn't 
come up much in our course. */
texTexture texture;
const texTexture *textures[1] = {&texture};
const texTexture **tex = textures;

meshMesh mesh;

void render(meshMesh *mesh, double unif[]) {
	// pixClearRGB(0.0, 0.0, 0.0);
	double a[7] = {50.0, 50.0, 1.0, 1.0, 1.0, 0.0, 0.0};
	double b[7] = {150.0, 50.0, 0.0, 1.0, 0.0, 1.0, 0.0};
	double c[7] = {200.0, 200.0, 0.0, 0.0, 0.0, 0.0, 1.0};
    double d[7] = {50.0, 150.0, 1.0, 0.0, 1.0, 1.0, 1.0};
	meshSetVertex(mesh, 0, a);
    meshSetVertex(mesh, 1, b);
    meshSetVertex(mesh, 2, c);
    meshSetVertex(mesh, 3, d);
    meshSetTriangle(mesh, 0, 0, 1, 2);
    meshSetTriangle(mesh, 1, 0, 2, 3);
	meshRender(mesh, &sha, unif, tex);
}

void handleKeyUp(int key, int shiftIsDown, int controlIsDown, 
		int altOptionIsDown, int superCommandIsDown) {
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
	double unif[6] = {1.0, 1.0, 1.0, ((sin(newTime)+1)*3.14), 250.0, 250.0};
	render(&mesh, unif);
}

int main(void) {
	if (pixInitialize(512, 512, "Abstracted") != 0)
		return 1;
	if (texInitializeFile(&texture, "./jondich.jpg") != 0) {
	    pixFinalize();
		return 2;
	}
    texSetFiltering(&texture, texNEAREST);
    texSetLeftRight(&texture, texREPEAT);
    texSetTopBottom(&texture, texREPEAT);
    sha.unifDim = 3;
    sha.varyDim = 2 + 2 + 3;
    sha.texNum = 1;
    if (meshInitialize(&mesh, 2, 4, sha.varyDim) != 0) {
        return 3;
	}
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
    meshFinalize(&mesh);
    texFinalize(&texture);
    pixFinalize();
    return 0;
}