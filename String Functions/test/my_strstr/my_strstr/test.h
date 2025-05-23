#ifndef TEST_H
#define TEST_H

#ifdef __cplusplus
extern "C" {
#endif

	// Assembly ile yazýlmýþ fonksiyonun prototipi
	// Visual Studio genellikle __cdecl çaðrý konvansiyonunu varsayar
	char* __cdecl my_strstr(const char* haystack, const char* needle);

#ifdef __cplusplus
}
#endif

#endif // TEST_H
