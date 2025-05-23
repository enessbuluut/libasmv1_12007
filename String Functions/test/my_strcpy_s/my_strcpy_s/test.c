#include <stdio.h>
#include "mystrcpy_s.h"  // Header dosyamýzý ekliyoruz

int main() {
    // Test stringleri
    char src[] = "Hello, Assembly!";
    char dest[10];  // Yeterli büyük bir hedef dizi

    // my_strcpy_s fonksiyonunu çaðýrýyoruz
    errno_t result = my_strcpy_s(dest, sizeof(dest), src);

    if (result == 1) {
        printf("String kopyalandý: %s\n", dest);  // Kopyalanan stringi yazdýrýyoruz
    }
    else {
        printf("Hata oluþtu, kopyalama baþarýsýz.\n");
    }

    return 0;
}
