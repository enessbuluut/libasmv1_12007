#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include "my_strcpy.h"

void run_test(const char* test_name, const char* src_input) {
    char dest[256] = { 0 };          // hedef buffer
    char expected[256] = { 0 };      // karþýlaþtýrmak için standart strcpy

    // Beklenen sonuç
    strcpy(expected, src_input);

    // Assembly fonksiyonunu çaðýr
    my_strcpy(dest, src_input);

    // Sonucu karþýlaþtýr
    if (strcmp(dest, expected) == 0) {
        printf("[PASS] %s | Copied: \"%s\"\n", test_name, dest);
    }
    else {
        printf("[FAIL] %s | Got: \"%s\", Expected: \"%s\"\n", test_name, dest, expected);
    }
}

int main() {
    run_test("Normal String", "Hello, Assembly!");
    run_test("Empty String", "");
    run_test("Numeric", "1234567890");
    run_test("With Special Characters", "!@#$%^&*()_+-=[]{};':\",.<>/?");
    run_test("Multiline", "Line1\nLine2\nLine3");
    run_test("Long String", "This is a very very long test string to verify how strcpy handles large inputs.");
    run_test("Single Character", "A");
    run_test("Spaces Only", "     ");
    run_test("Null Terminator Inside", "Test\0Hidden"); // This tests up to the first \0 only.

    return 0;
}
