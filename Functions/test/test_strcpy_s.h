#ifndef MYSTRCPY_S_H
#define MYSTRCPY_S_H

#include <stddef.h>  // size_t için

// mystrcpy_s fonksiyonunun deklarasyonu
errno_t my_strcpy_s(char* dest, size_t destsz, const char* src);

#endif
