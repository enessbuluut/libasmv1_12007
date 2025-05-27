// test.c

#include <stdio.h>
#include "_my_strncpy.h"

int main() {
    char dest1[20];
    char dest2[10];
    char dest3[15];

    const char* src1 = "Merhaba D�nya!";
    const char* src2 = "K�sa";
    const char* src3 = "";

    // Test 1: Uzun kaynak, b�y�k hedef
    void* ret1 = my_strncpy(dest1, src1, 20);
    printf("Test 1:\n");
    printf("  Kaynak: \"%s\"\n", src1);
    printf("  Kopya : \"%s\"\n", dest1);
    printf("  D�n�� (RET): %p (dest1: %p)\n\n", ret1, dest1);

    // Test 2: K�sa kaynak, k���k hedef
    void* ret2 = my_strncpy(dest2, src2, 5);
    printf("Test 2:\n");
    printf("  Kaynak: \"%s\"\n", src2);
    printf("  Kopya : \"%s\"\n", dest2);
    printf("  D�n�� (RET): %p (dest2: %p)\n\n", ret2, dest2);

    // Test 3: Bo� kaynak
    void* ret3 = my_strncpy(dest3, src3, 10);
    printf("Test 3:\n");
    printf("  Kaynak: \"%s\"\n", src3);
    printf("  Kopya : \"%s\"\n", dest3);
    printf("  D�n�� (RET): %p (dest3: %p)\n\n", ret3, dest3);

    // Test 4: n == 0
    char dest4[10] = "XXXXXXXXX";
    my_strncpy(dest4, "Test", 0);
    printf("Test 4 (n==0): \"%s\"\n", dest4);

    // Test 5: src k�sa, n b�y�k
    char dest5[10];
    my_strncpy(dest5, "abc", 8);
    printf("Test 5 (src k�sa, n b�y�k): ");
    for (int i = 0; i < 10; ++i)
        printf("%02X ", (unsigned char)dest5[i]);
    printf("\n");

    // Test 6: src uzun, n k���k (null karakter olmayabilir!)
    char dest6[5];
    my_strncpy(dest6, "uzun_metinsel_veri", 5);
    printf("Test 6 (src uzun, n k���k): ");
    for (int i = 0; i < 5; ++i)
        printf("%02X ", (unsigned char)dest6[i]);
    printf(" (son karakter: %c)\n", dest6[4]);

    // Test 7: n b�y�k ama dest k���k (ta�ma riski � dikkat!)
    char dest7[5];
    my_strncpy(dest7, "BU TA�AR", 20); // BUFFER OVERFLOW OLAB�L�R!
    printf("Test 7 (buffer overflow riski): %s\n", dest7);

    // Test 8: NULL src (UNDEFINED BEHAVIOR - ��KER)
    // my_strncpy(dest7, NULL, 4); // UNCOMMENT EDERSEN ��KER




    return 0;
}
