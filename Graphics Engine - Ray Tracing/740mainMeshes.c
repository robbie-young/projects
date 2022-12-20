/*
    740mainMeshes.c
    Demos a new plane body.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
    Edited by Cole Weinstein and Robbie Young.
*/


/* On macOS, compile with...
    clang 740mainMeshes.c 040pixel.o -lglfw -framework OpenGL -framework Cocoa -framework IOKit
On Ubuntu, compile with...
    cc 740mainMeshes.c 040pixel.o -lglfw -lGL -lm -ldl
*/
#include <stdio.h>
#include <math.h>
#include <GLFW/glfw3.h>
#include "040pixel.h"

#include "650vector.c"
#include "280matrix.c"
#include "300isometry.c"
#include "300camera.c"
#include "730ray.c"
#include "150texture.c"
#include "730body.c"
#include "730sphere.c"
#include "680light.c"
#include "730plane.c"
#include "730mesh.c"
#include "250mesh3D.c"
#include "740resh.c"

#define SCREENWIDTH 512
#define SCREENHEIGHT 512


/*** ARTWORK ******************************************************************/

/* Based on the uniforms, textures, rayIntersection, and texture coordinates, 
outputs a Phong Lighting material. */
void getPhongMaterial(
        int unifDim, const double unif[], const void *data, int texNum, const texTexture *tex[], 
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

/* Outputs a perfect mirror material. */
void getMirrorMaterial(
        int unifDim, const double unif[], const void *data, int texNum, const texTexture *tex[], 
        const rayIntersection *inter, const double texCoords[2], 
        rayMaterial *material) {
    material->hasAmbient = 0;
    material->hasDiffuse = 0;
    material->hasSpecular = 0;
    material->hasMirror = 1;
    material->hasTransmission = 0;

    double white[3] = {1.0, 1.0, 1.0};
    vecCopy(3, white, material->cMirror);
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

/* Four sphere bodies, one plane body, and one box body from a mesh. */
#define SPHERENUM 4
#define PLANENUM 1
#define MESHNUM 1
bodyBody bodies[SPHERENUM + PLANENUM + MESHNUM];
meshMesh mesh;

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

    /* Body stuff */
    
    /* Sphere bodies */
    /* Sphere body initialization */
    if (bodyInitialize(&bodies[0], sphUNIFDIM, 4, 1, *sphGetIntersection, *sphGetTexCoordsAndNormal, *getPhongMaterial) != 0)  {
        return 1;
    }
    if (bodyInitialize(&bodies[1], sphUNIFDIM, 4, 1, *sphGetIntersection, *sphGetTexCoordsAndNormal, *getPhongMaterial) != 0)  {
        bodyFinalize(&bodies[0]);
        return 2;
    }
    if (bodyInitialize(&bodies[2], sphUNIFDIM, 4, 1, *sphGetIntersection, *sphGetTexCoordsAndNormal, *getMirrorMaterial) != 0)  {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        return 3;
    }
    if (bodyInitialize(&bodies[3], sphUNIFDIM, 4, 1, *sphGetIntersection, *sphGetTexCoordsAndNormal, *getMirrorMaterial) != 0)  {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        return 4;
    }

    /* Configure the texture(s), geometry uniforms, material uniforms, and isometry for each sphere. */
    double geomUnifs[sphUNIFDIM];
    double radii[SPHERENUM] = {1.0, 0.5, 0.5, 0.5};
    double rot[3][3] = {{1.0, 0.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 0.0, 1.0}};
    double transl[3] = {0.0, 0.0, 0.0};
    double materialUnifs[4] = {1.0, 1.0, 1.0, 64.0};
    
    for (int i = 0; i < SPHERENUM; i++) {
        bodySetTexture(&bodies[i], 0, &texture);
        geomUnifs[0] = radii[i];
        bodySetGeometryUniforms(&bodies[i], 0, geomUnifs, 1);
        bodySetMaterialUniforms(&bodies[i], 0, materialUnifs, 4);
        isoSetRotation(&(bodies[i].isometry), rot);
    }

    /* Sphere translations */
    isoSetTranslation(&(bodies[0].isometry), transl);
    vec3Set(2.0, 0.0, 0.0, transl);
    isoSetTranslation(&(bodies[1].isometry), transl);
    vec3Set(0.0, 2.0, 0.0, transl);
    isoSetTranslation(&(bodies[2].isometry), transl);
    vec3Set(0.0, 0.0, 2.0, transl);
    isoSetTranslation(&(bodies[3].isometry), transl);

    /* Plane bodies */
    /* Plane body initialization */
    if (bodyInitialize(&bodies[4], plaUNIFDIM, 4, 1, *plaGetIntersection, *plaGetTexCoordsAndNormal, *getPhongMaterial) != 0)  {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        bodyFinalize(&bodies[3]);
        return 5;
    }

    /* Configure the texture(s), material uniforms, and isometry for each plane. */
    for (int i = 0 ; i < PLANENUM ; i++) {
        bodySetTexture(&bodies[SPHERENUM + i], 0, &texture);
        bodySetMaterialUniforms(&bodies[SPHERENUM + i], 0, materialUnifs, 4);
        isoSetRotation(&(bodies[SPHERENUM + i].isometry), rot);
    }

    /* Plane translation */
    vec3Set(0.0, 0.0, -5.0, transl);
    isoSetTranslation(&(bodies[4].isometry), transl);

    /* Mesh-based bodies */
    /* Mesh initialization */
    if (mesh3DInitializeBox(&mesh, -0.5, 0.5, -0.5, 0.5, -0.5, 0.5) != 0) {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        bodyFinalize(&bodies[3]);
        bodyFinalize(&bodies[4]);
        return 6;
    }

    /* Body initialization using mesh above */
    if (bodyInitialize(&bodies[5], reshUNIFDIM, 4, 1, *reshGetIntersection, *reshGetTexCoordsAndNormal, *getPhongMaterial) != 0) {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        bodyFinalize(&bodies[3]);
        bodyFinalize(&bodies[4]);
        meshFinalize(&mesh);
        return 7;
    }

    /* Copy mesh data into body uniforms. */
    bodySetGeometryData(&bodies[5], &mesh);

    /* Finalize the mesh as it is no longer needed */

    /* Configure the texture(s), material uniforms, and isometry for each mesh-based body. */
    for (int i = 0 ; i < MESHNUM ; i++) {
        bodySetTexture(&bodies[SPHERENUM + PLANENUM + i], 0, &texture);
        bodySetMaterialUniforms(&bodies[SPHERENUM + PLANENUM + i], 0, materialUnifs, 4);
        isoSetRotation(&(bodies[SPHERENUM + PLANENUM + i].isometry), rot);
    }

    /* Mesh-based body translation */
    vec3Set(3.0, -3.0, 3.0, transl);
    isoSetTranslation(&(bodies[5].isometry), transl);

    /* Light stuff */
    /* Light initialization */
    int lightUnifDim = 3;
    if (lightInitialize(&lights[0], lightUnifDim, &getDirectionalLighting) != 0) {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        bodyFinalize(&bodies[3]);
        bodyFinalize(&bodies[4]);
        bodyFinalize(&bodies[5]);
        meshFinalize(&mesh);
        return 8;
    }
    if (lightInitialize(&lights[1], lightUnifDim, &getPositionalLighting) != 0) {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        bodyFinalize(&bodies[3]);
        bodyFinalize(&bodies[4]);
        bodyFinalize(&bodies[5]);
        meshFinalize(&mesh);
        lightFinalize(&lights[0]);
        return 9;
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
    double lightPos[3] = {0.0, 0.0, 5.0};
    isoSetTranslation(&(lights[1].isometry), lightPos);
    lightSetUniforms(&lights[1], 0, lightUnifs, 3);

    /* Texture stuff */
    if (texInitializeFile(&texture, "dln.png") != 0) {
        bodyFinalize(&bodies[0]);
        bodyFinalize(&bodies[1]);
        bodyFinalize(&bodies[2]);
        bodyFinalize(&bodies[3]);
        bodyFinalize(&bodies[4]);
        bodyFinalize(&bodies[5]);
        meshFinalize(&mesh);
        lightFinalize(&lights[0]);
        lightFinalize(&lights[1]);
		return 10;
	}
    texSetFiltering(&texture, texLINEAR);
    texSetLeftRight(&texture, texCLIP);
    texSetTopBottom(&texture, texCLIP);

    return 0;
}

void finalizeArtwork(void) {
    texFinalize(&texture);
    bodyFinalize(&bodies[0]);
    bodyFinalize(&bodies[1]);
    bodyFinalize(&bodies[2]);
    bodyFinalize(&bodies[3]);
    bodyFinalize(&bodies[4]);
    bodyFinalize(&bodies[5]);
    meshFinalize(&mesh);
    lightFinalize(&lights[0]);
    lightFinalize(&lights[1]);
    return;
}


/*** RENDERING ****************************************************************/

/* Casts the ray x(t) = p + t d into the scene. Returns 0 if it hits no body or 
1 if it hits any body. Used to determine whether a fragment is in shadow. */
int getSceneShadow(
        int bodyNum, const bodyBody bodies[], const double p[3], 
        const double d[3]) {
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

    /* Returns 1 if a body was encountered, 0 if not. */
    if (closestBody == -1) {
        return 0;
    }
    return 1;
}

/* Given a ray x(t) = p + t d. Finds the color where that ray hits the scene (or 
the background) and loads the color into the rgb parameter. */
void getSceneColor(
        int recDepth, int bodyNum, const bodyBody bodies[], const double cAmbient[3], 
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
        int inShadow = 0;

        /* start with black rgb value */
        double black[3] = {0.0, 0.0, 0.0};
        vecCopy(3, black, rgb);

        /* add ambient light if required */
        if (material.hasAmbient) {
            vecModulate(3, material.cDiffuse, cAmbient, rgb);
        }
        /* add mirroring if required */
        if (material.hasMirror && recDepth > 0) {
            double scalar, dNew[3], cFromMirror[3];
            /* dNew = d - 2 * (d · uNormal) * uNormal */
            scalar = 2 * vecDot(3, d, normal);
            vecScale(3, scalar, normal, dNew);
            vecSubtract(3, d, dNew, dNew);
            /* recursive call to "show" scene on the mirror */
            getSceneColor(recDepth - 1, bodyNum, bodies, cAmbient, lightNum, lights, x, dNew, cFromMirror);
            /* modulate with the mirror's color */
            vecModulate(3, material.cMirror, cFromMirror, cFromMirror);
            /* add to rgb */
            vecAdd(3, rgb, cFromMirror, rgb);
        }
        /* for each light in the scene, add diffuse and specular light if required */
        for (int i = 0 ; i < lightNum ; i++) {
            /* some details for both calculations, but only if either calculation will happen */
            if (material.hasDiffuse || material.hasSpecular) {
                lightGetLighting(&(lights[i]), x, &lighting);
                
                /* iDiffuse = max(0, uNormal · uLight) */
                iDiffuse = fmax(0.0, vecDot(3, lighting.uLight, normal));
                inShadow = getSceneShadow(bodyNum, bodies, x, lighting.uLight);
            }
            /* diffuse calculation, only if not in shadow from light i */
            if (material.hasDiffuse && iDiffuse != 0.0 && !inShadow) {
                double scaledDiffuse[3];

                /* diffuse contribution = iDiffuse * cLight * cDiffuse */
                vecScale(3, iDiffuse, material.cDiffuse, scaledDiffuse);
                vecModulate(3, lighting.cLight, scaledDiffuse, scaledDiffuse);
                
                /* final rgb contribution */
                vecAdd(3, scaledDiffuse, rgb, rgb);
            }
            /* specular calculation, only if not in shadow from light i */
            if (material.hasSpecular && iDiffuse != 0.0 && !inShadow) {
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
            getSceneColor(3, SPHERENUM + PLANENUM + MESHNUM, bodies, cAmbient, LIGHTNUM, lights, p, d, rgb);
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
    for (int k = 0; k < SPHERENUM; k += 1)
        isoSetRotation(&(bodies[k].isometry), rotMatrix);
    render();
}

int main(void) {
    if (pixInitialize(SCREENWIDTH, SCREENHEIGHT, "740mainMeshes") != 0)
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