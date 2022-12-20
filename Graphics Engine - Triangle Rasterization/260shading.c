/*
    260shading.c
    Creates the shaShading struct for storing information about uniform, attribute, texture, and varyings arrays.
    Now includes customization for fragement shader and vertex shader.
    New from 220shading.c: updated shadeFragment signature to reflect shadeFragment now returning a fragment's 
    depth in addition to its rgb.
    
    Written by Cole Weinstein and Robbie Young for Carleton College's 
    CS311 - Computer Gaphics, taught by Josh Davis.
*/

typedef struct shaShading shaShading;

struct shaShading {
    int unifDim;
    int attrDim;
    int texNum;
    int varyDim;
    void (*shadeVertex)(int, const double[], int, const double[], int, double[]);
    void (*shadeFragment)(int, const double[], int, const texTexture *[], int, const double[], double[4]);
};