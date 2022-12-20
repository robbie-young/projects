/*
    200shading.c
    Creates the shaShading struct for storing information about uniform, attribute, texture, and varyings arrays.
    Written by Cole Weinstein and Robbie Young for Carleton College's 
    CS311 - Computer Gaphics, taught by Josh Davis.
*/

typedef struct shaShading shaShading;

struct shaShading {
    int unifDim;
    int attrDim;
    int texNum;
    int varyDim;
};