// cc 302mainTest.c 040pixel.o -lglfw -lGL -lm -ldl

#define WINDOWWIDTH 512.0
#define WINDOWHEIGHT 512.0

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "250vector.c"
#include "280matrix.c"
#include "300isometry.c"
#include "300camera.c"

int main(void) {
    double xAxis[3] = {1.0, 0.0, 0.0};
    double rotationAngle = M_PI/2.0;
    double rot[3][3];
    double translation[3] = {0.0, 0.0, 0.0};
    mat33AngleAxisRotation(rotationAngle, xAxis, rot);
    
    isoIsometry iso;
    double p[3] = {1.0/sqrt(2.0), 0.0, 1.0/sqrt(2.0)};
    double pRotated[3], pRotIden[3], pTranslated[3], pTranslIden[3];
    double homog[4][4], homogInv[4][4], homogIden[4][4];
    isoSetRotation(&iso, rot);
    isoSetTranslation(&iso, translation);

    camCamera cam;
    camSetProjectionType(&cam, camORTHOGRAPHIC);
    camSetFrustum(&cam, M_PI/6.0, 10.0, 10.0, WINDOWWIDTH, WINDOWHEIGHT);
    double homogCam[4][4];
    camGetProjectionInverseIsometry(&cam, homogCam);
    double target[3] = {1.0, 2.0, 3.0};
    camLookAt(&cam, target, 5.0, M_PI / 4.0, M_PI / 4.0);

    // camLookAt( camCamera *cam, const double target[3], double rho, double phi, double theta)
}