/*
    670sphere.c
    Implements getIntersection and getTexCoordsAndNormal specifically for a sphere.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
    Some implementations written by Cole Weinstein and Robbie Young.
*/


/* A sphere has exactly one geometry uniform: its radius. */
#define sphUNIFDIM 1

/* An implementation of getIntersection for bodies that are spheres. */
void sphGetIntersection(
        int unifDim, const double unif[], const isoIsometry *isom, 
        const double p[3], const double d[3], double bound, 
        rayIntersection* inter) {
    double r = unif[0], c[3];
    vecCopy(3, isom->translation, c);

    double pMinusC[3], dPMinusC, dD, rSq, disc, t;
    vecSubtract(3, p, c, pMinusC);
    dPMinusC = vecDot(3, d, pMinusC);
    dD = vecDot(3, d, d);
    rSq = r * r;
    disc = dPMinusC * dPMinusC - dD * (vecDot(3, pMinusC, pMinusC) - rSq);

    if (disc <= 0) {
        inter->t = rayNONE;
        return;
    }
    disc = sqrt(disc);
    t = (-dPMinusC - disc) / dD;
    if (rayEPSILON <= t && t <= bound) {
        inter->t = t;
        return;
    }
    t = (-dPMinusC + disc) / dD;
    if (rayEPSILON <= t && t <= bound) {
        inter->t = t;
        return;
    }
    inter->t = rayNONE;
}

/* An implementation of getTexCoordsAndNormal for bodies that are spheres. */
void sphGetTexCoordsAndNormal(
        int unifDim, const double unif[], const isoIsometry *isom, 
        const double p[3], const double d[3], const rayIntersection *inter, 
        double texCoords[2], double normal[3]) {
    double td[3], xWorld[3];
    vecScale(3, inter->t, d, td);
    vecAdd(3, p, td, xWorld);
    vecSubtract(3, xWorld, isom->translation, normal);
    vecUnit(3, normal, normal);

    double xUntransformed[3], xLocal[3];
    double rho, phi, theta;
    
    isoUntransformPoint(isom, xWorld, xUntransformed);
    isoUnrotateDirection(isom, xUntransformed, xLocal);
    vec3Rectangular(xLocal, &rho, &phi, &theta);
    texCoords[0] = theta / (2.0 * M_PI);
    texCoords[1] = 1.0 - (phi / M_PI);
}

