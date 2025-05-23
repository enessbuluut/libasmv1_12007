#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include "test.h"

// Assembly fonksiyonumuz char* dönüyor gibi düþünelim
// ama hata için NULL döndürebiliriz, dönüþü char* yapýyoruz
char* my_strchr_wrapper(const char* str, const char* target) {
    int res = my_strchr(str, target);
    // Negatif hata kodlarý için NULL döndür
    if (res < 0) return NULL;
    // Pozitif ise adresi döndür (int -> char* cast)
    return (char*)res;
}

void test_my_strchr_vs_strchr(const char* str, const char* target) {
    printf("Testing: str=\"%s\", target=\"%s\"\n", str, target);

    char* my_result = my_strchr_wrapper(str, target);
    char* std_result = strchr(str, target[0]);

    if (my_result != NULL) {
        printf("  my_strchr found char: '%c' at pos: %ld\n", *my_result, (long)(my_result - str));
    }
    else {
        printf("  my_strchr did not find the character or error\n");
    }

    if (std_result != NULL) {
        printf("  strchr found char: '%c' at pos: %ld\n", *std_result, (long)(std_result - str));
    }
    else {
        printf("  strchr did not find the character\n");
    }

    if (my_result == std_result) {
        printf("  Result: MATCH\n");
    }
    else {
        printf("  Result: MISMATCH\n");
    }
    printf("\n");
}

int main() {
    test_my_strchr_vs_strchr("enesensenes", "s");
    test_my_strchr_vs_strchr("enesensenes", "e");
    test_my_strchr_vs_strchr("enesensenes", "x");
    test_my_strchr_vs_strchr("enesensenes", "");
    test_my_strchr_vs_strchr("", "a");
    test_my_strchr_vs_strchr("abcde", "\0");
    test_my_strchr_vs_strchr("abc\0def", "d");
    test_my_strchr_vs_strchr("abcde", "de");

    return 0;
}
