/* 
    150texture.c
    Defines information about a texture struct and provides methods to modify and interact 
    with said texture. Near identical copy of 140texture.c, but implements linear filtering.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
    Adapted by Cole Weintstein and Robbie Young
*/


/*** Public: For header file ***/

/* These are constants that are set at compile time. For example, whenever the 
compiler sees 'texLINEAR', it will substitute '0'. Let me emphasize: texLINEAR 
is not a variable. It does not occupy any memory in your running program, and 
your program cannot change its value. We use such constants to avoid having 
'magic numbers' sprinkled throughout our code. */
#define texLINEAR 0
#define texNEAREST 1
#define texREPEAT 2
#define texCLIP 3

typedef struct texTexture texTexture;
/* Feel free to read from this struct's members, but don't write to them. */
struct texTexture {
    int width, height;  /* do not have to be powers of 2 */
    int texelDim;       /* e.g. 3 for RGB textures */
    int filtering;      /* texLINEAR or texNEAREST */
    int topBottom;      /* texREPEAT or texCLIP */
    int leftRight;      /* texREPEAT or texCLIP */
    double *data;       /* width * height * texelDim doubles, row-major order */
};



/*** Private ***/

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
#define STBI_FAILURE_USERMSG



/*** Public: Basics ***/

/* Sets all texels within the texture. Assumes that the texture has already 
been initialized. Assumes that texel has the same texel dimension as the 
texture. */
void texClearTexels(texTexture *tex, const double texel[]) {
    int index, bound, k;
    bound = tex->texelDim * tex->width * tex->height;
    for (index = 0; index < bound; index += tex->texelDim)
        for (k = 0; k < tex->texelDim; k += 1)
            tex->data[index + k] = texel[k];
}

/* Initializes a texTexture struct to a given width and height and a solid 
color. The width and height do not have to be powers of 2. Returns 0 if no 
error occurred. The user must remember to call texFinalize when finished with 
the texture. */
int texInitializeSolid(
        texTexture *tex, int width, int height, int texelDim, 
        const double texel[]) {
    tex->width = width;
    tex->height = height;
    tex->texelDim = texelDim;
    tex->data = (double *)malloc(width * height * texelDim * sizeof(double));
    if (tex->data == NULL) {
        fprintf(stderr, "error: texInitializeSolid: malloc failed\n");
        return 1;
    }
    texClearTexels(tex, texel);
    return 0;
}

/* Initializes a texTexture struct by loading an image from a file. Many image 
types are supported (using the public-domain STB Image library). The width and 
height do not have to be powers of 2. Returns 0 if no error occurred. The user 
must remember to call texFinalize when finished with the texture. */
/* WARNING: Currently there is a weird behavior, in which some image files show 
up with their rows and columns switched, so that their width and height are 
flipped. If that's happening with your image, then use a different image. */
int texInitializeFile(texTexture *tex, const char *path) {
    /* Use the STB image library to load the file as unsigned chars. */
    unsigned char *rawData;
    int x, y, z, newInd, oldInd;
    rawData = stbi_load(path, &(tex->width), &(tex->height), &(tex->texelDim), 
        0);
    if (rawData == NULL) {
        fprintf(stderr, "error: texInitializeFile: failed to load image %s\n", 
            path);
        fprintf(stderr, "    with STB Image reason: %s\n", stbi_failure_reason());
        return 2;
    }
    tex->data = (double *)malloc((tex->width * tex->height) * tex->texelDim * sizeof(double));
    if (tex->data == NULL) {
        fprintf(stderr, "error: texInitializeFile: malloc failed\n");
        stbi_image_free(rawData);
        return 1;
    }
    /* STB Image starts in the upper-left, while I want the lower-left. */
    for (x = 0; x < tex->width; x += 1)
        for (y = 0; y < tex->height; y += 1) {
            newInd = tex->texelDim * (x + tex->width * y);
            oldInd = tex->texelDim * (x + tex->width * (tex->height - 1 - y));
            for (z = 0; z < tex->texelDim; z += 1)
                tex->data[newInd + z] = rawData[oldInd + z] / 255.0;
        }
    stbi_image_free(rawData);
    return 0;
}

/*
For image files with their rows and columns switched, we must use this code 
instead. I'm not sure how to detect this case. So only the other case is 
handled in the code above.
    rawData = stbi_load(path, &(tex->height), &(tex->width), &(tex->texelDim), 0);
    ...
    newInd = tex->texelDim * (x + tex->width * y);
    oldInd = tex->texelDim * (tex->height * (tex->width - x + 1) - y);
*/

/* Sets the texture filtering, to either texNEAREST or texLINEAR. */
void texSetFiltering(texTexture *tex, int filtering) {
    tex->filtering = filtering;
}

/* Sets the texture wrapping for the top and bottom edges, to either texCLIP 
or texREPEAT. */
void texSetTopBottom(texTexture *tex, int topBottom) {
    tex->topBottom = topBottom;
}

/* Sets the texture wrapping for the left and right edges, to either texCLIP 
or texREPEAT. */
void texSetLeftRight(texTexture *tex, int leftRight) {
    tex->leftRight = leftRight;
}

/* Gets a single texel within the texture. Assumes that texel has the same texel 
dimension as the texture. Texel (s, t) = (0, 0) is in the lower left corner, 
texel (width - 1, 0) is in the lower right corner, etc. */
void texGetTexel(const texTexture *tex, int s, int t, double texel[]) {
    int k;
    for (k = 0; k < tex->texelDim; k += 1)
        texel[k] = tex->data[(s + tex->width * t) * tex->texelDim + k];
}

/* Sets a single texel within the texture. For details, see texGetTexel. */
void texSetTexel(texTexture *tex, int x, int y, const double texel[]) {
    if (0 <= x && x < tex->width && 0 <= y && y < tex->height
            && tex->data != NULL) {
        int index, k;
        index = tex->texelDim * (x + tex->width * y);
        for (k = 0; k < tex->texelDim; k += 1)
            tex->data[index + k] = texel[k];
    }
}

/* Deallocates the resources backing the texture. This function must be called 
when the user is finished using the texture. */
void texFinalize(texTexture *tex) {
    free(tex->data);
}



/*** Public: Higher-level sampling ***/

/* Samples from the texture, taking into account wrapping and filtering. The s 
and t parameters are texture coordinates. The texture itself is assumed to have 
texture coordinates [0, 1] x [0, 1], with (0, 0) in the lower left corner, (1, 
0) in the lower right corner, etc. Assumes that the texture has already been 
initialized. Assumes that sample has been allocated with (at least) texelDim 
doubles. Places the sampled texel into sample. */
void texSample(const texTexture *tex, double s, double t, double sample[]) {
    /* Handle clipping vs. repeating. */
    if (tex->leftRight == texREPEAT)
        s = s - floor(s);
    else {
        if (s < 0.0)
            s = 0.0;
        else if (s > 1.0)
            s = 1.0;
    }
    if (tex->topBottom == texREPEAT)
        t = t - floor(t);
    else {
        if (t < 0.0)
            t = 0.0;
        else if (t > 1.0)
            t = 1.0;
    }
    /* Scale to image space. */
    double u, v;
    u = s * (tex->width - 1);
    v = t * (tex->height - 1);
    /* Handle nearest-neighbor vs. linear filtering. */
    if (tex->filtering == texNEAREST)
        texGetTexel(tex, (int)round(u), (int)round(v), sample);
    else {
        // used later for calculating relative importance of each texel, based on
        // equation for linear filtering.
        double fracU = u - floor(u), fracV = v - floor(v);

        // retrieves data from the four texels in consideration.
        // data arrays of size texelDim to account for data other than RGB channels.
        double data1[tex->texelDim], data2[tex->texelDim], data3[tex->texelDim], data4[tex->texelDim];
        texGetTexel(tex, (int)floor(u), (int)floor(v), data1);
        texGetTexel(tex, (int)ceil(u), (int)floor(v), data2);
        texGetTexel(tex, (int)floor(u), (int)ceil(v), data3);
        texGetTexel(tex, (int)ceil(u), (int)ceil(v), data4);

        // scales each of the data by relative influence on the final data.
        // values determined by equation for linear filtering.
        double scaledData1[tex->texelDim], scaledData2[tex->texelDim], scaledData3[tex->texelDim], scaledData4[tex->texelDim];
        vecScale(tex->texelDim, (1-fracU)*(1-fracV), data1, scaledData1);
        vecScale(tex->texelDim, fracU*(1-fracV), data2, scaledData2);
        vecScale(tex->texelDim, (1-fracU)*fracV, data3, scaledData3);
        vecScale(tex->texelDim, fracU*fracV, data4, scaledData4);

        // sums the four, appropriately scaled, texel data into one final set of values
        double scaledSum1[tex->texelDim], scaledSum2[tex->texelDim];
        vecAdd(tex->texelDim, scaledData1, scaledData2, scaledSum1);
        vecAdd(tex->texelDim, scaledData3, scaledData4, scaledSum2);
        vecAdd(tex->texelDim, scaledSum1, scaledSum2, sample);
    }
}