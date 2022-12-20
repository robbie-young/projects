/*
    200triangle.c
    C file to rasterize a given triangle and render it. triRender and its subcalls interpolate the varyings passed into it, then invoke shadeFragment for a pixel color (after any number and type of artistic transformations).
    Written by Cole Weinstein and Robbie Young for Carleton College's CS311 - Computer Graphics, taught by Josh Davis.
*/

void createA(const double a[], const double b[], const double c[], double m[2][2]) {
    double bMinusA[2];
    double cMinusA[2];
    vecSubtract(2, b, a, bMinusA);
    vecSubtract(2, c, a, cMinusA);
    mat22Columns(bMinusA, cMinusA, m);
}

void setPixelColor(
    const shaShading *sha, const double unif[], const texTexture *tex[], const double x[2], 
    const double a[], const double invertedItpCoeffs[2][2], 
    const double bMinusA[], const double cMinusA[]) {
    // variables which depend on the position of x, and therefore need to be calculated every time 
    // setPixelColor() is called.
    double xMinusA[2];
    double pq[2];
    double pBetaMinusAlpha[sha->varyDim]; // represents p(b - a)
    double qGammaMinusAlpha[sha->varyDim]; // represents q(c - a)
    double pBetaMinusAlphaPlusqGammaMinusAlpha[sha->varyDim]; // represents pBetaMinusAlpha + qGammaMinusAlpha = p(b - a) + q(c - a)
    double chi[sha->varyDim];  // interpolated varyings vector for x
    double rgb[3]; // rgb for shadeFragment

    // computes p and q.
    vecSubtract(2, x, a, xMinusA);
    mat221Multiply(invertedItpCoeffs, xMinusA, pq);

    // linearly interpolates the texture coordinate at current pixel.
    vecScale(sha->varyDim, pq[0], bMinusA, pBetaMinusAlpha);
    vecScale(sha->varyDim, pq[1], cMinusA, qGammaMinusAlpha);
    vecAdd(sha->varyDim, pBetaMinusAlpha, qGammaMinusAlpha, pBetaMinusAlphaPlusqGammaMinusAlpha);
    vecAdd(sha->varyDim, a, pBetaMinusAlphaPlusqGammaMinusAlpha, chi);

    // initializes rgb to 'white' and calls shadeFragment to get final rgb values. 
    // Writes new values to rgb.
    vec3Set(1.0, 1.0, 1.0, rgb);
    shadeFragment(sha->unifDim, unif, sha->texNum, tex, sha->varyDim, chi, rgb);

    //sets the pixel to the color calculated by shadeFragment.
    pixSetRGB((int)x[0], (int)x[1], rgb[0], rgb[1], rgb[2]);
}

/* Given a triangle and knowledge of its left-most vertex, rasterizes the triangle and renders it. */
/* Assumes that the 0th and 1th elements of a, b, c are the 'x' and 'y' 
coordinates of the vertices, respectively (used in rasterization, and to 
interpolate the other elements of a, b, c). */
void triRenderHelper(
        const shaShading *sha, const double unif[], const texTexture *tex[], 
        const double a[], const double b[], const double c[]) {
    
    // array for coordinates of current pixel. (used later)
    double x[2];
    x[0] = ceil(a[VARYX]);
    
    // some variables used throughout the function (and calls to setPixelColor()) that do not require x[]
    // and can be calculated immediately. these are used entirely in setPixelColor(), but we calculate them 
    // here to avoid a bunch of repeated calculations later.

    // creates the matrix A (to find p and q for the purposes of linear interpolation) and inverts it.
    double interpolateCoeffs[2][2];
    double invertedItpCoeffs[2][2];
    createA(a, b, c, interpolateCoeffs);
    mat22Invert(interpolateCoeffs, invertedItpCoeffs);

    // computes 'b - a' and 'c - a', used later in linear interpolation calculations.
    double bMinusA[sha->varyDim];
    double cMinusA[sha->varyDim];
    vecSubtract(sha->varyDim, b, a, bMinusA);
    vecSubtract(sha->varyDim, c, a, cMinusA);

    // now, we render the triangle. the first three cases deal with triangles which have
    // vertical sides and thus only require one horizontally iterating loop. the vertically
    // iterating loop starts at the ceiling of the bottom edge, determined by the order of the
    // vertices, then runs until the floor of the top edge.
    
    // if a[VARYX] == c[VARYX], then the left edge (side ac) is vertical and we don't have to worry about rendering it.
    // since a -> b -> c is clockwise, we know a[VARYY] < c[VARYY].
    if (a[VARYX] == c[VARYX]) {
        while (x[0] <= floor(b[VARYX])){
            x[1] = ceil(a[VARYY] + (b[VARYY]-a[VARYY])/(b[VARYX]-a[VARYX])*(x[0]-a[VARYX]));
            while (x[1] <= floor(c[VARYY] + (b[VARYY]-c[VARYY])/(b[VARYX]-c[VARYX])*(x[0]-c[VARYX]))) {
                setPixelColor(sha, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    // o.w., if a[VARYX] == b[VARYX], then the left edge (side ab) is vertical and we don't have to worry about rendering it.
    // sice a -> b -> c is clockwise, we know that a[VARYY] > b[VARYY].
    else if (a[VARYX] == b[VARYX]) {
        while (x[0] <= floor(c[VARYX])){
            x[1] = ceil(b[VARYY] + (c[VARYY]-b[VARYY])/(c[VARYX]-b[VARYX])*(x[0]-b[VARYX]));
            while (x[1] <= floor(a[VARYY] + (c[VARYY]-a[VARYY])/(c[VARYX]-a[VARYX])*(x[0]-a[VARYX]))) {
                setPixelColor(sha, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    // o.w., if b[VARYX] == c[VARYX], then the right edge (side bc) is vertical and we don't have to worry about rendering it.
    // (can't be left edge this time since a known to be left-most vertex.)
    // sice a -> b -> c is clockwise, we know that c[VARYY] > b[VARYY].
    else if (b[VARYX] == c[VARYX]) {
        while (x[0] <= floor(c[VARYX])){
            x[1] = ceil(a[VARYY] + (b[VARYY]-a[VARYY])/(b[VARYX]-a[VARYX])*(x[0]-a[VARYX]));
            while (x[1] <= floor(a[VARYY] + (c[VARYY]-a[VARYY])/(c[VARYX]-a[VARYX])*(x[0]-a[VARYX]))) {
                setPixelColor(sha, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    
    // the next two cases deal with triangles which have no vertical sides and thus require
    // two horizontally iterating loops. in summary, these loops together iterate over the
    // edge of the triangle covering the largest horizontal distance, and individually iterate
    // over the other two edges of the triangle, again, determined by the order of the vertices.
    
    // if b[VARYX] < c[VARYX], then loop from a[VARYX] to c[VARYX], reframing checks around b[VARYX].
    else if (b[VARYX] < c[VARYX]) {
        while (x[0] <= floor(b[VARYX])){
            x[1] = ceil(a[VARYY] + (a[VARYY]-b[VARYY])/(a[VARYX]-b[VARYX])*(x[0]-a[VARYX]));
            while (x[1] <= floor(a[VARYY] + (c[VARYY]-a[VARYY])/(c[VARYX]-a[VARYX])*(x[0]-a[VARYX]))) {
                setPixelColor(sha, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
        while (x[0] <= floor(c[VARYX])){
            x[1] = ceil(c[VARYY] + (c[VARYY]-b[VARYY])/(c[VARYX]-b[VARYX])*(x[0]-c[VARYX]));
            while (x[1] <= floor(a[VARYY] + (c[VARYY]-a[VARYY])/(c[VARYX]-a[VARYX])*(x[0]-a[VARYX]))) {
                setPixelColor(sha, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    // o.w., c[VARYX] < b[VARYX], so loop from a[VARYX] to b[VARYX] and reframe checks around c[VARYX].
    else {
        while (x[0] <= floor(c[VARYX])){
            x[1] = ceil(a[VARYY] + (b[VARYY]-a[VARYY])/(b[VARYX]-a[VARYX])*(x[0]-a[VARYX]));
            while (x[1] <= floor(a[VARYY] + (c[VARYY]-a[VARYY])/(c[VARYX]-a[VARYX])*(x[0]-a[VARYX]))) {
                setPixelColor(sha, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
        while (x[0] <= floor(b[VARYX])){
            x[1] = ceil(a[VARYY] + (b[VARYY]-a[VARYY])/(b[VARYX]-a[VARYX])*(x[0]-a[VARYX]));
            while (x[1] <= floor(b[VARYY] + (c[VARYY]-b[VARYY])/(c[VARYX]-b[VARYX])*(x[0]-b[VARYX]))) {
                setPixelColor(sha, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
}

/* Determines left-most vertex of a triangle and calls triRenderHelper() to render the triangle. */
/* Assumes that the 0th and 1th elements of a, b, c are the 'x' and 'y' coordinates of the vertices, 
respectively (used in rasterization, and to interpolate the other elements of a, b, c). */
void triRender(
        const shaShading *sha, const double unif[], const texTexture *tex[], 
        const double a[], const double b[], const double c[]) {
    if (a[VARYX] <= b[VARYX] && a[VARYX] <= c[VARYX])
        triRenderHelper(sha, unif, tex, a, b, c);
    else if(b[VARYX] <= a[VARYX] && b[VARYX] <= c[VARYX])
        triRenderHelper(sha, unif, tex, b, c, a);
    else
        triRenderHelper(sha, unif, tex, c, a, b);
}