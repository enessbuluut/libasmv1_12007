#ifndef MY_STRNCPY_S_H
#define MY_STRNCPY_S_H

#ifdef __cplusplus
extern "C" {
#endif

	// Hedef buffer pointer, hedef buffer size, kaynak pointer, kopyalanacak karakter say�s�
	// Ba�ar�: 0 d�ner, hata: -1 d�ner
	int my_strncpy_s(char* dest, size_t dest_size, const char* src, size_t count);

#ifdef __cplusplus
}
#endif

#endif // MY_STRNCPY_S_H
