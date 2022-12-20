/*
    690mainLights.c
    Demo showing ambient, diffuse, and specular light, featuring a directional and a positional light.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
    Edited by Cole Weinstein and Robbie Young.
*/


/* On macOS, compile with...
    clang 690mainLights.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 690mainLights.c 040pixel.o -lglfw -lGL -lm -ldl
*/
#include <stdio.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include "040pixel.h"

#include "650vector.c"
#include "280matrix.c"
#include "300isometry.c"
#include "300camera.c"
#include "660ray.c"
#include "150texture.c"
#include "670body.c"
#include "670sphere.c"
#include "680light.c"

#define SCREENWIDTH 512
#define SCREENHEIGHT 512


/*** ARTWORK ******************************************************************/

/* Based on the uniforms, textures, rayIntersection, and texture coordinates, 
outputs a material. */
void getMaterial(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        const rayIntersection *inter, const double texCoords[2], 
        rayMaterial *material) {
    material->hasAmbient = 1;
    material->hasDiffuse = 1;
    material->hasSpecular = 1;
    material->hasMirror = 0;
    material->hasTransmission = 0;

    vecCopy(3, unif, material->cSpecular);
    material->shininess = unif[3];

    double sample[tex[0]->texelDim];
    texSample(tex[0], texCoords[0], texCoords[1], sample);
    vecCopy(tex[0]->texelDim, sample, material->cDiffuse);
}

/* Configures lightLighting for a directional light. */
void getDirectionalLighting(int unifDim, const double unif[], const isoIsometry *isometry, 
        const double x[3], lightLighting *lighting) {
    vecCopy(3, unif, lighting->cLight);
    lighting->distance = rayINFINITY;
    double negZ[3] = {0.0, 0.0, 1.0};
    isoRotateDirection(isometry, negZ, lighting->uLight);
}

/* Configures lightLighting for a positional light. */
void getPositionalLighting(int unifDim, const double unif[], const isoIsometry *isometry, 
        const double x[3], lightLighting *lighting) {
    double lightPosMinusX[3];
    vecCopy(3, unif, lighting->cLight);
    /* uLight = normalize(pLight - pFrag) */
    vecSubtract(3, isometry->translation, x, lightPosMinusX);
    lighting->distance = vecUnit(3, lightPosMinusX, lighting->uLight);
}

/* A camera. */
camCamera camera;
double cameraTarget[3] = {0.0, 0.0, 0.0};
double cameraRho = 10.0, cameraPhi = M_PI / 3.0, cameraTheta = M_PI / 3.0;

/* One texture. */
#define TEXNUM 1
texTexture texture;
const texTexture *textures[1] = {&texture};
const texTexture **tex = textures;

/* Four sphere bodies. */
#define BODYNUM 4
bodyBody bodies[BODYNUM];

/* Ambient light. */
double cAmbient[3] = {1.0, 0.0, 0.0};

/* Two lights. */
#define LIGHTNUM 2
lightLight lights[LIGHTNUM];

int initializeArtwork(void) {
    /* Camera stuff */
    camSetProjectionType(&camera, camPERSPECTIVE);
    camSetFrustum(
        &camera, M_PI / 6.0, cameraRho, 10.0, SCREENWIDTH, SCREENHEIGHT);
    camLookAt(&camera, cameraTarget, cameraRho, cameraPhi, cameraTheta);

    /* Body initialization */
    if (bodyInitialize(&bodies[0], sphUNIFDIM, 4, 1, *sphGetIntersection, *sphGetTexCoordsAndNormal, *getMaterial) != 0)  {
        return 1;
    }
    if (bodyInitialize(&bodies[1], sphUNIFDIM, 4, 1, *sphGetIntersection, *sphGetTexCoordsAndNormal, *getMaterial) != 0)  {
        bodyFinalize(&bodies[0]);
        return 2;
    }
    if (bodyInitialize(&bodies[2], sphUNIFDIM, 4, 1, *sphGetIntersection, *sphGetTexCoordsAndNormal, *getMaterial) != 0)  {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        return 3;
    }
    if (bodyInitialize(&bodies[3], sphUNIFDIM, 4, 1, *sphGetIntersection, *sphGetTexCoordsAndNormal, *getMaterial) != 0)  {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        return 4;
    }

    /* Configure the texture(s), geometry uniforms, material uniforms, and isometry for each body. */
    double geomUnifs[sphUNIFDIM];
    double radii[BODYNUM] = {1.0, 0.5, 0.5, 0.5};
    double rot[3][3] = {{1.0, 0.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 0.0, 1.0}};
    double transl[3] = {0.0, 0.0, 0.0};
    double materialUnifs[4] = {1.0, 1.0, 1.0, 64.0};
    
    for (int i = 0; i < BODYNUM; i++) {
        bodySetTexture(&bodies[i], 0, &texture);
        geomUnifs[0] = radii[i];
        bodySetGeometryUniforms(&bodies[i], 0, geomUnifs, 1);
        bodySetMaterialUniforms(&bodies[i], 0, materialUnifs, 4);
        isoSetRotation(&(bodies[i].isometry), rot);
    }

    isoSetTranslation(&(bodies[0].isometry), transl);
    vec3Set(1.0, 0.0, 0.0, transl);
    isoSetTranslation(&(bodies[1].isometry), transl);
    vec3Set(0.0, 1.0, 0.0, transl);
    isoSetTranslation(&(bodies[2].isometry), transl);
    vec3Set(0.0, 0.0, 1.0, transl);
    isoSetTranslation(&(bodies[3].isometry), transl);

    /* Light initialization */
    int lightUnifDim = 3;
    if (lightInitialize(&lights[0], lightUnifDim, &getDirectionalLighting) != 0) {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        bodyFinalize(&bodies[3]);
        return 5;
    }
    if (lightInitialize(&lights[1], lightUnifDim, &getPositionalLighting) != 0) {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        bodyFinalize(&bodies[3]);
        lightFinalize(&lights[0]);
        return 6;
    }

    /* Configure the directional light's uniforms and rotation */
    double lightUnifs[3] = {0.0, 1.0, 0.0};
    double axis[3] = {0.0, 1.0/sqrt(2.0), 1.0/sqrt(2.0)};
    double angle = M_PI / 4.0;
    double angleAxisRot[3][3];
    mat33AngleAxisRotation(angle, axis, angleAxisRot);
    isoSetRotation(&(lights[0].isometry), angleAxisRot);
    lightSetUniforms(&lights[0], 0, lightUnifs, 3);

    /* Configure the positional light's uniforms and rotation */
    lightUnifs[1] = 0.0;
    lightUnifs[2] = 1.0;
    double lightPos[3] = {0.0, 0.0, 2.0};
    isoSetTranslation(&(lights[1].isometry), lightPos);
    lightSetUniforms(&lights[1], 0, lightUnifs, 3);

    /* Texture stuff */
    if (texInitializeFile(&texture, "dln.png") != 0) {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        bodyFinalize(&bodies[3]);
        lightFinalize(&lights[0]);
        lightFinalize(&lights[1]);
		return 7;
	}
    texSetFiltering(&texture, texLINEAR);
    texSetLeftRight(&texture, texREPEAT);
    texSetTopBottom(&texture, texREPEAT);

    return 0;
}

void finalizeArtwork(void) {
    texFinalize(&texture);
    bodyFinalize(&bodies[0]);
    bodyFinalize(&bodies[1]);
    bodyFinalize(&bodies[2]);
    bodyFinalize(&bodies[3]);
    lightFinalize(&lights[0]);
    lightFinalize(&lights[1]);
    return;
}


/*** RENDERING ****************************************************************/

/* Given a ray x(t) = p + t d. Finds the color where that ray hits the scene (or 
the background) and loads the color into the rgb parameter. */
void getSceneColor(
        int bodyNum, const bodyBody bodies[], const double cAmbient[3], 
        int lightNum, const lightLight lights[], const double p[3], 
        const double d[3], double rgb[3]) {
    double backgroundColor[3] = {0.0, 0.0, 0.0};
    double bound = rayINFINITY;
    int closestBody = -1;
    rayIntersection closestInter;
    rayIntersection inter;

    /* Finds and records the closest body within the bound. */
    for (int i = 0; i < bodyNum; i++) {
        bodyGetIntersection(&bodies[i], p, d, bound, &inter);
        if (inter.t != rayNONE) {
            bound = inter.t;
            closestBody = i;
            closestInter = inter;
        }
    }

    /* If a body was found, set rgb to that body's color. Otherwise, set rgb to the background color. */
    if (closestBody == -1) {
        vecCopy(3, backgroundColor, rgb);
    } else {
        double texCoords[2], normal[3], sample[texture.texelDim], td[3], x[3];
        rayMaterial material;
        bodyGetTexCoordsAndNormal(&bodies[closestBody], p, d, &closestInter, texCoords, normal);
        bodyGetMaterial(&bodies[closestBody], &closestInter, texCoords, &material);
        /* x = p + td */
        vecScale(3, closestInter.t, d, td);
        vecAdd(3, p, td, x);
        
        /* Lighting Calculations */
        lightLighting lighting;
        double iDiffuse = 0.0;

        /* start with black rgb value */
        double black[3] = {0.0, 0.0, 0.0};
        vecCopy(3, black, rgb);

        /* add ambient light if required*/
        if (material.hasAmbient) {
            vecModulate(3, material.cDiffuse, cAmbient, rgb);
        }
        /* for each light in the scene, add diffuse and specular light if required */
        for (int i = 0 ; i < lightNum ; i++) {
            /* some details for both calculations, but only if either calculation will happen */
            if (material.hasDiffuse || material.hasSpecular) {
                lightGetLighting(&(lights[i]), x, &lighting);
                
                /* iDiffuse = max(0, uNormal · uLight) */
                iDiffuse = fmax(0.0, vecDot(3, lighting.uLight, normal));
            }
            /* diffuse calculation */
            if (material.hasDiffuse && iDiffuse != 0.0) {
                double scaledDiffuse[3];

                /* diffuse contribution = iDiffuse * cLight * cDiffuse */
                vecScale(3, iDiffuse, material.cDiffuse, scaledDiffuse);
                vecModulate(3, lighting.cLight, scaledDiffuse, scaledDiffuse);
                
                /* final rgb contribution */
                vecAdd(3, scaledDiffuse, rgb, rgb);
            }
            /* specular calculation */
            if (material.hasSpecular && iDiffuse != 0.0) {
                double uLightDotNormal, uRefl[3], uCamera[3], iSpec, scaledSpecular[3];
                
                /* uRefl = 2 * (uLight · uNormal) * uNormal - uLight */
                uLightDotNormal = 2 * vecDot(3, normal, lighting.uLight);
                vecScale(3, uLightDotNormal, normal, uRefl);
                vecSubtract(3, uRefl, lighting.uLight, uRefl);
                
                /* uCamera = normalize(-d) */
                vecScale(3, -1, d, uCamera);
                vecUnit(3, uCamera, uCamera);

                /* iSpec = uRefl · uCamera */
                iSpec = fmax(0.0, vecDot(3, uRefl, uCamera));
                
                /* specular contribution = iSpec ^ shininess * cLight * cSpecular */
                iSpec = pow(iSpec, material.shininess);
                vecScale(3, iSpec, material.cSpecular, scaledSpecular);
                vecModulate(3, lighting.cLight, scaledSpecular, scaledSpecular);
                
                /* final rgb contribution */
                vecAdd(3, scaledSpecular, rgb, rgb);
            }
        }
    }
}

void render(void) {
    /* Build a 4x4 matrix that (along with homogeneous division) takes screen 
    coordinates (x0, x1, 0, 1) to the corresponding world coordinates. */
    double camIsom[4][4], invProj[4][4], invViewport[4][4], invProjInvViewport[4][4], screenToWorld[4][4];
    /* Set invViewport. */
    mat44InverseViewport(SCREENWIDTH, SCREENHEIGHT, invViewport);
    /* Set invProj. */
    if (camera.projectionType == camORTHOGRAPHIC) {
        camGetInverseOrthographic(&camera, invProj);
    } else {
		camGetInversePerspective(&camera, invProj);
	}
    /* Set camIsom. */
    isoGetHomogeneous(&(camera.isometry), camIsom);
    /* screenToWorld = camIsom * invProj * invViewport = C * P^-1 * V^-1. */
    mat444Multiply(invProj, invViewport, invProjInvViewport);
    mat444Multiply(camIsom, invProjInvViewport, screenToWorld);

    /* Declare p and d, and compute d if the camera is orthographic. */
    double p[4], d[3];
    if (camera.projectionType == camORTHOGRAPHIC) {
        double rotDir[3] = {0.0, 0.0, -1.0};
        isoRotateDirection(&(camera.isometry), rotDir, d);
    }

    /* Each screen point is chosen to be on the near plane. */
    double screen[4] = {0.0, 0.0, 0.0, 1.0};
    for (int i = 0; i < SCREENWIDTH; i += 1) {
        screen[0] = i;
        for (int j = 0; j < SCREENHEIGHT; j += 1) {
            screen[1] = j;
            /* Compute p and perform homogeneous division. Also compute d if the camera is perspective. */
            mat441Multiply(screenToWorld, screen, p);
            vecScale(4, 1/p[3], p, p);
            if (camera.projectionType == camPERSPECTIVE) {
                vecSubtract(3, p, camera.isometry.translation, d);
            }
            /* Set the pixel to the color of that ray. */
            double rgb[3];
            getSceneColor(BODYNUM, bodies, cAmbient, LIGHTNUM, lights, p, d, rgb);
            pixSetRGB(i, j, rgb[0], rgb[1], rgb[2]);
        }
    }
}


/*** USER INTERFACE ***********************************************************/

void handleKey(
        int key, int shiftIsDown, int controlIsDown, int altOptionIsDown, 
        int superCommandIsDown) {
    if (key == GLFW_KEY_I)
        cameraPhi -= 0.1;
    else if (key == GLFW_KEY_K)
        cameraPhi += 0.1;
    else if (key == GLFW_KEY_J)
        cameraTheta -= 0.1;
    else if (key == GLFW_KEY_L)
        cameraTheta += 0.1;
    else if (key == GLFW_KEY_U)
        cameraRho *= 1.1;
    else if (key == GLFW_KEY_O)
        cameraRho *= 0.9;
    else if (key == GLFW_KEY_P) {
        if (camera.projectionType == camORTHOGRAPHIC)
            camSetProjectionType(&camera, camPERSPECTIVE);
        else
            camSetProjectionType(&camera, camORTHOGRAPHIC);
    }
    camSetFrustum(
        &camera, M_PI / 6.0, cameraRho, 10.0, SCREENWIDTH, SCREENHEIGHT);
    camLookAt(&camera, cameraTarget, cameraRho, cameraPhi, cameraTheta);
}

void handleTimeStep(double oldTime, double newTime) {
    if (floor(newTime) - floor(oldTime) >= 1.0)
        printf(
            "info: handleTimeStep: %f frames/s\n", 1.0 / (newTime - oldTime));
    double rotAxis[3] = {1.0 / sqrt(3.0), 1.0 / sqrt(3.0), 1.0 / sqrt(3.0)};
    double rotMatrix[3][3];
    mat33AngleAxisRotation(newTime, rotAxis, rotMatrix);
    for (int k = 0; k < BODYNUM; k += 1)
        isoSetRotation(&(bodies[k].isometry), rotMatrix);
    render();
}

int main(void) {
    if (pixInitialize(SCREENWIDTH, SCREENHEIGHT, "690mainLights") != 0)
        return 1;
    if (initializeArtwork() != 0) {
        pixFinalize();
        return 2;
    }
    pixSetKeyDownHandler(handleKey);
    pixSetKeyRepeatHandler(handleKey);
    pixSetTimeStepHandler(handleTimeStep);
    pixRun();
    finalizeArtwork();
    pixFinalize();
    return 0;
}