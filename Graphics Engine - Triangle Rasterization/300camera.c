/*
    300camera.c
    A camera class, used for projection transformations. The camera is now treated as its own object
    in the scene. Upgraded from 280camera.c to include functions to control the camera's position and orientation.
    Designed by Josh Davis for Carleton College's CS311 - Computer Graphics.
    Implementations written by Cole Weinstein and Robbie Young.
*/

/* Feel free to read from this struct's members, but don't write to them. */
typedef struct camCamera camCamera;
struct camCamera {
	double projection[6];
	int projectionType;
	isoIsometry isometry;
};



/*** Projections ***/

#define camORTHOGRAPHIC 0
#define camPERSPECTIVE 1
#define camPROJL 0
#define camPROJR 1
#define camPROJB 2
#define camPROJT 3
#define camPROJF 4
#define camPROJN 5

/* Sets the projection type, to either camORTHOGRAPHIC or camPERSPECTIVE. */
void camSetProjectionType(camCamera *cam, int projType) {
	cam->projectionType = projType;
}

/* Sets all six projection parameters. */
void camSetProjection(camCamera *cam, const double proj[6]) {
	vecCopy(6, proj, cam->projection);
}

/* Sets one of the six projection parameters. */
void camSetOneProjection(camCamera *cam, int i, double value) {
	cam->projection[i] = value;
}

/* Builds a 4x4 matrix representing orthographic projection with a boxy viewing 
volume [left, right] x [bottom, top] x [far, near]. That is, on the near plane 
the box is the rectangle R = [left, right] x [bottom, top], and on the far 
plane the box is the same rectangle R. Keep in mind that 0 > near > far. Maps 
the viewing volume to [-1, 1] x [-1, 1] x [-1, 1], with far going to 1 and near 
going to -1. */
void camGetOrthographic(const camCamera *cam, double proj[4][4]) {
	double left = cam->projection[camPROJL];
	double right = cam->projection[camPROJR];
	double bottom = cam->projection[camPROJB];
	double top = cam->projection[camPROJT];
	double far = cam->projection[camPROJF];
	double near = cam->projection[camPROJN];
	mat44Zero(proj);
    proj[0][0] = 2.0 / (right - left);
	proj[0][3] = (-right - left) / (right - left);
	proj[1][1] = 2.0 / (top - bottom);
	proj[1][3] = (-top - bottom) / (top - bottom);
	proj[2][2] = -2.0 / (near - far);
	proj[2][3] = (near + far) / (near - far);
	proj[3][3] = 1.0;
}

/* Inverse to the matrix produced by camGetOrthographic. */
void camGetInverseOrthographic(const camCamera *cam, double proj[4][4]) {
	double left = cam->projection[camPROJL];
	double right = cam->projection[camPROJR];
	double bottom = cam->projection[camPROJB];
	double top = cam->projection[camPROJT];
	double far = cam->projection[camPROJF];
	double near = cam->projection[camPROJN];
	mat44Zero(proj);
	proj[0][0] = (right - left) / 2.0;
	proj[0][3] = (right + left) / 2.0;
	proj[1][1] = (top - bottom) / 2.0;
	proj[1][3] = (top + bottom) / 2.0;
	proj[2][2] = (near - far) / -2.0;
	proj[2][3] = (near + far) / 2.0;
	proj[3][3] = 1.0;
}

/* Builds a 4x4 matrix representing perspective projection. The viewing frustum 
is contained between the near and far planes, with 0 > near > far. On the near 
plane, the frustum is the rectangle R = [left, right] x [bottom, top]. On the 
far plane, the frustum is the rectangle (far / near) * R. Maps the viewing 
volume to [-1, 1] x [-1, 1] x [-1, 1], with far going to 1 and near going to 
-1. */
void camGetPerspective(const camCamera *cam, double proj[4][4]) {
	double left = cam->projection[camPROJL];
	double right = cam->projection[camPROJR];
	double bottom = cam->projection[camPROJB];
	double top = cam->projection[camPROJT];
	double far = cam->projection[camPROJF];
	double near = cam->projection[camPROJN];
	mat44Zero(proj);
	proj[0][0] = (-2.0 * near) / (right - left);
	proj[0][2] = (right + left) / (right - left);
	proj[1][1] = (-2.0 * near) / (top - bottom);
	proj[1][2] = (top + bottom) / (top - bottom);
	proj[2][2] = (near + far) / (near - far);
	proj[2][3] = (-2.0 * near * far) / (near - far);
	proj[3][2] = -1.0;
}

/* Inverse to the matrix produced by camGetPerspective. */
void camGetInversePerspective(const camCamera *cam, double proj[4][4]) {
	double left = cam->projection[camPROJL];
	double right = cam->projection[camPROJR];
	double bottom = cam->projection[camPROJB];
	double top = cam->projection[camPROJT];
	double far = cam->projection[camPROJF];
	double near = cam->projection[camPROJN];
	mat44Zero(proj);
	proj[0][0] = (right - left) / (-2.0 * near);
    proj[0][3] = (right + left) / (-2.0 * near);
    proj[1][1] = (top - bottom) / (-2.0 * near);
    proj[1][3] = (top + bottom) / (-2.0 * near);
    proj[2][3] = -1.0;
    proj[3][2] = (near - far) / (-2.0 * near * far);
    proj[3][3] = (near + far) / (-2.0 * near * far);
}



/*** Convenience functions for projection ***/

/* Sets the six projection parameters, based on the width and height of the 
viewport and three other parameters. The camera looks down the center of the 
viewing volume. For perspective projection, fovy is the full (not half) 
vertical angle of the field of vision, in radians. focal > 0 is the distance 
from the camera to the 'focal' plane (where 'focus' is used in the sense of 
attention, not optics). ratio expresses the far and near clipping planes 
relative to focal: far = -focal * ratio and near = -focal / ratio. Reasonable 
values are fovy = M_PI / 6.0, focal = 10.0, and ratio = 10.0, so that 
far = -100.0 and near = -1.0. For orthographic projection, the projection 
parameters are set to produce the orthographic projection that, at the focal 
plane, is most similar to the perspective projection just described. You must 
re-invoke this function after each time you resize the viewport. */
void camSetFrustum(
        camCamera *cam, double fovy, double focal, double ratio, double width, 
        double height) {
	cam->projection[camPROJF] = -focal * ratio;
	cam->projection[camPROJN] = -focal / ratio;
	double tanHalfFovy = tan(fovy * 0.5);
	if (cam->projectionType == camPERSPECTIVE)
		cam->projection[camPROJT] = -cam->projection[camPROJN] * tanHalfFovy;
	else
		cam->projection[camPROJT] = focal * tanHalfFovy;
	cam->projection[camPROJB] = -cam->projection[camPROJT];
	cam->projection[camPROJR] = cam->projection[camPROJT] * width / height;
	cam->projection[camPROJL] = -cam->projection[camPROJR];
}

/* Returns the homogeneous 4x4 product of the camera's projection and the 
camera's inverse isometry (regardless of whether the camera is in orthographic 
or perspective mode). */
void camGetProjectionInverseIsometry(const camCamera *cam, double homog[4][4]) {
	double proj[4][4];
    if (cam->projectionType == camORTHOGRAPHIC) {
        camGetOrthographic(cam, proj);
    } else {
		camGetPerspective(cam, proj);
	}
    double invIsom[4][4];
    isoGetInverseHomogeneous(&(cam->isometry), invIsom);
    mat444Multiply(proj, invIsom, homog);
}

// /*** Convenience functions for isometry ***/

/* Sets the camera's isometry, in a manner suitable for third-person viewing. 
The camera is aimed at the world coordinates target. The camera itself is 
displaced from that target by a distance rho, in the direction specified by the 
spherical coordinates phi and theta (as in vec3Spherical). Under normal use, 
where 0 < phi < pi, the camera's up-direction is world-up, or as close to it as 
possible. */
void camLookAt(
        camCamera *cam, const double target[3], double rho, double phi, 
		double theta) {
	double z[3], y[3], yStd[3] = {0.0, 1.0, 0.0}, zStd[3] = {0.0, 0.0, 1.0};
	double rot[3][3], trans[3];
	vec3Spherical(1.0, phi, theta, z);
	vec3Spherical(1.0, M_PI / 2.0 - phi, theta + M_PI, y);
	mat33BasisRotation(yStd, zStd, y, z, rot);
	isoSetRotation(&(cam->isometry), rot);
	vecScale(3, rho, z, trans);
	vecAdd(3, target, trans, trans);
	isoSetTranslation(&(cam->isometry), trans);
}

/* Sets the camera's isometry, in a manner suitable for first-person viewing. 
The camera is positioned at the world coordinates position. From that position, 
the camera's sight direction is described by the spherical coordinates phi and 
theta (as in vec3Spherical). Under normal use, where 0 < phi < pi, the camera's 
up-direction is world-up, or as close to it as possible. */
void camLookFrom(
        camCamera *cam, const double position[3], double phi, double theta) {
	double negZ[3], y[3], yStd[3] = {0.0, 1.0, 0.0};
	double negZStd[3] = {0.0, 0.0, -1.0}, rot[3][3];
	vec3Spherical(1.0, phi, theta, negZ);
	vec3Spherical(1.0, M_PI / 2.0 - phi, theta + M_PI, y);
	mat33BasisRotation(yStd, negZStd, y, negZ, rot);
	isoSetRotation(&(cam->isometry), rot);
	isoSetTranslation(&(cam->isometry), position);
}