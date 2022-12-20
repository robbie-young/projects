/*
    660ray.c
    Defines the rayIntersection struct and some relevant constants.
    Upgraded from 640ray.c to include the rayMaterial struct.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/


#define rayNONE -1.0
#define rayEPSILON 0.000001
#define rayINFINITY 1000000.0

/* Feel free to read and write this data structure's members. */
typedef struct rayIntersection rayIntersection;
struct rayIntersection {
    double t;   // rayNONE or the first intersection time in [rayEPSILON, tEnd]
};

/* Feel free to read and write this data structure's members. Usually they are 
written by a getMaterial function and only read after that. */
typedef struct rayMaterial rayMaterial;
struct rayMaterial {
    /* Phong lighting model in three terms. Remember that the ambient 
    term uses the diffuse surface color. */
    int hasAmbient, hasDiffuse, hasSpecular;
    double cDiffuse[3], cSpecular[3], shininess;
    /* If hasMirror, then there is a term equal to the reflected ray modulated 
    by cMirror. */
    int hasMirror;
    double cMirror[3];
    /* If hasTransmission, then there is a term equal to the refracted ray, 
    raised to the in-body travel time, modulated by cMirror */
    int hasTransmission;
    double cTransmission[3], indexRefr;
};


