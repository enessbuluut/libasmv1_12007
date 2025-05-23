#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>

int my_strcat_s(char* dest, size_t dest_size, const char* src) {
    if (!dest || !src || dest_size == 0) {
        if (dest && dest_size > 0) dest[0] = '\0';
        return -1;
    }

    size_t dest_len = strlen(dest);
    size_t src_len = strlen(src);

    if (dest_len + src_len + 1 > dest_size) {
        dest[0] = '\0';
        return -1;
    }

    memcpy(dest + dest_len, src, src_len + 1);
    return 0;
}

int main(void) {
    char buffer[50] = "Hello";
    int ret = my_strcat_s(buffer, sizeof(buffer), " World");
    printf("Result: %s, Return: %d\n", buffer, ret);
    return 0;
}
