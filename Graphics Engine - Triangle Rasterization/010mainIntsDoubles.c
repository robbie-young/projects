


/* On macOS, compile with...
    clang 010mainIntsDoubles.c
On Ubuntu, compile with...
    cc 010mainIntsDoubles.c -lm
On either operating system, execute with...
    ./a.out
*/

/* This program needs not just input/output, but also some math functions. */
#include <stdio.h>
#include <math.h>

int main(void) {
    /* In C, you must declare a variable before you use it. The declaration 
    includes the type of the variable. The type cannot be changed. One 
    important type, that we've already seen, is int, for integers. */
    int n, m, nPlusM;
    /* Assignment and arithmetic behave as in most other languages. */
    n = 7;
    m = 8;
    nPlusM = n + m;
    /* To print an integer in decimal, use a '%d' code in printf. */
    printf("%d + %d = %d.\n", n, m, nPlusM);
    /* Another important type is double, for double-precision floating-point. */
    double x, y;
    x = M_PI;
    y = 2.0;
    /* To print a double in decimal, use a '%f' code in printf. */
    printf("sin(%f) = %f.\n", x, sin(x));
    printf("x is between %f and %f.\n", floor(x), ceil(x));
    /* Notice that the floor and ceiling are still doubles. Use the syntax 
    '(int)' to cast a double to an integer. */
    printf("floor(%f) is %f or %d.\n", x, floor(x), (int)floor(x));
    /* We could have entered y with value '2' rather than '2.0'. But I advise 
    you to always include decimal points in floating-point constants. The 
    following example illustrates how a bug can arise if you're not specific. */
    double z;
    z = 7 / 2.0;
    printf("z = %f\n", z);
    z = 7 / 2;
    printf("z = %f\n", z);
    /* C doesn't have an operator for powers, but it has a pow function. */
    printf("%f^2 = %f. Also, %f^2 = %f.\n", x, pow(x, y), x, x * x);
    /* C doesn't standardize the sizes of these types in memory. But you can 
    ascertain their sizes on your machine using the sizeof operator. It returns 
    an unsigned long, which you can cast to an int if you like. */
    printf("An int occupies %d bytes, and a double occupies %d bytes.\n",
        (int)sizeof(int), (int)sizeof(double));
    /* C offers at least seven other kinds of integers and at least one other 
    kind of floating-point number. Here are their sizes. But in this course we 
    almost exclusively use ints and doubles, to keep things simple. */
    printf("sizeof(unsigned int) = %d.\n", (int)sizeof(unsigned int));
    printf("sizeof(char) = %d and sizeof(unsigned char) = %d.\n", 
        (int)sizeof(char), (int)sizeof(unsigned char));
    printf("sizeof(short) = %d and sizeof(unsigned short) = %d.\n", 
        (int)sizeof(short), (int)sizeof(unsigned short));
    printf("sizeof(long) = %d and sizeof(unsigned long) = %d.\n", 
        (int)sizeof(long), (int)sizeof(unsigned long));
    printf("sizeof(float) = %d.\n", (int)sizeof(float));
    return 0;
}

