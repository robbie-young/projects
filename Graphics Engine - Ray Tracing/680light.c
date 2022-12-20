/*
    680light.c
    Creates the lightLighting and lightLight structs, aswell as some methods to interact with them.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/


/* Feel free to read and write this struct's members. Usually they are written by a getLightEffect-style function and only read after that. */
typedef struct lightLighting lightLighting;
struct lightLighting {
	/* cLight is the color of the light that arrives at a specified point in 
	the world. It can be as simple as a constant light color. In more 
	complicated examples, it can incorporate spot light angle, attenuation, 
	textured light, etc. */
	double cLight[3];
	/* uLight is the unit vector in world coordinates from some specified point 
	toward the light. It is used in almost all lighting calculations. */
	double uLight[3];
	/* distance is the distance from some specified point to the light. It can 
	be useful for setting the bound b in shadow rays. It can be rayINFINITY to 
	signal a distant, directional light source. */
	double distance;
};

/* Feel free to read this struct's members, but write to them only through their 
accessor functions. */
typedef struct lightLight lightLight;
struct lightLight {
    isoIsometry isometry;
    int unifDim;
    double *unif;
    /* Outputs the lighting effect of the light at the world point x. */
    void (*getLighting)(
        int unifDim, const double unif[], const isoIsometry *isometry, 
        const double x[3], lightLighting *lighting);
};

/* Initializes the light, returning an error code (0 on success). On success, 
don't forget to lightFinalize when you're done. The isometry is initialized to 
the trivial isometry. */
int lightInitialize(
        lightLight *light, int unifDim, 
        void (*getLighting)(
            int unifDim, const double unif[], const isoIsometry *isometry, 
            const double x[3], lightLighting *lighting)) {
    light->unif = malloc(unifDim * sizeof(double));
    if (light->unif == NULL) {
        fprintf(stderr, "error: lightInitialize: malloc failed\n");
        return 1;
    }
    light->unifDim = unifDim;
    double transl[3] = {0.0, 0.0, 0.0};
    isoSetTranslation(&(light->isometry), transl);
    double rot[3][3] = {{1.0, 0.0, 0.0}, {0.0, 1.0, 0.0}, {0.0, 0.0, 1.0}};
    isoSetRotation(&(light->isometry), rot);
    light->getLighting = getLighting;
    return 0;
}

/* Releases the resources backing the light. */
void lightFinalize(lightLight *light) {
    free(light->unif);
}

/* Copies count doubles from data into the light's uniforms, starting at the 
uniform with index start. */
void lightSetUniforms(lightLight *light, int start, double data[], int count) {
    vecCopy(count, data, &(light->unif[start]));
}

void lightGetLighting(
        const lightLight *light, const double x[3], lightLighting *lighting) {
    light->getLighting(
        light->unifDim, light->unif, &(light->isometry), x, lighting);
}