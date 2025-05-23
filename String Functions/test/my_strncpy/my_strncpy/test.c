// test.c

#include <stdio.h>
#include "_my_strncpy.h"

int main() {
    char dest1[20];
    char dest2[10];
    char dest3[15];

    const char* src1 = "Merhaba Dünya!";
    const char* src2 = "Kýsa";
    const char* src3 = "";

    // Test 1: Uzun kaynak, büyük hedef
    void* ret1 = my_strncpy(dest1, src1, 20);
    printf("Test 1:\n");
    printf("  Kaynak: \"%s\"\n", src1);
    printf("  Kopya : \"%s\"\n", dest1);
    printf("  Dönüþ (RET): %p (dest1: %p)\n\n", ret1, dest1);

    // Test 2: Kýsa kaynak, küçük hedef
    void* ret2 = my_strncpy(dest2, src2, 5);
    printf("Test 2:\n");
    printf("  Kaynak: \"%s\"\n", src2);
    printf("  Kopya : \"%s\"\n", dest2);
    printf("  Dönüþ (RET): %p (dest2: %p)\n\n", ret2, dest2);

    // Test 3: Boþ kaynak
    void* ret3 = my_strncpy(dest3, src3, 10);
    printf("Test 3:\n");
    printf("  Kaynak: \"%s\"\n", src3);
    printf("  Kopya : \"%s\"\n", dest3);
    printf("  Dönüþ (RET): %p (dest3: %p)\n\n", ret3, dest3);

    // Test 4: n == 0
    char dest4[10] = "XXXXXXXXX";
    my_strncpy(dest4, "Test", 0);
    printf("Test 4 (n==0): \"%s\"\n", dest4);

    // Test 5: src kýsa, n büyük
    char dest5[10];
    my_strncpy(dest5, "abc", 8);
    printf("Test 5 (src kýsa, n büyük): ");
    for (int i = 0; i < 10; ++i)
        printf("%02X ", (unsigned char)dest5[i]);
    printf("\n");

    // Test 6: src uzun, n küçük (null karakter olmayabilir!)
    char dest6[5];
    my_strncpy(dest6, "uzun_metinsel_veri", 5);
    printf("Test 6 (src uzun, n küçük): ");
    for (int i = 0; i < 5; ++i)
        printf("%02X ", (unsigned char)dest6[i]);
    printf(" (son karakter: %c)\n", dest6[4]);

    // Test 7: n büyük ama dest küçük (taþma riski — dikkat!)
    char dest7[5];
    my_strncpy(dest7, "BU TAÞAR", 20); // BUFFER OVERFLOW OLABÝLÝR!
    printf("Test 7 (buffer overflow riski): %s\n", dest7);

    // Test 8: NULL src (UNDEFINED BEHAVIOR - ÇÖKER)
    // my_strncpy(dest7, NULL, 4); // UNCOMMENT EDERSEN ÇÖKER




    return 0;
}
