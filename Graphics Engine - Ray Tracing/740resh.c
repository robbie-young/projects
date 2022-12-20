/*
	740resh.c
	Defines functions to interact with a "resh"; specifically a mesh used in ray tracing.
	Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
	Some implementations written by Cole Weinstein and Robbie Young. 
*/


/* A resh is a ray-tracing mesh. It has no geometry uniforms outside the 
attached meshMesh. */
#define reshUNIFDIM 0

/* Given vectors a, b - a, and c - a describing a triangle, with the first three 
entries being XYZ. Given point x, with the first three entries being XYZ, such 
that (up to numerical precision) x - a = p (b - a) + q (c - a). Computes p and 
q. Returns 1 on success or 0 on failure. */
int reshGetPQ(
        const double a[], const double bMinusA[], const double cMinusA[], 
        const double x[], double pq[2]) {
    /* For the 3x2 matrix A with columns b - a, c - a, compute A^T A. */
    double aTA[2][2];
    aTA[0][0] = vecDot(3, bMinusA, bMinusA);
    aTA[0][1] = vecDot(3, bMinusA, cMinusA);
    aTA[1][0] = aTA[0][1];
    aTA[1][1] = vecDot(3, cMinusA, cMinusA);
    /* Compute the 2x2 matrix (A^T A)^-1 if possible. */
    double aTAInv[2][2];
    if (mat22Invert(aTA, aTAInv) == 0.0)
        return 0;
    /* Compute the 2x3 matrix (A^T A)^-1 A^T. */
    double aTAInvAT[2][3];
    for (int i = 0; i < 2; i += 1)
        for (int j = 0; j < 3; j += 1)
            aTAInvAT[i][j] = 
                aTAInv[i][0] * bMinusA[j] + aTAInv[i][1] * cMinusA[j];
    /* Then pq = (A^T A)^-1 A^T (x - a). */
    double xMinusA[3];
    vecSubtract(3, x, a, xMinusA);
    pq[0] = vecDot(3, aTAInvAT[0], xMinusA);
    pq[1] = vecDot(3, aTAInvAT[1], xMinusA);
    return 1;
}

/* An implementation of getIntersection for bodies that are reshes. Assumes that 
the data parameter points to an underlying meshMesh with attribute structure 
XYZSTNOP. */
void reshGetIntersection(
        int unifDim, const double unif[], const void *data, 
        const isoIsometry *isom, const double p[3], const double d[3], 
        double bound, rayIntersection* inter) {
    meshMesh *mesh = (meshMesh *)data;
    
    double pUntransformed[3], pLocal[3], dLocal[3];
    /* Untransform and unrotate p using isometry to get p in local coords. */
    isoUntransformPoint(isom, p, pUntransformed);
    isoUnrotateDirection(isom, pUntransformed, pLocal);
    /* Unrotate d to get d in local coords. */
    isoUnrotateDirection(isom, d, dLocal);

    inter->t = rayNONE;
    int *triangle;
    double *a, *b, *c, bMinusA[3], cMinusA[3], normal[3], aMinusP[3], nDotD, t, td[3], xLocal[3], pq[2];
    
    /* loop through each triangle testing for a closest intersection */
    for (int i = 0; i < mesh->triNum; i++) {
        /* get the vertices of the triangle and compute (b - a) and (c - a) */
        triangle = meshGetTrianglePointer(mesh, i);
        a = meshGetVertexPointer(mesh, triangle[0]);
        b = meshGetVertexPointer(mesh, triangle[1]);
        c = meshGetVertexPointer(mesh, triangle[2]);
        vecSubtract(3, b, a, bMinusA);
        vecSubtract(3, c, a, cMinusA);
        /* compute normal = (b - a) x (c - a) */
        vec3Cross(bMinusA, cMinusA, normal);

        /* Finds the point x(t) = p + td of intersection with the plane of the triangle (if any) */
        /* t = (normal · (a - p)) / (normal · d) */
        
        /* if (normal · d) is zero the ray is parallel to the plane */
        nDotD = vecDot(3, normal, dLocal);
        if (nDotD != 0) {
            /* Finds x(t) = p + td that interesects with the plane */
            vecSubtract(3, a, pLocal, aMinusP);
            t = vecDot(3, normal, aMinusP) / nDotD;
            if (t >= rayEPSILON && t <= bound) {
                vecScale(3, t, dLocal, td);
                vecAdd(3, pLocal, td, xLocal);
                
                /* tests if x(t) is in the triangle */
                if (reshGetPQ(a, bMinusA, cMinusA, xLocal, pq)) {
                    if (pq[0] >= 0 && pq[1] >= 0 && pq[0] + pq[1] <= 1) {
                        /* if successful, set new bound, and store current victors in inter */
                        bound = t;
                        inter->t = t;
                        inter->index = i;
                    }
                }
                /* if not successful, continue looping as either inter->t already equals rayNONE
                   or another triangle is a victor (and should not be overridden) */
            }
        }
    }
}

/* An implementation of getTexCoordsAndNormal for bodies that are reshes. 
Assumes that the data parameter points to an underlying meshMesh with attribute 
structure XYZSTNOP. */
void reshGetTexCoordsAndNormal(
        int unifDim, const double unif[], const void *data, 
        const isoIsometry *isom, const double p[3], const double d[3], 
        const rayIntersection *inter, double texCoords[2], double normal[3]) {
    meshMesh *mesh = (meshMesh *)data;
    
    double pUntransformed[3], pLocal[3], dLocal[3], td[3], intersection[3];
    /* Untransform and unrotate p using isometry to get p in local coords. */
    isoUntransformPoint(isom, p, pUntransformed);
    isoUnrotateDirection(isom, pUntransformed, pLocal);
    /* Unrotate d to get d in local coords. */
    isoUnrotateDirection(isom, d, dLocal);
    
    /* Calculate the intersection point (just x, y, z values) as x(t) = p + td. */
    vecScale(3, inter->t, dLocal, td);
    vecAdd(3, pLocal, td, intersection);

    /* Gets the vertices of the winning triangle. */
    double *a, *b, *c, bMinusA[8], cMinusA[8], pq[2], x[8];
    int *triangle = meshGetTrianglePointer(mesh, inter->index);
    a = meshGetVertexPointer(mesh, triangle[0]);
    b = meshGetVertexPointer(mesh, triangle[1]);
    c = meshGetVertexPointer(mesh, triangle[2]);
    
    /* Computations to find x = a + p(b - a) + q(c - a). */
    vecSubtract(8, b, a, bMinusA);
    vecSubtract(8, c, a, cMinusA);
    reshGetPQ(a, bMinusA, cMinusA, intersection, pq);
    vecScale(8, pq[0], bMinusA, bMinusA);
    vecScale(8, pq[1], cMinusA, cMinusA);
    vecAdd(8, bMinusA, cMinusA, x);
    vecAdd(8, a, x, x);

    /* Copies the texture coordinates and normal into the given texCoords array and normal array. */
    vecCopy(2, &x[3], texCoords);
    vecUnit(3, &x[5], normal);
}