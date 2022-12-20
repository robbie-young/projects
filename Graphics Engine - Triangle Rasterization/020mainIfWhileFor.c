


/* On macOS, compile with...
    clang 020mainIfWhileFor.c
On Ubuntu, compile with...
    cc 020mainIfWhileFor.c -lm
*/

#include <stdio.h>
#include <math.h>

int main(void) {
    /* if statements work much as in other languages, so I'll skip the simplest 
    examples. When a branch consists of multiple statements, as in the first 
    else-branch below, then those statements must be enclosed by curly 
    brackets. Otherwise, the curly brackets are optional. */
    double numer, denom, ratio;
    numer = 17.3;
    denom = -4.1;
    if (denom == 0.0)
        printf("Error: Division by zero.\n");
    else {
        ratio = numer / denom;
        if (ratio > 0.0)
            printf("The ratio is positive.\n");
        else if (ratio == 0.0)
            printf("The ratio is zero.\n");
        else
            printf("The ratio is negative.\n");
    }
    /* As in other languages, a while loop is essentially a repeated if 
    statement. Usually the body consists of multiple statements and hence must 
    be enclosed by curly brackets. */
    while (numer > 1.5) {
        printf("numer is %f.\n", numer);
        numer = sqrt(numer);
    }
    /* As in other languages, a for loop is a special kind of while loop. The 
    first line of the loop consists of three sub-statements separated (not 
    terminated) by semicolons. The first sub-statement is executed once, at the 
    very start of the loop. Typically it initializes a counter. The second 
    sub-statement is a test or condition; once this condition is violated, the 
    loop ends. The third sub-statement is an arbitrary statement to be executed 
    once per loop iteration, at the very end of the loop body. Typically it 
    increments or decrements a counter.*/
    int i;
    for (i = 0; i < 7; i = i + 2) {
        printf("Here is i: %d.\n", i);
        printf("Here is denom^i: %f.\n", pow(denom, i));
    }
    /* In other words, the for loop above is functionally identical to the 
    following code. */
    i = 0;
    while (i < 7) {
        printf("Here is i: %d.\n", i);
        printf("Here is denom^i: %f.\n", pow(denom, i));
        i = i + 2;
    }
    /* Here is a demonstration of logical AND (&&), OR (||), and NOT (!). */
    for (i = 0; i < 20; i += 1) {
        if (i % 2 == 0 && i % 3 == 0)
            printf("%d is divisible by both 2 and 3.\n", i);
        if (i % 5 == 0 || i == 17)
            printf("%d is divisible by 5 or equal to 17.\n", i);
        if (!(i % 7 == 0 && i > 12))
            printf("%d is not both divisible by 7 and greater than 12.\n", i);
    }
    return 0;
}

