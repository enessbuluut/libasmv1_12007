#include <stdio.h>
#include <string.h>
#include "my_strncpy_s.h"

void print_buffer(const char* label, const char* buf, size_t size) {
    printf("%s: \"", label);
    for (size_t i = 0; i < size; i++) {
        if (buf[i] == '\0') {
            printf("\\0");
            break;
        }
        else {
            putchar(buf[i]);
        }
    }
    printf("\"\n");
}

int main() {
    char buffer[20];
    int ret;

    // 1. Normal durum, kaynak string hedefe s��ar
    ret = my_strncpy_s(buffer, sizeof(buffer), "Hello, World!", 5);
    printf("Test 1 ret: %d\n", ret);
    print_buffer("Buffer after Test 1", buffer, sizeof(buffer));

    // 2. Kopyalanacak karakter say�s� hedeften b�y�k (hata)
    ret = my_strncpy_s(buffer, 4, "Test", 5);
    printf("Test 2 ret (should be -1): %d\n", ret);

    // 3. Kaynak string daha k�sa, kalan k�s�m s�f�rlanmal�
    ret = my_strncpy_s(buffer, sizeof(buffer), "abc", 6);
    printf("Test 3 ret: %d\n", ret);
    print_buffer("Buffer after Test 3", buffer, sizeof(buffer));

    // 4. Kopyalanacak karakter say�s� s�f�r
    ret = my_strncpy_s(buffer, sizeof(buffer), "Non-empty", 0);
    printf("Test 4 ret (0 chars): %d\n", ret);
    print_buffer("Buffer after Test 4", buffer, sizeof(buffer));

    // 5. Hedef buffer boyutu tam olarak kopyalanacak karakter say�s�na e�it
    ret = my_strncpy_s(buffer, 5, "ABCDE", 5);
    printf("Test 5 ret: %d\n", ret);
    print_buffer("Buffer after Test 5", buffer, 5);

    // 6. Kaynak bo� string
    ret = my_strncpy_s(buffer, sizeof(buffer), "", 4);
    printf("Test 6 ret: %d\n", ret);
    print_buffer("Buffer after Test 6", buffer, sizeof(buffer));

    return 0;
}
