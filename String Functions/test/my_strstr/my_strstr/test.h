#ifndef TEST_H
#define TEST_H

#ifdef __cplusplus
extern "C" {
#endif

	// Assembly ile yaz�lm�� fonksiyonun prototipi
	// Visual Studio genellikle __cdecl �a�r� konvansiyonunu varsayar
	char* __cdecl my_strstr(const char* haystack, const char* needle);

#ifdef __cplusplus
}
#endif

#endif // TEST_H
