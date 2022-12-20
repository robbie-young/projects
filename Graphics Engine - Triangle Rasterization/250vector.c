/*
    250vector.c
    A simple program to modify vectors and teach basic vector arithmetic. Upgraded from 080vector.c
    to implement functions for dot and cross products.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
    Implementations written by Cole Weinstein and Robbie Young.
*/

/*** In general dimensions ***/

/* Copies the dim-dimensional vector v to the dim-dimensional vector copy. The 
output can safely alias the input. */
void vecCopy(int dim, const double v[], double copy[]) {
    for (int i = 0; i < dim; i += 1)
        copy[i] = v[i];
}

/* Adds the dim-dimensional vectors v and w. The output can safely alias the 
input. */
void vecAdd(int dim, const double v[], const double w[], double vPlusW[]) {
    for (int i = 0; i < dim; i += 1)
        vPlusW[i] = v[i] + w[i];
}

/* Subtracts the dim-dimensional vectors v and w. The output can safely alias 
the input. */
void vecSubtract(
        int dim, const double v[], const double w[], double vMinusW[]) {
    for (int i = 0; i < dim; i += 1)
        vMinusW[i] = v[i] - w[i];
}

/* Scales the dim-dimensional vector w by the number c. The output can safely 
alias the input.*/
void vecScale(int dim, double c, const double w[], double cTimesW[]) {
    for (int i = 0; i < dim; i += 1)
        cTimesW[i] = c * w[i];
}

/* Given two vectors v and w of the same dimension, produces a third vector of 
the same dimension, obtained by multiplying v and w component-wise. The output 
can safely alias the input. */
void vecModulate(int dim, const double v[], const double w[], double vw[]) {
    for (int i = 0; i < dim; i += 1)
        vw[i] = v[i] * w[i];
}



/*** In specific dimensions ***/

/* By the way, it is possible, using stdarg.h, to write a single vecSet function 
that works in all dimensions. We're not going to take this approach for two 
reasons. First, I try not to burden you with learning a lot of C that isn't 
strictly necessary. Second, it's dangerous, in that it provides no type 
checking. */

/* Copies three numbers into a three-dimensional vector. */
void vec3Set(double a0, double a1, double a2, double a[3]) {
    a[0] = a0;
    a[1] = a1;
    a[2] = a2;
}

/* Copies four numbers into a four-dimensional vector. */
void vec4Set(double a0, double a1, double a2, double a3, double a[4]) {
    a[0] = a0;
    a[1] = a1;
    a[2] = a2;
    a[3] = a3;
}

/* Copies eight numbers into an eight-dimensional vector. */
void vec8Set(
        double a0, double a1, double a2, double a3, double a4, double a5, 
        double a6, double a7, double a[8]) {
    a[0] = a0;
    a[1] = a1;
    a[2] = a2;
    a[3] = a3;
    a[4] = a4;
    a[5] = a5;
    a[6] = a6;
    a[7] = a7;
}

/* Returns the dot product of the vectors v and w. */
double vecDot(int dim, const double v[], const double w[]) {
    double dot = 0;
    for (int i = 0 ; i < dim ; i++) {
        dot += (v[i] * w[i]);
    }
    return dot;
}

/* Returns the length of the vector v. */
double vecLength(int dim, const double v[]) {
    double length = 0;
    for (int i = 0 ; i < dim ; i++) {
        length += pow(v[i], 2);
    }
    return sqrt(length);
}

/* Returns the length of the vector v. If the length is non-zero, then also 
places a normalized (length-1) version of v into unit. The output can safely 
alias the input. */
double vecUnit(int dim, const double v[], double unit[]) {
    double length = vecLength(dim, v);
    if (length != 0) {
        for (int i = 0 ; i < dim ; i++) {
            unit[i] = v[i]/length;
        }
    }
    return length;
}

/* Computes the cross product of v and w, and places it into vCrossW. The 
output CANNOT safely alias the input. */
void vec3Cross(const double v[3], const double w[3], double vCrossW[3]) {
    vCrossW[0] = v[1] * w[2] - v[2] * w[1];
    vCrossW[1] = v[2] * w[0] - v[0] * w[2];
    vCrossW[2] = v[0] * w[1] - v[1] * w[0];
}

/* Computes the vector v from its spherical coordinates. rho >= 0.0 is the 
radius. 0 <= phi <= pi is the co-latitude. -pi <= theta <= pi is the longitude 
or azimuth. */
void vec3Spherical(double rho, double phi, double theta, double v[3]) {
    v[0] = rho * sin(phi) * cos(theta);
    v[1] = rho * sin(phi) * sin(theta);
    v[2] = rho * cos(phi);
}