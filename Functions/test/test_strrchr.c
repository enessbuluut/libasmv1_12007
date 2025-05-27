#include <stdio.h>
#include <string.h>
#include "test.h"

// Helper function to safely call my_strrchr and print the result
void run_test(const char* input_str, const char* char_to_find, const char* test_name) {
    printf("---- %s ----\n", test_name);

    void* result = my_strrchr(input_str, char_to_find);

    if (result == (void*)-1) {
        printf("Result: [ERROR] Invalid input - character buffer must contain only one character.\n");
    }
    else if (result == (void*)-2) {
        printf("Result: [ERROR] Input string pointer is NULL.\n");
    }
    else if (result == NULL) {
        printf("Result: Character not found in the string.\n");
    }
    else {
        printf("Result: Character found at offset %ld: '%c'\n", (char*)result - input_str, *(char*)result);
        printf("Remaining string from match: \"%s\"\n", (char*)result);
    }

    printf("\n");
}

int main() {
    // Test cases
    const char* test_string = "assembly is fun and fast!";
    const char valid_char = 'a';
    const char not_in_str = 'z';
    const char null_char = '\0';
    const char* multi_char = "ab"; // Invalid
    const char* null_str = NULL;

    run_test(test_string, &valid_char, "Test 1: Normal character match");
    run_test(test_string, &not_in_str, "Test 2: Character not found");
    run_test(test_string, &null_char, "Test 3: Search for null terminator");
    run_test(test_string, multi_char, "Test 4: Invalid character input (more than 1 char)");
    run_test(null_str, &valid_char, "Test 5: NULL string pointer");

    return 0;
}
