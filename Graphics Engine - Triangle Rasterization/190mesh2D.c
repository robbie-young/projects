/*
    Implements functions to build some 2D meshes.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/


/*** 2D mesh builders ***/

/* Initializes a mesh to two triangles forming a rectangle of the given sides. 
The four attributes are X, Y, S, T. Do not call meshInitialize separately; it 
is called inside this function. Don't forget to call meshFinalize when done. */
int mesh2DInitializeRectangle(
        meshMesh *mesh, double left, double right, double bottom, double top) {
    int error = meshInitialize(mesh, 2, 4, 2 + 2);
    if (error != 0)
        return error;
    meshSetTriangle(mesh, 0, 0, 1, 2);
    meshSetTriangle(mesh, 1, 0, 2, 3);
    double attr[4];
    vec4Set(left, bottom, 0.0, 0.0, attr);
    meshSetVertex(mesh, 0, attr);
    vec4Set(right, bottom, 1.0, 0.0, attr);
    meshSetVertex(mesh, 1, attr);
    vec4Set(right, top, 1.0, 1.0, attr);
    meshSetVertex(mesh, 2, attr);
    vec4Set(left, top, 0.0, 1.0, attr);
    meshSetVertex(mesh, 3, attr);
    return 0;
}

/* Initializes a mesh to sideNum triangles forming an ellipse of the given 
center (x, y) and radii rx, ry. The four attributes are X, Y, S, T. Do not call 
meshInitialize separately; it is called inside this function. Don't forget to 
call meshFinalize when done. */
int mesh2DInitializeEllipse(
        meshMesh *mesh, double x, double y, double rx, double ry, int sideNum) {
    int i, error;
    double theta, cosTheta, sinTheta, attr[4] = {x, y, 0.5, 0.5};
    error = meshInitialize(mesh, sideNum, sideNum + 1, 2 + 2);
    if (error != 0)
        return error;
    meshSetVertex(mesh, 0, attr);
    for (i = 0; i < sideNum; i += 1) {
        meshSetTriangle(mesh, i, 0, i + 1, (i + 1) % sideNum + 1);
        theta = i * 2.0 * M_PI / sideNum;
        cosTheta = cos(theta);
        sinTheta = sin(theta);
        vec4Set(x + rx * cosTheta, y + ry * sinTheta, 
            0.5 * cosTheta + 0.5, 0.5 * sinTheta + 0.5, attr);
        meshSetVertex(mesh, i + 1, attr);
    }
    return 0;
}

/* Other ideas: capsule, annulus, arbitrary simple polygon, ... */

