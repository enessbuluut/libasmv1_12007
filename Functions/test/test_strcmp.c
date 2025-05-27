#include <stdio.h>
#include "strcmp.h"  // Assembly fonksiyonunun deklarasyonunu dahil et

int main() {
    char* str1 = "babbba";
    char* str2 = "babxqweqweqw";

    int result = my_strcmp(str1, str2);  // Assembly fonksiyonunu çaðýr

    // Sonuçlarý kontrol et ve ekrana yazdýr
    if (result == 0) {
        printf("Strings are equal\n");
    }
    else if (result > 0) {
        printf("String 1 is greater\n");
    }
    else {
        printf("String 2 is greater\n");
    }

    return 0;
}
