#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdint.h>
#include "test.h"

// Yardýmcý fonksiyon: intptr_t sonucu deðerlendirip yazdýrýyor
void print_result(const char* haystack, const char* needle, intptr_t result, int test_num) {
    printf("Test %d: haystack=\"%s\", needle=\"%s\" --> ", test_num, haystack, needle);
    if (result == -1) {
        printf("Not found\n");
    }
    else if (result == -2) {
        printf("Invalid input\n");
    }
    else {
        printf("Found at index %ld\n", (long)(result - (intptr_t)haystack));
    }
}

int main() {
    print_result("samanlýktaigne", "igne", my_strstr("samanlýktaigne", "igne"), 1);
    print_result("hello world", "world", my_strstr("hello world", "world"), 2);
    print_result("hello world", "worl", my_strstr("hello world", "worl"), 3);
    print_result("hello world", "world!", my_strstr("hello world", "world!"), 4);

    print_result("", "", my_strstr("", ""), 5);
    print_result("", "a", my_strstr("", "a"), 6);
    print_result("abc", "", my_strstr("abc", ""), 7);

    print_result("abcdef", "xyz", my_strstr("abcdef", "xyz"), 8);

    print_result("abcdef", "abc", my_strstr("abcdef", "abc"), 9);
    print_result("abcdef", "def", my_strstr("abcdef", "def"), 10);
    print_result("abcdef", "cd", my_strstr("abcdef", "cd"), 11);

    print_result("abcdef", "a", my_strstr("abcdef", "a"), 12);
    print_result("abcdef", "f", my_strstr("abcdef", "f"), 13);

    print_result("abc", "abcdef", my_strstr("abc", "abcdef"), 14);

    print_result("hello\0world", "world", my_strstr("hello\0world", "world"), 15);
    print_result("hello\nworld", "\nwo", my_strstr("hello\nworld", "\nwo"), 16);

    print_result("aaaaaa", "aaa", my_strstr("aaaaaa", "aaa"), 17);
    print_result("exactmatch", "exactmatch", my_strstr("exactmatch", "exactmatch"), 18);

    return 0;
}
