#include <stdio.h>
#include "mystrcpy_s.h"  // Header dosyam�z� ekliyoruz

int main() {
    // Test stringleri
    char src[] = "Hello, Assembly!";
    char dest[10];  // Yeterli b�y�k bir hedef dizi

    // my_strcpy_s fonksiyonunu �a��r�yoruz
    errno_t result = my_strcpy_s(dest, sizeof(dest), src);

    if (result == 1) {
        printf("String kopyaland�: %s\n", dest);  // Kopyalanan stringi yazd�r�yoruz
    }
    else {
        printf("Hata olu�tu, kopyalama ba�ar�s�z.\n");
    }

    return 0;
}
