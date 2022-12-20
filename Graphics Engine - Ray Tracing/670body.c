/*
    670body.c
    Defines the bodyBody struct containing some information about the body and pointers
    to methods for interacting with it.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/


/* Feel free to read this struct's members, but write to them only through their 
accessor functions. */
typedef struct bodyBody bodyBody;
struct bodyBody {
    isoIsometry isometry;
    int geomUnifDim, materUnifDim, texNum;
    texTexture **textures;
    double *geomUnif, *materUnif;
    /* Given a body with the specified geometry uniforms and modeling isometry. 
    Given a ray x(t) = p + t d in world coordinates. Outputs a rayIntersection, 
    whose t member is the least t, in the interval [rayEPSILON, bound], when the 
    ray intersects the body. If there is no such t, then the t member is instead 
    rayNONE. */
    void (*getIntersection)(
        int unifDim, const double unif[], const isoIsometry *isom, 
        const double p[3], const double d[3], double bound, 
        rayIntersection* inter);
    /* Given the geometry uniforms of the body that just produced the given 
    rayIntersection. Outputs the body's texture coordinates at the intersection 
    point. Also outputs the body's unit outward-pointing normal vector there, in 
    world coordinates. */
    void (*getTexCoordsAndNormal)(
        int unifDim, const double unif[], const isoIsometry *isom, 
        const double p[3], const double d[3], const rayIntersection *inter, 
        double texCoords[2], double normal[3]);
    /* Based on a body's material uniforms, textures, rayIntersection, and 
    texture coordinates, outputs a material. */
    void (*getMaterial)(
        int unifDim, const double unif[], int texNum, const texTexture *tex[], 
        const rayIntersection *inter, const double texCoords[2], 
        rayMaterial *material);
};

/* Initializes the body, returning an error code (0 on success). On success, 
don't forget to bodyFinalize when you're done. The isometry is initialized to 
the trivial isometry. The uniforms and textures are not set. */
int bodyInitialize(
        bodyBody *body, int geomUnifDim, int materUnifDim, int texNum, 
        void (*getIntersection)(
            int unifDim, const double unif[], const isoIsometry *isom, 
            const double p[3], const double d[3], double bound, 
            rayIntersection* inter), 
        void (*getTexCoordsAndNormal)(
            int unifDim, const double unif[], const isoIsometry *isom, 
            const double p[3], const double d[3], const rayIntersection *inter, 
            double texCoords[2], double normal[3]), 
        void (*getMaterial)(
            int unifDim, const double unif[], int texNum, 
            const texTexture *tex[], const rayIntersection *inter, 
            const double texCoords[2], rayMaterial *material)) {
    body->geomUnif = malloc(
        (geomUnifDim + materUnifDim) * sizeof(double) + 
        texNum * sizeof(texTexture *));
    if (body->geomUnif == NULL) {
        fprintf(stderr, "error: bodyInitialize: malloc failed\n");
        return 1;
    }
    body->materUnif = &(body->geomUnif[geomUnifDim]);
    body->textures = 
        (texTexture **)&(body->geomUnif[geomUnifDim + materUnifDim]);
    body->geomUnifDim = geomUnifDim;
    body->materUnifDim = materUnifDim;
    body->texNum = texNum;
    body->getIntersection = getIntersection;
    body->getTexCoordsAndNormal = getTexCoordsAndNormal;
    body->getMaterial = getMaterial;
    double transl[3] = {0.0, 0.0, 0.0};
    isoSetTranslation(&(body->isometry), transl);
    double rot[3][3] = {{1.0, 0.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 0.0, 1.0}};
    isoSetRotation(&(body->isometry), rot);
    return 0;
}

/* Releases the resources backing the body. */
void bodyFinalize(bodyBody *body) {
    /* The material uniforms and texture pointers are handled as part of the 
    geometry uniforms. */
    free(body->geomUnif);
}

/* Copies count doubles from data into the body's geometry uniforms, starting at 
the uniform with index start. */
void bodySetGeometryUniforms(
        bodyBody *body, int start, double data[], int count) {
    if (start < 0 || start + count > body->geomUnifDim)
        fprintf(stderr, "error: bodySetGeometryUniforms: array overrun\n");
    else
        vecCopy(count, data, &(body->geomUnif[start]));
}

/* Copies count doubles from data into the body's material uniforms, starting at 
the uniform with index start. */
void bodySetMaterialUniforms(
        bodyBody *body, int start, double data[], int count) {
    if (start < 0 || start + count > body->materUnifDim)
        fprintf(stderr, "error: bodySetMaterialUniforms: array overrun\n");
    else
        vecCopy(count, data, &(body->materUnif[start]));
}

/* Sets one of the body's textures to the given texture. */
void bodySetTexture(bodyBody *body, int index, texTexture *texture) {
    if (index < 0 || index >= body->texNum)
        fprintf(stderr, "error: bodySetTexture: array overrun\n");
    else
        body->textures[index] = texture;
}

/* Using the body's geometry, outputs the appropriate rayIntersection. */
void bodyGetIntersection(
        const bodyBody *body, const double p[3], const double d[3], 
        double bound, rayIntersection* inter) {
    body->getIntersection(
        body->geomUnifDim, body->geomUnif, &(body->isometry), p, d, bound, 
        inter);
}

/* Using the body's geometry, outputs the appropriate texture coordinates and unit outward-pointing normal. */
void bodyGetTexCoordsAndNormal(
        const bodyBody *body, const double p[3], const double d[3], 
        const rayIntersection *inter, double texCoords[2], double normal[3]) {
    body->getTexCoordsAndNormal(
        body->geomUnifDim, body->geomUnif, &(body->isometry), p, d, inter, 
        texCoords, normal);
}

/* Using the body's kind of material, outputs the appropriate rayMaterial. */
void bodyGetMaterial(
        const bodyBody *body, const rayIntersection *inter, 
        const double texCoords[2], rayMaterial *material) {
    body->getMaterial(
        body->materUnifDim, body->materUnif, body->texNum, 
        (const texTexture **)(body->textures), inter, texCoords, material);
}

