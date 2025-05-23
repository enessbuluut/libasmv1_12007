#include <stdio.h>
#include "strncmp.h"

int main() {
    const char* str1 = "OpenAI";
    const char* str2 = "OpenA";
    int n = 5;

    int result = _strncmp(str1, str2, n);

    if (result == 0) {
        printf("The strings are equal (up to %d characters).\n", n);
    }
    else if (result > 0) {
        printf("\"%s\" is greater than \"%s\" (up to %d characters).\n", str1, str2, n);
    }
    else if (result < 0) {
        printf("\"%s\" is less than \"%s\" (up to %d characters).\n", str1, str2, n);
    }
    else if (result == 31) {
        printf("Invalid input: n must be greater than 0.\n");
    }

    return 0;
}
