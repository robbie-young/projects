


/* On macOS, compile with...
    clang 030mainFunctions.c
On Ubuntu, compile with...
    cc 030mainFunctions.c -lm
*/

#include <stdio.h>
#include <math.h>
/* stdlib.h and time.h are required by the random number generator below. */
#include <stdlib.h>
#include <time.h>

/* We have already seen one example of a function: the main function, which is 
the core of any C program. As in any programming language, we can write other 
functions to help the main function do its work. */

/* As input the following function takes one double, called 'x'. As output it 
returns a double, that is approximately cos(x). (The approximation is good for 
x near 0 but terrible for x far away from 0. If you've never seen this math, 
don't worry about the details.) */
double cosApprox(double x) {
    return 1.0 - x * x / 2.0 + x * x * x * x / 24.0;
}

/* This function inputs an int and outputs an int. Notice the recursion. */
int factorial(int n) {
    if (n == 0)
        return 1;
    else
        return n * factorial(n - 1);
}

/* A function that doesn't return anything has return type void. */
void printProduct(double x, double y) {
    printf("%f * %f = %f.\n", x, y, x * y);
}

/* Here's a function for computing integer powers of doubles. Notice the 
recursion. Also notice that we alter the exponent parameter. But this variable 
is not altered in the calling environment, because the function is operating on 
an independent copy of the variable in memory. C is 'call-by-value'. */
double power(double base, int exponent) {
    if (exponent < 0)
        return power(1.0 / base, -exponent);
    else {
        double answer;
        answer = 1.0;
        while (exponent > 0) {
            answer = answer * base;
            exponent = exponent - 1;
        }
        return answer;    
    }
}

/* Here's a function that takes no inputs and returns a random double in the 
interval [0, 1]. Before using this function, you must invoke srand to seed the 
random number generator. Warning: For several reasons, this is not a very good 
random number generator. Do not use it in serious code. */
double uniform(void) {
    return (double)rand() / RAND_MAX;
}

int main(void) {
    /* You invoke functions in the way you'd expect from other languages. */
    double x, y;
    x = 0.1;
    printf("cos(%f) = %f ~ %f.\n", x, cos(x), cosApprox(x));
    x = 1.1;
    printf("cos(%f) = %f ~ %f.\n", x, cos(x), cosApprox(x));
    x = 2.1;
    printf("cos(%f) = %f ~ %f.\n", x, cos(x), cosApprox(x));
    x = 3.1;
    printf("cos(%f) = %f ~ %f.\n", x, cos(x), cosApprox(x));
    x = 4.1;
    printf("cos(%f) = %f ~ %f.\n", x, cos(x), cosApprox(x));
    /* The following code is working perfectly, but there might be something 
    wrong with it?! */
    int i;
    for (i = 11; i <= 14; i = i + 1)
        printf("%d! = %d.\n", i, factorial(i));
    /* Here's our example of a void function. */
    y = 3.4;
    printProduct(x, y);
    /* In the code below, notice that the value of i doesn't change, although 
    power changes the value of exponent. That's call-by-value. */
    i = 3;
    y = power(x, i);
    printf("i = %d.\n", i);
    printf("power(%f, %d) = %f.\n", x, i, y);
    printf("i = %d.\n", i);
    /* Here's a demo of the random number generator. */
    srand(time(NULL));
    printf("uniform() is %f.\n", uniform());
    printf("uniform() is %f.\n", uniform());
    printf("uniform() is %f.\n", uniform());
    return 0;
}

