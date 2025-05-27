#include <stdio.h>
#include <windows.h>

extern int my_scanf(const char* format, ...);

int main() {
    char str[100];
    char str2[100];
    char str3[100];
    int num;
    char ch;

    // Test 14
        // Test 13
    memset(str, 0, sizeof(str));
    printf("Test 13: 15 karakter girin (örn: naber test 123): ");
    int ret = my_scanf("%15c", str);
    printf("Okunan string: %s, Dönüş değeri: %d\n\n", str, ret);

    printf("Test 14: Uzun tamsayı girin (örn: 123456789012345): ");
    ret = my_scanf("%5d", &num);
    printf("Okunan tamsayı: %d, Dönüş değeri: %d\n\n", num, ret);
    // Test 6: Boş giriş testi
    printf("Test 6: Boş giriş testi (direkt enter): ");
    ret = my_scanf("%s", str);
    printf("Okunan string: %s, Dönüş değeri: %d\n\n", str, ret);
    // Test 1: Tek bir string (%s) ve özel karakterler
    printf("Test 1: Bir string girin (örn: naber123!): ");
    ret = my_scanf("%s", str);
    printf("Okunan string: %s, Dönüş değeri: %d\n\n", str, ret);

    // Test 2: Bir tamsayı (%d) ve geçersiz giriş
    printf("Test 2: Bir tamsayı girin (örn: 42, geçersiz için: enes): ");
    ret = my_scanf("%d", &num);
    printf("Okunan tamsayı: %d, Dönüş değeri: %d\n\n", num, ret);

    // Test 3: Bir karakter (%c) ve Türkçe karakter
    printf("Test 3: Bir karakter girin (örn: ş veya x): ");
    ret = my_scanf("%c", &ch);
    printf("Okunan karakter: %c, Dönüş değeri: %d\n\n", ch, ret);

    // Test 4: Birden fazla giriş (%s %d %c) ve boşluklu giriş
    printf("Test 4: String, tamsayı ve karakter girin (örn: nabar 42 x, veya naber   123   y): ");
    ret = my_scanf("%s %d %c", str, &num, &ch);
    printf("Okunanlar: string=%s, tamsayı=%d, karakter=%c, Dönüş değeri: %d\n\n", str, num, ch, ret);

    // Test 5: Hatalı format stringi (%x)
    printf("Test 5: Hatalı format testi (örn: 5c1023): ");
    ret = my_scanf("%x", &num);
    printf("Dönüş değeri (hata bekleniyor): %d\n\n", ret);

   

    // Test 7: Sayı içeren format (%5s) ve uzun string
    printf("Test 7: 5 karakterlik string girin (örn: naber veya naber123): ");
    ret = my_scanf("%5s", str);
    printf("Okunan string: %s, Dönüş değeri: %d\n\n", str, ret);

    // Test 8: Birden fazla string (%s %s %s) ve karmaşık giriş
    printf("Test 8: Üç string girin (örn: naber test 123 veya naber   test   123): ");
    ret = my_scanf("%s %s %s", str, str2, str3);
    printf("Okunanlar: string1=%s, string2=%s, string3=%s, Dönüş değeri: %d\n\n", str, str2, str3, ret);

    // Test 9: Geçersiz tamsayı girişi (%d) ve birden fazla format
    printf("Test 9: Tamsayı ve string girin (örn: 42 naber veya enes naber): ");
    ret = my_scanf("%d %s", &num, str);
    printf("Okunanlar: tamsayı=%d, string=%s, Dönüş değeri: %d\n\n", num, str, ret);

    // Test 10: Çok uzun string ve buffer taşma testi
    printf("Test 10: Çok uzun string girin (örn: aaaaa... [100+ karakter]): ");
    ret = my_scanf("%s", str);
    printf("Okunan string: %s, Dönüş değeri: %d\n\n", str, ret);

    // Test 11: Boşluklar ve sekmelerle dolu giriş
    printf("Test 11: Boşluklu giriş (örn:    naber   42   x   ): ");
    ret = my_scanf("%s %d %c", str, &num, &ch);
    printf("Okunanlar: string=%s, tamsayı=%d, karakter=%c, Dönüş değeri: %d\n\n", str, num, ch, ret);

    // Test 12: Sadece \r\n veya sekmeler
    printf("Test 12: Sadece boşluk/sekme/enter girin: ");
    ret = my_scanf("%s", str);
    printf("Okunan string: %s, Dönüş değeri: %d\n\n", str, ret);

    // Test 13
    memset(str, 0, sizeof(str));
    printf("Test 13: 15 karakter girin (örn: naber test 123): ");
    ret = my_scanf("%15c", str);
    printf("Okunan string: %s, Dönüş değeri: %d\n\n", str, ret);

    
    return 0;
}
