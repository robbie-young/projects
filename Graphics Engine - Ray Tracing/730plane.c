/*
    730plane.c
    Implements getIntersection and getTexCoordsAndNormal specifically for a plane.
    Upgraded from 720plane.c to include data variable in signatures
    Signatures provided by Josh Davis for Carleton College's CS311 - Computer Graphics.
    Implementations written by Cole Weintstein and Robbie Young
*/


/* A plane has no geometry uniforms. */
#define plaUNIFDIM 0

/* An implementation of getIntersection for bodies that are planes. */
void plaGetIntersection(
        int unifDim, const double unif[], const void *data, const isoIsometry *isom, 
        const double p[3], const double d[3], double bound, 
        rayIntersection* inter) {
    double pUntransformed[3], pLocal[3], dLocal[3];

    /* Untransform and unrotate p using isometry to get p in local coords. */
    isoUntransformPoint(isom, p, pUntransformed);
    isoUnrotateDirection(isom, pUntransformed, pLocal);
    /* Unrotate d to get d in local coords. */
    isoUnrotateDirection(isom, d, dLocal);

    /* t = -p[2]/d[2]. */
    /* If d[2] = 0, t = rayNONE to avoid divide by zero. */
    if (dLocal[2] == 0) {
        inter->t = rayNONE;
        return;
    } else {
        double t = (-1.0 * pLocal[2]) / dLocal[2];
        /* if t is outside the desired interval, t = rayNONE. */
        if (t >= rayEPSILON && t <= bound) {
            inter->t = t;
            return;
        }
        inter->t = rayNONE;
    }
}

/* An implementation of getTexCoordsAndNormal for bodies that are planes. */
void plaGetTexCoordsAndNormal(
        int unifDim, const double unif[], const void *data, const isoIsometry *isom, 
        const double p[3], const double d[3], const rayIntersection *inter, 
        double texCoords[2], double normal[3]) {
    /* Plane's normal in local coords is <0, 0, 1>. Rotate it using isometry to get normal in global coords. */
    double zNormal[3] = {0.0, 0.0, 1.0}, zNormalRotated[3];
    isoRotateDirection(isom, zNormal, zNormalRotated);
    vecCopy(3, zNormalRotated, normal);
    
    double td[3], xWorld[3], xUntransformed[3], xLocal[3];
    /* Compute x(t) = p + td. */
    vecScale(3, inter->t, d, td);
    vecAdd(3, p, td, xWorld);
    /* Untransform and unrotate x using isometry to get x in local coords. */
    isoUntransformPoint(isom, xWorld, xUntransformed);
    isoUnrotateDirection(isom, xUntransformed, xLocal);
    texCoords[0] = xLocal[0];
    texCoords[1] = xLocal[1];
}


