


/* This text, enclosed in a matching slash-asterisk pair, is a comment.

To use this program, you must first 'compile' it --- meaning, translate it into 
the machine language of your computer. Then you can execute the compiled 
program.

To do this on macOS, open the Terminal application. Use commands such as pwd, 
cd, and ls to navigate to the directory where you have stored this program. 
(See the Unix tutorial on our course web site for more detail.) Then type...

    clang 000mainHelloWorld.c

...to compile the program into an executable file called 'a.out'. If you're instead working in Ubuntu Linux, then type...

    cc 000mainHelloWorld.c

On either operating system, then type...

    ./a.out

...to execute the program. Do all of this now. Observe the program's output. 
Then come back here and study the code. */



/* This first line of code makes the program aware of some basic input and 
output functions, defined in a file called stdio.h in the C standard library. */
#include <stdio.h>

/* This next block of code defines a function called 'main'. In a C program, 
execution starts at this main function. It is the core of the program. As input 
it takes no arguments, which is signaled by the keyword 'void'. As output it 
returns an integer. The body of the function is enclosed in curly brackets. */
int main(void) {
    /* This statement prints a message followed by a newline character. */
    printf("Hello, world.\n");
    /* Returning 0 signals 'no error' to the operating system. */
    return 0;
    /* Notice that every statement in the function body is terminated by a 
    semicolon. */
}