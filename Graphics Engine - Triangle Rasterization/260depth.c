/*
    260depth.c
    C file defining a depth buffer and providing methods for interaction.
    Written by Josh Davis for Carleton College's CS311 - Computer Graphics.
*/

/*** Creating and destroying (once per program?) ***/

/* Feel free to read the struct's members, but don't write them, except through 
the accessors below such as depthSetDepth, etc. */
typedef struct depthBuffer depthBuffer;
struct depthBuffer {
	int width, height;
	double *depths;			/* width * height doubles */
};

/* Initializes a depth buffer. When you are finished with the buffer, you must 
call depthFinalize to deallocate its backing resources. */
int depthInitialize(depthBuffer *buf, int width, int height) {
	buf->depths = (double *)malloc(width * height * sizeof(double));
	if (buf->depths != NULL) {
		buf->width = width;
		buf->height = height;
	}
	return (buf->depths == NULL);
}

/* Deallocates the resources backing the buffer. This function must be called 
when you are finished using a buffer. */
void depthFinalize(depthBuffer *buf) {
	free(buf->depths);
}



/*** Regular use (on each frame) ***/

/* Sets every depth-value to the given depth. Typically you use this function 
at the start of each frame, passing a large positive value for depth. */
void depthClearDepths(depthBuffer *buf, double depth) {
	int i, j;
	for (i = 0; i < buf->width; i += 1)
		for (j = 0; j < buf->height; j += 1)
			buf->depths[i + buf->width * j] = depth;
}

/* Sets the depth-value at pixel (i, j) to the given depth. */
void depthSetDepth(depthBuffer *buf, int i, int j, double depth) {
	if (0 <= i && i < buf->width && 0 <= j && j < buf->height)
		buf->depths[i + buf->width * j] = depth;
}

/* Returns the depth-value at pixel (i, j). */
double depthGetDepth(const depthBuffer *buf, int i, int j) {
	if (0 <= i && i < buf->width && 0 <= j && j < buf->height)
		return buf->depths[i + buf->width * j];
	else
		/* There's no right answer, but we have to return something. */
		return 0.0;
}