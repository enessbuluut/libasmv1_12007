// _my_strncpy.h

#ifndef MY_STRNCPY_H
#define MY_STRNCPY_H

#ifdef __cplusplus
extern "C" {
#endif

	// Assembly'de tanýmlý fonksiyon prototipi
	// Visual Studio'da .obj olarak baðlanacak
	void* my_strncpy(char* dest, const char* src, unsigned int n);

#ifdef __cplusplus
}
#endif

#endif // MY_STRNCPY_H
