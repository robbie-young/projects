#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "250vector.c"
#include "280matrix.c"
#include "300isometry.c"

int main(void) {
    double xAxis[3] = {1.0, 0.0, 0.0};
    double rotationAngle = M_PI/2.0;
    double rot[3][3], rotTranspose[3][3], rotIden[3][3];
    double translation[3] = {0.0, 0.0, 0.0};
    mat33AngleAxisRotation(rotationAngle, xAxis, rot);
    
    isoIsometry iso;
    double p[3] = {1.0/sqrt(2.0), 0.0, 1.0/sqrt(2.0)};
    double pRotated[3], pRotIden[3], pTranslated[3], pTranslIden[3];
    double homog[4][4], homogInv[4][4], homogIden[4][4];
    isoSetRotation(&iso, rot);
    isoSetTranslation(&iso, translation);

    isoRotateDirection(&iso, p, pRotated);
    isoUnrotateDirection(&iso, pRotated, pRotIden);
    isoTransformPoint(&iso, p, pTranslated);
    isoUntransformPoint(&iso, pTranslated, pTranslIden);
    isoGetHomogeneous(&iso, homog);
    isoGetInverseHomogeneous(&iso, homogInv);
    mat444Multiply(homog, homogInv, homogIden);

    printf("p: [%f, %f, %f]\n\n", p[0], p[1], p[2]);
    
    printf("pRotated: [%f, %f, %f]\n\n", pRotated[0], pRotated[1], pRotated[2]);

    printf("pRotIden: [%f, %f, %f]\n\n", pRotIden[0], pRotIden[1], pRotIden[2]);

    printf("pTranslated: [%f, %f, %f]\n\n", pTranslated[0], pTranslated[1], pTranslated[2]);

    printf("pTranslIden: [%f, %f, %f]\n\n", pTranslIden[0], pTranslIden[1], pTranslIden[2]);
    
    printf("homog:\n");
    for (int i = 0; i < 4; i++) {
        printf("[%f, %f, %f, %f]\n", homog[i][0], homog[i][1], homog[i][2], homog[i][3]);
    }
    printf("\n");

    printf("homogInv:\n");
    for (int i = 0; i < 4; i++) {
        printf("[%f, %f, %f, %f]\n", homogInv[i][0], homogInv[i][1], homogInv[i][2], homogInv[i][3]);
    }
    printf("\n");

    printf("homogIden:\n");
    for (int i = 0; i < 4; i++) {
        printf("[%f, %f, %f, %f]\n", homogIden[i][0], homogIden[i][1], homogIden[i][2], homogIden[i][3]);
    }
    printf("\n");
}