/*
    271triangle.c
    C file to rasterize a given triangle and render it. triRender and its subcalls interpolate the varyings passed into it, then invoke sha->shadeFragment for a fragment color and depth (after any number and type of artistic transformations). Only set pixel if fragment is
    the closest fragment to screen so far.
    Differs from 260triangle.c by implementing a check such that if a fragment is outside the window, we don't attempt to render it.
    Here, the check happens in triRenderHelper() (so that setPixel() isn't called). In 270triangle.c, the check happens in setPixel() (so that only one instance of the check is needed).
    Written by Cole Weinstein and Robbie Young for Carleton College's CS311 - Computer Graphics, taught by Josh Davis.
*/

void createA(const double a[], const double b[], const double c[], double m[2][2]) {
    double bMinusA[2];
    double cMinusA[2];
    vecSubtract(2, b, a, bMinusA);
    vecSubtract(2, c, a, cMinusA);
    mat22Columns(bMinusA, cMinusA, m);
}

void setPixel(
    const shaShading *sha, depthBuffer *buf, const double unif[], const texTexture *tex[], const double x[2], 
    const double a[], const double invertedItpCoeffs[2][2], 
    const double bMinusA[], const double cMinusA[]) {
    // variables which depend on the position of x, and therefore need to be calculated every time 
    // setPixel() is called.
    double xMinusA[2];
    double pq[2];
    double pBetaMinusAlpha[sha->varyDim]; // represents p(b - a)
    double qGammaMinusAlpha[sha->varyDim]; // represents q(c - a)
    double pBetaMinusAlphaPlusqGammaMinusAlpha[sha->varyDim]; // represents pBetaMinusAlpha + qGammaMinusAlpha = p(b - a) + q(c - a)
    double chi[sha->varyDim];  // interpolated varyings vector for x
    double rgbd[4]; // rgbd for sha->shadeFragment

    // computes p and q.
    vecSubtract(2, x, a, xMinusA);
    mat221Multiply(invertedItpCoeffs, xMinusA, pq);

    // linearly interpolates the texture coordinate at current pixel.
    vecScale(sha->varyDim, pq[0], bMinusA, pBetaMinusAlpha);
    vecScale(sha->varyDim, pq[1], cMinusA, qGammaMinusAlpha);
    vecAdd(sha->varyDim, pBetaMinusAlpha, qGammaMinusAlpha, pBetaMinusAlphaPlusqGammaMinusAlpha);
    vecAdd(sha->varyDim, a, pBetaMinusAlphaPlusqGammaMinusAlpha, chi);

    // initializes rgb to 'white' and calls sha->shadeFragment to get final rgb values. 
    // Writes new values to rgb.
    vec3Set(1.0, 1.0, 1.0, rgbd);
    sha->shadeFragment(sha->unifDim, unif, sha->texNum, tex, sha->varyDim, chi, rgbd);

    // checks if pixel should be rendered by comparing depth value from shadeFragment to depth value
    // currently stored at the pixel.
    double currDepth = depthGetDepth(buf, x[0], x[1]);
    if (currDepth > rgbd[3]) {
        depthSetDepth(buf, x[0], x[1], rgbd[3]);
        // sets the pixel to the color calculated by sha->shadeFragment.
        pixSetRGB((int)x[0], (int)x[1], rgbd[0], rgbd[1], rgbd[2]);
    }
}

/* Given a triangle and knowledge of its left-most vertex, rasterizes the triangle and renders it. */
/* Assumes that the 0th and 1th elements of a, b, c are the 'x' and 'y' 
coordinates of the vertices, respectively (used in rasterization, and to 
interpolate the other elements of a, b, c). */
void triRenderHelper(
        const shaShading *sha, depthBuffer *buf, const double unif[], const texTexture *tex[], 
        const double a[], const double b[], const double c[]) {
    
    // array for coordinates of current pixel. (used later)
    double x[2];
    x[0] = ceil(a[0]);
    // make sure that the x-coordinate of the fragment is in the window.
    if (x[0] < 0)
        x[0] = 0;
    
    // some variables used throughout the function (and calls to setPixel()) that do not require x[]
    // and can be calculated immediately.

    // creates the matrix A (to find p and q for the purposes of linear interpolation) and inverts it.
    double interpolateCoeffs[2][2];
    double invertedItpCoeffs[2][2];
    createA(a, b, c, interpolateCoeffs);
    // Checks determinant to implement backface culling; if determinant is negative or zero the triangle does not render
    if (mat22Invert(interpolateCoeffs, invertedItpCoeffs) <= 0) {
        return;
    }
    
    // computes 'b - a' and 'c - a', used later in linear interpolation calculations.
    double bMinusA[sha->varyDim];
    double cMinusA[sha->varyDim];
    vecSubtract(sha->varyDim, b, a, bMinusA);
    vecSubtract(sha->varyDim, c, a, cMinusA);

    // now, we render the triangle. the first three cases deal with triangles which have
    // vertical sides and thus only require one horizontally iterating loop. the vertically
    // iterating loop starts at the ceiling of the bottom edge, determined by the order of the
    // vertices, then runs until the floor of the top edge.
    
    // if a[0] == c[0], then the left edge (side ac) is vertical and we don't have to worry about rendering it.
    // since a -> b -> c is clockwise, we know a[1] < c[1].
    if (a[0] == c[0]) {
        // some checks happen here (and in every other else if) to ensure that the x[0] and x[1] coordinates stay within
        // the window at all times. we don't want to waste time rendering fragments that can't be seen.
        while (x[0] <= floor(b[0]) && x[0] <= WINDOWWIDTH){
            x[1] = ceil(a[1] + (b[1]-a[1])/(b[0]-a[0])*(x[0]-a[0]));
            // make sure that the y-coordinate of the fragment is in the window.
            if(x[1] < 0)
                x[1] = 0;
            while (x[1] <= floor(c[1] + (b[1]-c[1])/(b[0]-c[0])*(x[0]-c[0])) && x[1] <= WINDOWHEIGHT) {
                setPixel(sha, buf, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    // o.w., if a[0] == b[0], then the left edge (side ab) is vertical and we don't have to worry about rendering it.
    // sice a -> b -> c is clockwise, we know that a[1] > b[1].
    else if (a[0] == b[0]) {
        while (x[0] <= floor(c[0]) && x[0] <= WINDOWWIDTH){
            x[1] = ceil(b[1] + (c[1]-b[1])/(c[0]-b[0])*(x[0]-b[0]));
            if(x[1] < 0)
                x[1] = 0;
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0])) && x[1] <= WINDOWHEIGHT) {
                setPixel(sha, buf, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    // o.w., if b[0] == c[0], then the right edge (side bc) is vertical and we don't have to worry about rendering it.
    // (can't be left edge this time since a known to be left-most vertex.)
    // sice a -> b -> c is clockwise, we know that c[1] > b[1].
    else if (b[0] == c[0]) {
        while (x[0] <= floor(c[0]) && x[0] <= WINDOWWIDTH){
            x[1] = ceil(a[1] + (b[1]-a[1])/(b[0]-a[0])*(x[0]-a[0]));
            if(x[1] < 0)
                x[1] = 0;
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0])) && x[1] <= WINDOWHEIGHT) {
                setPixel(sha, buf, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    
    // the next two cases deal with triangles which have no vertical sides and thus require
    // two horizontally iterating loops. in summary, these loops together iterate over the
    // edge of the triangle covering the largest horizontal distance, and individually iterate
    // over the other two edges of the triangle, again, determined by the order of the vertices.
    
    // if b[0] < c[0], then loop from a[0] to c[0], reframing checks around b[0].
    else if (b[0] < c[0]) {
        while (x[0] <= floor(b[0]) && x[0] <= WINDOWWIDTH){
            x[1] = ceil(a[1] + (a[1]-b[1])/(a[0]-b[0])*(x[0]-a[0]));
            if(x[1] < 0)
                x[1] = 0;
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0])) && x[1] <= WINDOWHEIGHT) {
                setPixel(sha, buf, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
        while (x[0] <= floor(c[0]) && x[0] <= WINDOWWIDTH){
            x[1] = ceil(c[1] + (c[1]-b[1])/(c[0]-b[0])*(x[0]-c[0]));
            if(x[1] < 0)
                x[1] = 0;
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0])) && x[1] <= WINDOWHEIGHT) {
                setPixel(sha, buf, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
    // o.w., c[0] < b[0], so loop from a[0] to b[0] and reframe checks around c[0].
    else {
        while (x[0] <= floor(c[0]) && x[0] <= WINDOWWIDTH){
            x[1] = ceil(a[1] + (b[1]-a[1])/(b[0]-a[0])*(x[0]-a[0]));
            if(x[1] < 0)
                x[1] = 0;
            while (x[1] <= floor(a[1] + (c[1]-a[1])/(c[0]-a[0])*(x[0]-a[0])) && x[1] <= WINDOWHEIGHT) {
                setPixel(sha, buf, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
        while (x[0] <= floor(b[0]) && x[0] <= WINDOWWIDTH){
            x[1] = ceil(a[1] + (b[1]-a[1])/(b[0]-a[0])*(x[0]-a[0]));
            if(x[1] < 0)
                x[1] = 0;
            while (x[1] <= floor(b[1] + (c[1]-b[1])/(c[0]-b[0])*(x[0]-b[0])) && x[1] <= WINDOWHEIGHT) {
                setPixel(sha, buf, unif, tex, x, a, invertedItpCoeffs, bMinusA, cMinusA);
                x[1] = x[1] + 1;
            }
            x[0] = x[0] + 1;
        }
    }
}

/* Determines left-most vertex of a triangle and calls triRenderHelper() to render the triangle. */
/* Assumes that the 0th and 1th elements of a, b, c are the 'x' and 'y' coordinates of the vertices, 
respectively (used in rasterization, and to interpolate the other elements of a, b, c). */
/* Backface culling check performed in triRenderHelper(); */
void triRender(
        const shaShading *sha, depthBuffer *buf, const double unif[], const texTexture *tex[], 
        const double a[], const double b[], const double c[]) {
    if (a[0] <= b[0] && a[0] <= c[0])
        triRenderHelper(sha, buf, unif, tex, a, b, c);
    else if(b[0] <= a[0] && b[0] <= c[0])
        triRenderHelper(sha, buf, unif, tex, b, c, a);
    else
        triRenderHelper(sha, buf, unif, tex, c, a, b);
}