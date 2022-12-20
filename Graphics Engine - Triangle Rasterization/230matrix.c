/*
    230matrix.c
    Interface for performing operations on matrices.
    Designed by Josh Davis for Carleton College's CS311 - Computer Graphics. Implementations written by Cole Weinstein.
*/


/*** 2 x 2 Matrices ***/

/* Pretty-prints the given matrix, with one line of text per row of matrix. */
void mat22Print(const double m[2][2]) {
    int i, j;
    for (i = 0; i < 2; i += 1) {
        for (j = 0; j < 2; j += 1)
            printf("%f    ", m[i][j]);
        printf("\n");
    }
}

/* Returns the determinant of the matrix m. If the determinant is 0.0, then the 
matrix is not invertible, and mInv is untouched. If the determinant is not 0.0, 
then the matrix is invertible, and its inverse is placed into mInv. The output 
CANNOT safely alias the input. */
double mat22Invert(const double m[2][2], double mInv[2][2]) {
    double det = m[0][0]*m[1][1] - m[0][1]*m[1][0];
    if (det != 0){
        mInv[0][0] = m[1][1] / det;
        mInv[0][1] = -m[0][1] / det;
        mInv[1][0] = -m[1][0] / det;
        mInv[1][1] = m[0][0] / det;
    }
    return det;
}

/* Multiplies a 2x2 matrix m by a 2-column v, storing the result in mTimesV. 
The output CANNOT safely alias the input. */
void mat221Multiply(const double m[2][2], const double v[2], 
        double mTimesV[2]) {
    mTimesV[0] = m[0][0]*v[0] + m[0][1]*v[1];
    mTimesV[1] = m[1][0]*v[0] + m[1][1]*v[1];
}

/* Fills the matrix m from its two columns. The output CANNOT safely alias the 
input. */
void mat22Columns(const double col0[2], const double col1[2], double m[2][2]) {
    m[0][0] = col0[0];
    m[0][1] = col1[0];
    m[1][0] = col0[1];
    m[1][1] = col1[1];
}

/* The theta parameter is an angle in radians. Sets the matrix m to the 
rotation matrix corresponding to counterclockwise rotation of the plane through 
the angle theta. */
void mat22Rotation(double theta, double m[2][2]) {
    m[0][0] = cos(theta);
    m[0][1] = (-1)*sin(theta);
    m[1][0] = sin(theta);
    m[1][1] = cos(theta);
}


/*** 3 x 3 Matrices ***/

/* Multiplies the 3x3 matrix m by the 3x3 matrix n. The output CANNOT safely 
alias the input. */
void mat333Multiply(
        const double m[3][3], const double n[3][3], double mTimesN[3][3]) {
    for (int i = 0 ; i < 3 ; i++) {
        for (int j = 0 ; j < 3 ; j++) {
            mTimesN[i][j] = 0;
            for (int k = 0 ; k < 3 ; k++) {
                mTimesN[i][j] += m[i][k] * n[k][j];
            }
        }
    }
        }
/* Multiplies the 3x3 matrix m by the 3x1 matrix v. The output CANNOT safely 
alias the input. */
void mat331Multiply(
        const double m[3][3], const double v[3], double mTimesV[3]) {
    mTimesV[0] = m[0][0]*v[0] + m[0][1]*v[1] + m[0][2]*v[2];
    mTimesV[1] = m[1][0]*v[0] + m[1][1]*v[1] + m[1][2]*v[2];
    mTimesV[2] = m[0][0]*v[0] + m[0][1]*v[1] + m[2][2]*v[2];
        }

/* Builds a 3x3 matrix representing 2D rotation and translation in homogeneous 
coordinates. More precisely, the transformation first rotates through the angle 
theta (in radians, counterclockwise), and then translates by the vector t. */
void mat33Isometry(double theta, const double t[2], double isom[3][3]) {
    isom[0][0] = cos(theta);
    isom[0][1] = (-1)*sin(theta);
    isom[0][2] = t[0];
    
    isom[1][0] = sin(theta);
    isom[1][1] = cos(theta);
    isom[1][2] = t[1];

    isom[2][0] = 0;
    isom[2][1] = 0;
    isom[2][2] = 1;
}