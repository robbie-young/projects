/*
    180mainEffect.c
    Demos an alternative implementation of shadeFragment which takes two textures, jondich.jpeg and
	rastley.jpeg, and combines them with interpolated color.
    Wrtten by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/


/* On macOS, compile with...
    clang 180mainEffect.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 180mainEffect.c 040pixel.o -lglfw -lGL -lm -ldl
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <GLFW/glfw3.h>

#include "040pixel.h"

#include "080vector.c"
#include "100matrix.c"
#include "150texture.c"
#include "170shading.c"

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
#define UNIFR 0
#define UNIFG 1
#define UNIFB 2
#define TEXR 0
#define TEXG 1
#define TEXB 2

/* attr has already been interpolated from the vertex attributes. tex is an 
array of texNum elements, each of which is of type texTexture *. rgb is the 
output parameter. The other parameters should be self-explanatory. This function 
is not allowed to read from any variables other than its arguments and local 
variables. It is not allowed to write to any variables except for its rgb 
parameter and local variables. In particular, it cannot use any global 
variables. */
void shadeFragment(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        int attrDim, const double attr[], double rgb[3]) {
	// 2 arrays used as output for sampling textures.
	double sample1[3];
	double sample2[3];

	// samples from two textures and scales each to a value corresponding to the texture's
	// desired influence on the final image.
	texSample(tex[0], attr[ATTRS], attr[ATTRT], sample1);
	vecScale(3, 0.5, sample1, sample1);
	texSample(tex[1], attr[ATTRS], attr[ATTRT], sample2);
	vecScale(3, 0.5, sample2, sample2);
	vecAdd(3, sample1, sample2, rgb);

	// modulates the texture values with the values defined in the attribute array.
	double interpColor[3];
	vec3Set(attr[ATTRR], attr[ATTRG], attr[ATTRB], interpColor);
	vecModulate(3, interpColor, rgb, rgb);

	// modulates the interpolated/sampled values with the uniform color.
	// stores final value in rgb.
	double unifColor[3];
	vec3Set(unif[UNIFR], unif[UNIFG], unif[UNIFB], unifColor);
	vecModulate(3, unifColor, rgb, rgb);
}

/* We have to include triangle.c after defining shadeFragment, because triRender 
refers to shadeFragment. (Later in the course we handle this issue better.) */
#include "170triangle.c"

/* This struct is initialized in main() below. */
shaShading sha;
/* Here we make an array of one texTexture pointer, in such a way that the 
const qualifier can be enforced throughout the surrounding code. C is confusing 
for stuff like this. Don't worry about mastering C at this level. It doesn't 
come up much in our course. */
texTexture texture1;
texTexture texture2;
const texTexture *textures[2] = {&texture1, &texture2};
const texTexture **tex = textures;

void render(void) {
	pixClearRGB(0.0, 0.0, 0.0);
	double a[7] = {0.0, 512.0, 0.0, 0.0, 1.0, 0.0, 0.0};
	double b[7] = {512.0, 0.0, 1.0, 0.0, 0.0, 1.0, 0.0};
	double c[7] = {512.0, 512.0, 0.5, 1.0, 0.0, 0.0, 1.0};
	double unif[3] = {1.0, 1.0, 1.0};

	triRender(&sha, unif, tex, a, b, c);
}

void handleKeyUp(int key, int shiftIsDown, int controlIsDown, 
		int altOptionIsDown, int superCommandIsDown) {
	if (key == GLFW_KEY_ENTER) {
		if (texture1.filtering == texLINEAR){
			texSetFiltering(&texture1, texNEAREST);
			texSetFiltering(&texture2, texNEAREST);
		}
		else {
			texSetFiltering(&texture1, texLINEAR);
			texSetFiltering(&texture2, texLINEAR);
		}
		render();
	}
}

void handleTimeStep(double oldTime, double newTime) {
	if (floor(newTime) - floor(oldTime) >= 1.0)
		printf("handleTimeStep: %f frames/sec\n", 1.0 / (newTime - oldTime));
	
	
}

int main(void) {
	if (pixInitialize(512, 512, "Abstracted") != 0)
		return 1;
	if (texInitializeFile(&texture1, "./jondich.jpeg") != 0) {
	    pixFinalize();
		return 2;
	}
	if (texInitializeFile(&texture2, "./rastley.jpeg") != 0) {
	    pixFinalize();
		return 3;
	}
    texSetFiltering(&texture1, texNEAREST);
    texSetLeftRight(&texture1, texREPEAT);
    texSetTopBottom(&texture1, texREPEAT);
	texSetFiltering(&texture2, texNEAREST);
    texSetLeftRight(&texture2, texREPEAT);
    texSetTopBottom(&texture2, texREPEAT);
    sha.unifDim = 3;
    sha.attrDim = 2 + 2 + 3;
    sha.texNum = 1;
    render();
    pixSetKeyUpHandler(handleKeyUp);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
    texFinalize(&texture1);
	texFinalize(&texture2);
    pixFinalize();
    return 0;
}