/*
    300isometry.c
    Class for isometry transformations.
    Designed by Josh Davis for Carleton College's CS311 - Computer Graphics.
    Written by Cole Weinstein and Robbie Young.
*/


/* Describes an isometry as a rotation followed by a translation. Can be used 
to describe the position and orientation of a rigid body. If the position is 
the translation, and the columns of the rotation are the local coordinate axes 
in global coordinates, then the isometry takes local coordinates to global. */

/* Feel free to read from, but not write to, this struct's members. */
typedef struct isoIsometry isoIsometry;
struct isoIsometry {
	double translation[3];
	double rotation[3][3];
};

/* Sets the rotation. */
void isoSetRotation(isoIsometry *iso, const double rot[3][3]) {
	vecCopy(9, (double *)rot, (double *)(iso->rotation));
}

/* Sets the translation. */
void isoSetTranslation(isoIsometry *iso, const double transl[3]) {
	vecCopy(3, transl, iso->translation);
}

/* Applies the rotation and translation to a point. The output CANNOT safely 
alias the input. */
void isoTransformPoint(
        const isoIsometry *iso, const double p[3], double isoP[3]) {
	mat331Multiply(iso->rotation, p, isoP);
	vecAdd(3, isoP, iso->translation, isoP);
}

/* Applies the inverse of the isometry to a point. If you transform a point and 
then untransform the result, then you recover the original point. Similarly, if 
you untransform a point and then transform the result, then you recover the 
original point. The output CANNOT safely alias the input. */
void isoUntransformPoint(
        const isoIsometry *iso, const double isoP[3], double p[3]) {
	double pUntranslated[3];
        vecSubtract(3, isoP, iso->translation, pUntranslated);
        mat331TransposeMultiply(iso->rotation, pUntranslated, p);
}

/* Applies the rotation to a direction vector (typically unit). The output 
CANNOT safely alias the input. */
void isoRotateDirection(
        const isoIsometry *iso, const double d[3], double rotD[3]) {
	mat331Multiply(iso->rotation, d, rotD);
}

/* Applies the inverse rotation to a direction vector (typically unit). The 
output CANNOT safely alias the input. */
void isoUnrotateDirection(
        const isoIsometry *iso, const double rotD[3], double d[3]) {
	mat331TransposeMultiply(iso->rotation, rotD, d);
}

/* Fills homog with the homogeneous version of the isometry. */
void isoGetHomogeneous(const isoIsometry *iso, double homog[4][4]) {
	mat44Isometry(iso->rotation, iso->translation, homog);
}

/* Fills homog with the homogeneous version of the inverse isometry. That is, 
the product of this matrix and the one from isoGetHomogeneous is the identity 
matrix. */
void isoGetInverseHomogeneous(const isoIsometry *iso, double homogInv[4][4]) {
	double inverseRotation[3][3], inverseTranslation[3]; 
    // note: inverseTranslation isn't actually ever the inverse of the translation vector. 
    // it's first the dot product of the inverse rotation matrix with the translation vector,
    // then it's the negative version of that. inverseTranslation ends up being the part of homog[][]
    // that results in a translation backwards by iso.translation, but it isn't directly (1)*iso.translation.

    // rotation transposed is the same as the inverse of the rotation.
    mat33Transpose(iso->rotation, inverseRotation);
    mat331Multiply(inverseRotation, iso->translation, inverseTranslation);

    // the inverse of the translation is the same as the negative of the translation
    vecScale(3, -1, inverseTranslation, inverseTranslation);
    mat44Isometry(inverseRotation, inverseTranslation, homogInv);
}