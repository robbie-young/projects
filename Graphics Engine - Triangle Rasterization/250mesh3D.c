/*
    250mesh3D.c
    A program defining some 3-dimensional meshes.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/


/*** 3D mesh builders ***/

/* Assumes that attributes 0, 1, 2 are XYZ. Assumes that the vertices of the 
triangle are in counter-clockwise order when viewed from 'outside' the 
triangle. Computes the outward-pointing unit normal vector for the triangle. 
The output CANNOT safely alias the input. */
void mesh3DTrueNormal(
        const double a[], const double b[], const double c[], 
        double normal[3]) {
    double bMinusA[3], cMinusA[3];
    vecSubtract(3, b, a, bMinusA);
    vecSubtract(3, c, a, cMinusA);
    vec3Cross(bMinusA, cMinusA, normal);
    vecUnit(3, normal, normal);
}

/* Assumes that attributes 0, 1, 2 are XYZ. Sets attributes n, n + 1, n + 2 to 
flat-shaded normals. If a vertex belongs to more than triangle, then some 
unspecified triangle's normal wins. */
void mesh3DFlatNormals(meshMesh *mesh, int n) {
    int i, *tri;
    double *a, *b, *c, normal[3];
    for (i = 0; i < mesh->triNum; i += 1) {
        tri = meshGetTrianglePointer(mesh, i);
        a = meshGetVertexPointer(mesh, tri[0]);
        b = meshGetVertexPointer(mesh, tri[1]);
        c = meshGetVertexPointer(mesh, tri[2]);
        mesh3DTrueNormal(a, b, c, normal);
        vecCopy(3, normal, &a[n]);
        vecCopy(3, normal, &b[n]);
        vecCopy(3, normal, &c[n]);
    }
}

/* Assumes that attributes 0, 1, 2 are XYZ. Sets attributes n, n + 1, n + 2 to 
smooth-shaded normals. Does not do anything special to handle multiple vertices 
with the same coordinates. */
void mesh3DSmoothNormals(meshMesh *mesh, int n) {
    int i, *tri;
    double *a, *b, *c, normal[3] = {0.0, 0.0, 0.0};
    /* Zero the normals. */
    for (i = 0; i < mesh->vertNum; i += 1) {
        a = meshGetVertexPointer(mesh, i);
        vecCopy(3, normal, &a[n]);
    }
    /* For each triangle, add onto the normal at each of its vertices. */
    for (i = 0; i < mesh->triNum; i += 1) {
        tri = meshGetTrianglePointer(mesh, i);
        a = meshGetVertexPointer(mesh, tri[0]);
        b = meshGetVertexPointer(mesh, tri[1]);
        c = meshGetVertexPointer(mesh, tri[2]);
        mesh3DTrueNormal(a, b, c, normal);
        vecAdd(3, normal, &a[n], &a[n]);
        vecAdd(3, normal, &b[n], &b[n]);
        vecAdd(3, normal, &c[n], &c[n]);
    }
    /* Normalize the normals. */
    for (i = 0; i < mesh->vertNum; i += 1) {
        a = meshGetVertexPointer(mesh, i);
        vecUnit(3, &a[n], &a[n]);
    }
}

/* Builds a mesh for a parallelepiped (box) of the given size. The attributes 
are XYZ position, ST texture, and NOP unit normal vector. The normals are 
discontinuous at the edges (flat shading, not smooth). To facilitate this, some 
vertices have equal XYZ but different NOP, for 24 vertices in all. Don't forget 
to meshFinalize when finished. */
int mesh3DInitializeBox(
        meshMesh *mesh, double left, double right, double bottom, double top, 
        double base, double lid) {
    int error = meshInitialize(mesh, 12, 24, 3 + 2 + 3);
    if (error == 0) {
        /* Make the triangles. */
        meshSetTriangle(mesh, 0, 0, 2, 1);
        meshSetTriangle(mesh, 1, 0, 3, 2);
        meshSetTriangle(mesh, 2, 4, 5, 6);
        meshSetTriangle(mesh, 3, 4, 6, 7);
        meshSetTriangle(mesh, 4, 8, 10, 9);
        meshSetTriangle(mesh, 5, 8, 11, 10);
        meshSetTriangle(mesh, 6, 12, 13, 14);
        meshSetTriangle(mesh, 7, 12, 14, 15);
        meshSetTriangle(mesh, 8, 16, 18, 17);
        meshSetTriangle(mesh, 9, 16, 19, 18);
        meshSetTriangle(mesh, 10, 20, 21, 22);
        meshSetTriangle(mesh, 11, 20, 22, 23);
        /* Make the vertices after 0, using vertex 0 as temporary storage. */
        double *v = mesh->vert;
        vec8Set(right, bottom, base, 1.0, 0.0, 0.0, 0.0, -1.0, v);
        meshSetVertex(mesh, 1, v);
        vec8Set(right, top, base, 1.0, 1.0, 0.0, 0.0, -1.0, v);
        meshSetVertex(mesh, 2, v);
        vec8Set(left, top, base, 0.0, 1.0, 0.0, 0.0, -1.0, v);
        meshSetVertex(mesh, 3, v);
        vec8Set(left, bottom, lid, 0.0, 0.0, 0.0, 0.0, 1.0, v);
        meshSetVertex(mesh, 4, v);
        vec8Set(right, bottom, lid, 1.0, 0.0, 0.0, 0.0, 1.0, v);
        meshSetVertex(mesh, 5, v);
        vec8Set(right, top, lid, 1.0, 1.0, 0.0, 0.0, 1.0, v);
        meshSetVertex(mesh, 6, v);
        vec8Set(left, top, lid, 0.0, 1.0, 0.0, 0.0, 1.0, v);
        meshSetVertex(mesh, 7, v);
        vec8Set(left, top, base, 0.0, 1.0, 0.0, 1.0, 0.0, v);
        meshSetVertex(mesh, 8, v);
        vec8Set(right, top, base, 1.0, 1.0, 0.0, 1.0, 0.0, v);
        meshSetVertex(mesh, 9, v);
        vec8Set(right, top, lid, 1.0, 1.0, 0.0, 1.0, 0.0, v);
        meshSetVertex(mesh, 10, v);
        vec8Set(left, top, lid, 0.0, 1.0, 0.0, 1.0, 0.0, v);
        meshSetVertex(mesh, 11, v);
        vec8Set(left, bottom, base, 0.0, 0.0, 0.0, -1.0, 0.0, v);
        meshSetVertex(mesh, 12, v);
        vec8Set(right, bottom, base, 1.0, 0.0, 0.0, -1.0, 0.0, v);
        meshSetVertex(mesh, 13, v);
        vec8Set(right, bottom, lid, 1.0, 0.0, 0.0, -1.0, 0.0, v);
        meshSetVertex(mesh, 14, v);
        vec8Set(left, bottom, lid, 0.0, 0.0, 0.0, -1.0, 0.0, v);
        meshSetVertex(mesh, 15, v);
        vec8Set(right, top, base, 1.0, 1.0, 1.0, 0.0, 0.0, v);
        meshSetVertex(mesh, 16, v);
        vec8Set(right, bottom, base, 1.0, 0.0, 1.0, 0.0, 0.0, v);
        meshSetVertex(mesh, 17, v);
        vec8Set(right, bottom, lid, 1.0, 0.0, 1.0, 0.0, 0.0, v);
        meshSetVertex(mesh, 18, v);
        vec8Set(right, top, lid, 1.0, 1.0, 1.0, 0.0, 0.0, v);
        meshSetVertex(mesh, 19, v);
        vec8Set(left, top, base, 0.0, 1.0, -1.0, 0.0, 0.0, v);
        meshSetVertex(mesh, 20, v);
        vec8Set(left, bottom, base, 0.0, 0.0, -1.0, 0.0, 0.0, v);
        meshSetVertex(mesh, 21, v);
        vec8Set(left, bottom, lid, 0.0, 0.0, -1.0, 0.0, 0.0, v);
        meshSetVertex(mesh, 22, v);
        vec8Set(left, top, lid, 0.0, 1.0, -1.0, 0.0, 0.0, v);
        meshSetVertex(mesh, 23, v);
        /* Now make vertex 0 for realsies. */
        vec8Set(left, bottom, base, 0.0, 0.0, 0.0, 0.0, -1.0, v);
    }
    return error;
}

/* Rotates a 2-dimensional vector through an angle. The output can safely alias 
the input. */
void mesh3DRotateVector(double theta, const double v[2], double vRot[2]) {
    double cosTheta = cos(theta);
    double sinTheta = sin(theta);
    double vRot0 = cosTheta * v[0] - sinTheta * v[1];
    vRot[1] = sinTheta * v[0] + cosTheta * v[1];
    vRot[0] = vRot0;
}

/* Rotate a curve about the Z-axis. Can be used to make a sphere, spheroid, 
capsule, circular cone, circular cylinder, box, etc. The z-values should be in 
ascending order --- or at least the first z should be less than the last. The 
first and last r-values should be 0.0, and no others. Probably the t-values 
should be in ascending or descending order. The sideNum parameter controls the 
fineness of the mesh. The attributes are XYZ position, ST texture, and NOP unit 
normal vector. The normals are smooth. Don't forget to meshFinalize when 
finished. */
int mesh3DInitializeRevolution(
        meshMesh *mesh, int zNum, const double z[], const double r[], 
        const double t[], int sideNum) {
    int i, j, error;
    error = meshInitialize(mesh, (zNum - 2) * sideNum * 2, 
        (zNum - 2) * (sideNum + 1) + 2, 3 + 2 + 3);
    if (error == 0) {
        /* Make the bottom triangles. */
        for (i = 0; i < sideNum; i += 1)
            meshSetTriangle(mesh, i, 0, i + 2, i + 1);
        /* Make the top triangles. */
        for (i = 0; i < sideNum; i += 1)
            meshSetTriangle(mesh, sideNum + i, mesh->vertNum - 1, 
                mesh->vertNum - 1 - (sideNum + 1) + i, 
                mesh->vertNum - 1 - (sideNum + 1) + i + 1);
        /* Make the middle triangles. */
        for (j = 1; j <= zNum - 3; j += 1)
            for (i = 0; i < sideNum; i += 1) {
                meshSetTriangle(mesh, 2 * sideNum * j + 2 * i,
                    (j - 1) * (sideNum + 1) + 1 + i, 
                    j * (sideNum + 1) + 1 + i + 1, 
                    j * (sideNum + 1) + 1 + i);
                meshSetTriangle(mesh, 2 * sideNum * j + 2 * i + 1,
                    (j - 1) * (sideNum + 1) + 1 + i, 
                    (j - 1) * (sideNum + 1) + 1 + i + 1, 
                    j * (sideNum + 1) + 1 + i + 1);
            }
        /* Make the vertices, using vertex 0 as temporary storage. */
        double *v = mesh->vert;
        double p[3], q[3], o[3];
        for (j = 1; j <= zNum - 2; j += 1) {
            // Form the sideNum + 1 vertices in the jth layer.
            vec3Set(z[j + 1] - z[j], 0.0, r[j] - r[j + 1], p);
            vecUnit(3, p, p);
            vec3Set(z[j] - z[j - 1], 0.0, r[j - 1] - r[j], q);
            vecUnit(3, q, q);
            vecAdd(3, p, q, o);
            vecUnit(3, o, o);
            vec8Set(r[j], 0.0, z[j], 1.0, t[j], o[0], o[1], o[2], v);
            meshSetVertex(mesh, j * (sideNum + 1), v);
            v[3] = 0.0;
            meshSetVertex(mesh, (j - 1) * (sideNum + 1) + 1, v);
            for (i = 1; i < sideNum; i += 1) {
                mesh3DRotateVector(2 * M_PI / sideNum, v, v);
                v[3] += 1.0 / sideNum;
                mesh3DRotateVector(2 * M_PI / sideNum, &v[5], &v[5]);
                meshSetVertex(mesh, (j - 1) * (sideNum + 1) + 1 + i, v);
            }
        }
        /* Form the top vertex. */
        vec8Set(0.0, 0.0, z[zNum - 1], 0.0, 1.0, 0.0, 0.0, 1.0, v);
        meshSetVertex(mesh, mesh->vertNum - 1, v);
        /* Finally form the bottom vertex, which is set implicitly. */
        vec8Set(0.0, 0.0, z[0], 0.0, 0.0, 0.0, 0.0, -1.0, v);
    }
    return error;
}

/* Builds a mesh for a sphere, centered at the origin, of radius r. The sideNum 
and layerNum parameters control the fineness of the mesh. The attributes are 
XYZ position, ST texture, and NOP unit normal vector. The normals are smooth. 
Don't forget to meshFinalize when finished. */
int mesh3DInitializeSphere(
        meshMesh *mesh, double r, int layerNum, int sideNum) {
    int error, i;
    double *ts = (double *)malloc((layerNum + 1) * 3 * sizeof(double));
    if (ts == NULL)
        return 1;
    else {
        double *zs = &ts[layerNum + 1];
        double *rs = &ts[2 * layerNum + 2];
        for (i = 0; i <= layerNum; i += 1) {
            ts[i] = (double)i / layerNum;
            zs[i] = -r * cos(ts[i] * M_PI);
            rs[i] = r * sin(ts[i] * M_PI);
        }
        error = mesh3DInitializeRevolution(mesh, layerNum + 1, zs, rs, ts, 
            sideNum);
        free(ts);
        return error;
    }
}

/* Builds a mesh for a circular cylinder with spherical caps, centered at the 
origin, of radius r and length l > 2 * r. The sideNum and layerNum parameters 
control the fineness of the mesh. The attributes are XYZ position, ST texture, 
and NOP unit normal vector. The normals are smooth. Don't forget to meshFinalize 
when finished. */
int mesh3DInitializeCapsule(
        meshMesh *mesh, double r, double l, int layerNum, int sideNum) {
    int error, i;
    double theta;
    double *ts = (double *)malloc((2 * layerNum + 2) * 3 * sizeof(double));
    if (ts == NULL)
        return 1;
    else {
        double *zs = &ts[2 * layerNum + 2];
        double *rs = &ts[4 * layerNum + 4];
        zs[0] = -l / 2.0;
        rs[0] = 0.0;
        ts[0] = 0.0;
        for (i = 1; i <= layerNum; i += 1) {
            theta = M_PI / 2.0 * (3 + i / (double)layerNum);
            zs[i] = -l / 2.0 + r + r * sin(theta);
            rs[i] = r * cos(theta);
            ts[i] = (zs[i] + l / 2.0) / l;
        }
        for (i = 0; i < layerNum; i += 1) {
            theta = M_PI / 2.0 * i / (double)layerNum;
            zs[layerNum + 1 + i] = l / 2.0 - r + r * sin(theta);
            rs[layerNum + 1 + i] = r * cos(theta);
            ts[layerNum + 1 + i] = (zs[layerNum + 1 + i] + l / 2.0) / l;
        }
        zs[2 * layerNum + 1] = l / 2.0;
        rs[2 * layerNum + 1] = 0.0;
        ts[2 * layerNum + 1] = 1.0;
        error = mesh3DInitializeRevolution(mesh, 2 * layerNum + 2, zs, rs, ts, 
            sideNum);
        free(ts);
        return error;
    }
}

/* Builds a mesh for a circular cylinder, centered at the origin, of radius r 
and length l. The sideNum parameter controls the fineness of the mesh. The 
attributes are XYZ position, ST texture, and NOP unit normal vector. The normals 
are smooth except where the side meets the ends. Don't forget to meshFinalize 
when finished. */
int mesh3DInitializeCylinder(meshMesh *mesh, double r, double l, int sideNum) {
    int triNum = 4 * sideNum;
    int vertNum = 4 * sideNum + 4;
    int error = meshInitialize(mesh, triNum, vertNum, 3 + 2 + 3);
    if (error != 0)
        return error;
    double fraction, attr[3 + 2 + 3];
    /* Make the 2 * sideNum + 2 side vertices. */
    attr[7] = 0.0;
    for (int i = 0; i < sideNum; i += 1) {
        fraction = (double)i / sideNum;
        attr[5] = cos(2.0 * M_PI * fraction);
        attr[6] = sin(2.0 * M_PI * fraction);
        vecScale(2, r, &(attr[5]), attr);
        attr[2] = -0.5 * l;
        attr[3] = fraction;
        attr[4] = 0.0;
        meshSetVertex(mesh, 2 * i, attr);
        attr[2] = 0.5 * l;
        attr[4] = 1.0;
        meshSetVertex(mesh, 2 * i + 1, attr);
    }
    attr[5] = cos(0.0);
    attr[6] = sin(0.0);
    vecScale(2, r, &(attr[5]), attr);
    attr[2] = -0.5 * l;
    attr[3] = 1.0;
    attr[4] = 0.0;
    meshSetVertex(mesh, 2 * sideNum, attr);
    attr[2] = 0.5 * l;
    attr[4] = 1.0;
    meshSetVertex(mesh, 2 * sideNum + 1, attr);
    /* Make the sideNum + 1 top vertices. */
    attr[2] = 0.5 * l;
    attr[3] = 0.0;
    attr[4] = 1.0;
    vec3Set(0.0, 0.0, 1.0, &(attr[5]));
    for (int i = 0; i < sideNum; i += 1) {
        attr[0] = r * cos(2.0 * M_PI * (double)i / sideNum);
        attr[1] = r * sin(2.0 * M_PI * (double)i / sideNum);
        meshSetVertex(mesh, 2 * sideNum + 2 + i, attr);
    }
    attr[0] = 0.0;
    attr[1] = 0.0;
    meshSetVertex(mesh, 2 * sideNum + 2 + sideNum, attr);
    /* Make the sideNum + 1 bottom vertices. */
    attr[2] = -0.5 * l;
    attr[3] = 0.0;
    attr[4] = 0.0;
    vec3Set(0.0, 0.0, -1.0, &(attr[5]));
    for (int i = 0; i < sideNum; i += 1) {
        attr[0] = r * cos(2.0 * M_PI * (double)i / sideNum);
        attr[1] = r * sin(2.0 * M_PI * (double)i / sideNum);
        meshSetVertex(mesh, 3 * sideNum + 3 + i, attr);
    }
    attr[0] = 0.0;
    attr[1] = 0.0;
    meshSetVertex(mesh, 3 * sideNum + 3 + sideNum, attr);
    /* Make the 2 * sideNum side triangles. */
    for (int i = 0; i < sideNum; i += 1) {
        meshSetTriangle(mesh, 2 * i, 2 * i, 2 * i + 2, 2 * i + 3);
        meshSetTriangle(mesh, 2 * i + 1, 2 * i, 2 * i + 3, 2 * i + 1);
    }
    /* Make the sideNum top triangles. */
    for (int i = 0; i < sideNum - 1; i += 1)
        meshSetTriangle(mesh, 2 * sideNum + i, 3 * sideNum + 2, 
            2 * sideNum + 2 + i, 2 * sideNum + 3 + i);
    meshSetTriangle(mesh, 3 * sideNum - 1, 3 * sideNum + 2, 3 * sideNum + 1, 
        2 * sideNum + 2);
    /* Make the sideNum bottom triangles. */
    for (int i = 0; i < sideNum - 1; i += 1)
        meshSetTriangle(mesh, 3 * sideNum + i, 4 * sideNum + 3, 
            3 * sideNum + 4 + i, 3 * sideNum + 3 + i);
    meshSetTriangle(mesh, 4 * sideNum - 1, 4 * sideNum + 3, 3 * sideNum + 3, 
        4 * sideNum + 2);
    return 0;
}

/* Builds a non-closed 'landscape' mesh based on a grid of Z-values. There are 
size * size Z-values, which arrive in the data parameter. The mesh is made of 
(size - 1) * (size - 1) squares, each made of two triangles. The spacing 
parameter controls the spacing of the X- and Y-coordinates of the vertices. The 
attributes are XYZ position, ST texture, and NOP unit normal vector. Don't 
forget to call meshFinalize when finished with the mesh. To understand the exact 
layout of the data, try this example code:
double zs[3][3] = {
    {10.0, 9.0, 7.0}, 
    {6.0, 5.0, 3.0}, 
    {4.0, 3.0, -1.0}};
int error = mesh3DInitializeLandscape(&mesh, 3, 20.0, (double *)zs); */
int mesh3DInitializeLandscape(
        meshMesh *mesh, int size, double spacing, const double *data) {
    int i, j, error;
    int a, b, c, d;
    double *vert, diffSWNE, diffSENW;
    error = meshInitialize(mesh, 2 * (size - 1) * (size - 1), size * size, 
        3 + 2 + 3);
    if (error == 0) {
        /* Build the vertices with normals set to 0. */
        for (i = 0; i < size; i += 1)
            for (j = 0; j < size; j += 1) {
                vert = meshGetVertexPointer(mesh, i * size + j);
                vec8Set(i * spacing, j * spacing, data[i * size + j], 
                    (double)i, (double)j, 0.0, 0.0, 0.0, vert);
            }
        /* Build the triangles. */
        for (i = 0; i < size - 1; i += 1)
            for (j = 0; j < size - 1; j += 1) {
                int index = 2 * (i * (size - 1) + j);
                a = i * size + j;
                b = (i + 1) * size + j;
                c = (i + 1) * size + (j + 1);
                d = i * size + (j + 1);
                diffSWNE = fabs(meshGetVertexPointer(mesh, a)[2] - 
                    meshGetVertexPointer(mesh, c)[2]);
                diffSENW = fabs(meshGetVertexPointer(mesh, b)[2] - 
                    meshGetVertexPointer(mesh, d)[2]);
                if (diffSENW < diffSWNE) {
                    meshSetTriangle(mesh, index, d, a, b);
                    meshSetTriangle(mesh, index + 1, b, c, d);
                } else {
                    meshSetTriangle(mesh, index, a, b, c);
                    meshSetTriangle(mesh, index + 1, a, c, d);
                }
            }
        /* Set the normals. */
        mesh3DSmoothNormals(mesh, 5);
    }
    return error;
}

/* Given a landscape, such as that built by meshInitializeLandscape. Builds a 
new landscape mesh by extracting triangles based on how horizontal they are. If 
noMoreThan is true, then triangles are kept that deviate from horizontal by no more than angle. If noMoreThan is false, then triangles are kept that deviate 
from horizontal by more than angle. Don't forget to call meshFinalize when 
finished. Warning: May contain extraneous vertices not used by any triangle. */
int mesh3DInitializeDissectedLandscape(
        meshMesh *mesh, const meshMesh *land, double angle, int noMoreThan) {
    int error, i, j = 0, triNum = 0;
    int *tri, *newTri;
    double normal[3];
    /* Count the triangles that are nearly horizontal. */
    for (i = 0; i < land->triNum; i += 1) {
        tri = meshGetTrianglePointer(land, i);
        mesh3DTrueNormal(meshGetVertexPointer(land, tri[0]), 
            meshGetVertexPointer(land, tri[1]), 
            meshGetVertexPointer(land, tri[2]), normal);
        if ((noMoreThan && normal[2] >= cos(angle)) || 
                (!noMoreThan && normal[2] < cos(angle)))
            triNum += 1;
    }
    error = meshInitialize(mesh, triNum, land->vertNum, 3 + 2 + 3);
    if (error == 0) {
        /* Copy all of the vertices. */
        vecCopy(land->vertNum * (3 + 2 + 3), land->vert, mesh->vert);
        /* Copy just the horizontal triangles. */
        for (i = 0; i < land->triNum; i += 1) {
            tri = meshGetTrianglePointer(land, i);
            mesh3DTrueNormal(meshGetVertexPointer(land, tri[0]), 
                meshGetVertexPointer(land, tri[1]), 
                meshGetVertexPointer(land, tri[2]), normal);
            if ((noMoreThan && normal[2] >= cos(angle)) || 
                    (!noMoreThan && normal[2] < cos(angle))) {
                newTri = meshGetTrianglePointer(mesh, j);
                newTri[0] = tri[0];
                newTri[1] = tri[1];
                newTri[2] = tri[2];
                j += 1;
            }
        }
        /* Reset the normals, to make the cliff edges appear sharper. */
        mesh3DSmoothNormals(mesh, 5);
    }
    return error;
}