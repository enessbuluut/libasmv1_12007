section .bss
        global _buffer_input
        _buffer_input resb 1024

        global _bytesRead
        _bytesRead resd 1

        global _buffer_function
        _buffer_function resb 1024

        global _buffer_function_sayac
        _buffer_function_sayac resd 1

        global _buffer_input_sayac
        _buffer_input_sayac resd 1

	global _address_sayac
	_address_sayac resd 1

	global _sayac_adet
	_sayac_adet resd 1
	global _negative_number_check
	_negative_number_check resb 1
section .text
        global _my_scanf
        extern _GetStdHandle@4
        extern _ReadConsoleA@20
_my_scanf:
        PUSH ebp ;çağrılmadan önce ebp değeri bizim için önemli olduğu için böyle yapıyoruz.
        MOV ebp,esp
        SUB esp,8

        MOV eax,[ebp+8]
        CMP BYTE [eax],0
        JE .null_input

        ;GetStdHandle(STD_INPUT_HANDLE)
        PUSH dword -10          ; -10 = STD_INPUT_HANDLE, standart giriş cihazını belirtir
        CALL _GetStdHandle@4    ; Windows API çağrısı, konsol standart girişine ait HANDLE döner
        MOV [ebp-4],eax
        CMP eax,-1            ; stack temizlenir (çağrıdan sonra argüman kaldırılır)
        JE .error_exit             ; dönen HANDLE, yani konsolun giriş erişim tanımlayıcısı ebx'e kaydedilir


        PUSH dword 0 ;NULL için
        lea eax,[_bytesRead] ;&bytesRead
        PUSH eax
        PUSH dword 1023
        lea eax,[_buffer_input]; &buffer_input
        PUSH eax
        PUSH DWORD [ebp-4]
        CALL _ReadConsoleA@20
        ADD esp,20

        CMP eax,0
        JE .error_exit

        MOV eax,[_bytesRead]
        CMP eax,3
        JL .null_terminate

        DEC eax
        MOV BYTE[_buffer_input+eax],0
        DEC eax
        MOV BYTE[_buffer_input+eax],0

        ;Örnek verelim ilk başta enes girdisi girildiğinde
        ; e n e s \r \n olarak 6 sayardı şimdiyse e n e s \0 \0 var bu durumda 3 yapmamız gerekir.
        ; her zaman 3 azaltmalıyız bu durumda 2 tanesini azaltarak bufferı düzelttik 1 azaltarak indeksi
        ;çünkü max erişimimiz e n e s olacak 4.sü olmamalı
        ;artık _buffer_input tamamen verilerimiz ile dolu.

        xor eax,eax

        MOV [_buffer_input_sayac],eax  ;başlangıçta sayaçları sıfırlıyoruz.
        MOV [_buffer_function_sayac],eax ;başlangıçta sayaçları sıfırlıyoruz.

        MOV esi,[ebp+8] ; %s %d gibi verilerin olduğu stringin base adresini aldık.

	MOV eax,12
	MOV [_address_sayac],eax

        JMP .format_buffer_ready
.null_input:
        MOV eax,-1
        MOV esp,ebp
        POP ebp
        RET
.error_exit:
        MOV eax,-1
        MOV esp,ebp
        POP ebp
        RET
.null_terminate:
	MOV edi,[ebp+12]
	MOV BYTE [edi],0
        MOV eax,0
	MOV esp,ebp
	POP ebp
	RET



.format_buffer_ready:
        xor eax,eax
        JMP .format_buffer_loop

.format_buffer_loop:
        MOV dl,[esi]
        CMP dl,0
        JE .format_buffer_done
        CMP dl,32
        JE .format_buffer_atla
        CMP dl,9
        JE .format_buffer_atla
        MOV [_buffer_function+eax],dl
        INC eax
        INC esi
        JMP .format_buffer_loop
.format_buffer_atla:
        INC esi
        JMP .format_buffer_loop
.format_buffer_done:
        MOV BYTE [_buffer_function+eax],0
        JMP .my_scanf_loop_ready

;formatımızı yani kullanıcının "%s gibi  tırnak içerisinde girdiği verilerdeki boşluklardan kaldırıp
;_buffer_function ismini verdiğimiz yapımız içine koymuş olduk. şimdi devam ediyoruz.
        ;artık her yapı için önemli olarak kullanacağımız dinamik yapımıza geçebiliriz.

        ;şimdi metnimiz üzerinde gezeceğimiz bilgisi önemli
        ;bize 2 farklı buffer kontrolü lazım çünkü:
        ;1.si format_buffer'ımız yani _buffer_function üzerinde gezeceğiz .
        ;2.si kullanıcımızın girdiği veriyi aldığımız _buffer_input üzerinde döneceğiz.
        ;bize 2 farklı sayaç lazım 1.si

        ;bunları _buffer_input_sayac ve _buffer_function_sayac olarak isimlendirdim bu veriler önemli!!


        ;.my_scanf_loop_ready dediğimiz zaman ilk başta yapılacak türü öğrenmemiz lazım %s %d %c ne yapacağız?
.my_scanf_loop_ready:
        MOV eax,[_buffer_function_sayac] ;ne kadar ilerlediğimiz üzerine belki 2 veri var %s %d ondan sayaç
.my_format_loop:
        CMP BYTE [_buffer_function+eax],0
        JE .my_scanf_done
        CMP BYTE [_buffer_function+eax],37
        JE .check_format_ready
        JMP .wrong_function_string


.check_format_ready:
        INC eax
.check_format_loop:

        CMP BYTE [_buffer_function+eax],'s'
        JE .string_input
        CMP BYTE [_buffer_function+eax],'c'
        JE .char_input
        CMP BYTE [_buffer_function+eax],'d'
        JE .decimal_input
        CMP BYTE [_buffer_function+eax],'0'
	JL .wrong_function_string
        CMP BYTE [_buffer_function+eax],'9'
        JG .wrong_function_string

	JMP .sayacli_loop_ready
.sayacli_loop_ready:
	MOV ebx,eax
	xor eax,eax
.sayacli_loop:
	xor edx,edx
	MOV dl,[_buffer_function+ebx]
	CMP dl,'0'
	JL .sayacli_loop_done
	CMP dl,'9'
	JG .sayacli_loop_done
	SUB dl,'0'
	IMUL eax,eax,10
	ADD eax,edx
	INC ebx
	JMP .sayacli_loop
.sayacli_loop_done:
	DEC eax
	MOV [_sayac_adet],eax ;artık kaç adet olduğumuz [_sayac_adet] içinde saklı
	MOV eax,ebx
	CMP BYTE [_buffer_function+eax],'c'
	JE .char_input_limit
	CMP BYTE [_buffer_function+eax],'d'
	JE .decimal_input_limit
	CMP BYTE [_buffer_function+eax],'s'
	JE .string_input_limit

	JMP .wrong_function_string
.wrong_function_string:
        MOV eax,-1
        MOV esp,ebp
        POP ebp
        RET
.my_scanf_done:
    MOV eax,[_address_sayac]  ; _address_sayac değerini al
    SUB eax,12                ; Başlangıç değeri olan 12'yi çıkar
    MOV ebx,4                 ; Her argüman 4 bayt
    XOR edx,edx               ; edx'i sıfırla (DIV için gerekli)
    DIV ebx                   ; eax = (eax - 12) / 4
    CMP eax,0                 ; Okunan argüman sayısı 0 mı?
    JNE .return_count         ; Değilse, hesaplanan sayıyı döndür
    MOV eax,0                 ; 0 argüman okunduysa, 0 döndür
    JMP .exit
.return_count:
    ; eax zaten okunan argüman sayısını içeriyor
.exit:
    MOV esp,ebp
    POP ebp
    RET
;buraya geldiğimize göre artık %s %d %c gibi bir yapı elde etmiş olmamız gerekir yoksa zaten yapı bozuktur.
;Bozuk yapıya uygun hatalarımızı gönderdik
        ;% yoksa başlangıçta farklı bir karakter varsa direkt hata
        ;0 varsa zaten scanf tamamen bitmiş demektir.
        ;% sonrası c ,d ,s ya da sayı yoksa o da tamamen hatalıdır demektir.

        ;şu anda %c %d %s durumunu inceliyoruz.
        ;ilk başta metnimizde neredeyiz onu bilmemiz gerekiyor. yani metin sayacımız burada devreye girecek.
        ;_buffer_input_sayac xD
.string_input:

	INC eax
	MOV [_buffer_function_sayac],eax

        MOV eax,[_buffer_input_sayac]

	MOV edx,[_address_sayac]
        MOV ecx,[ebp+edx]
	ADD edx,4
	MOV[_address_sayac],edx
	xor edx,edx
.string_input_ready:
	CMP DWORD [_bytesRead],eax
	JBE .wrong_input
	CMP BYTE [_buffer_input+eax],32
	JE .string_input_arttir
	CMP BYTE [_buffer_input+eax],9
	JE .string_input_arttir
	JMP .string_input_loop
.string_input_arttir:
	INC eax
	JMP .string_input_ready

.string_input_loop:
        CMP DWORD [_bytesRead],eax
        JBE .string_input_done
        CMP BYTE [_buffer_input+eax],0
        JE .string_input_done
        CMP BYTE [_buffer_input+eax],32
        JE .string_input_done
        CMP BYTE [_buffer_input+eax],9
        JE .string_input_done
        MOV dl,[_buffer_input+eax]
        MOV [ecx],dl
        INC ecx
        INC eax
        JMP .string_input_loop
.string_input_done:
        MOV BYTE [ecx],0
	INC eax
        MOV DWORD [_buffer_input_sayac],eax
	JMP .my_scanf_loop_ready


.char_input:

	INC eax
	MOV [_buffer_function_sayac],eax

        MOV eax,[_buffer_input_sayac]

	MOV edx,[_address_sayac]
	MOV ecx,[ebp+edx]
	ADD edx,4
	MOV [_address_sayac],edx
	xor edx,edx

        CMP DWORD [_bytesRead],eax
        JBE .my_scanf_done
        MOV dl,[_buffer_input+eax]
        MOV [ecx],dl
        INC ecx
        INC eax
.char_input_done:
        MOV [_buffer_input_sayac],eax
	JMP .my_scanf_loop_ready



.decimal_input:

	INC eax
        MOV [_buffer_function_sayac],eax

        MOV ebx,[_buffer_input_sayac]

	MOV eax,[_address_sayac]
        MOV ecx,[ebp+eax]
	ADD eax,4
	MOV [_address_sayac],eax
        xor eax,eax
.decimal_input_ready:
	CMP DWORD [_bytesRead],ebx
	JBE .wrong_input
	CMP BYTE [_buffer_input+ebx],32
	JE .decimal_input_arttir
	CMP BYTE [_buffer_input+ebx],9
	JE .decimal_input_arttir
	CMP BYTE [_buffer_input+ebx],'-'
	JE .negative_decimal_input
	JMP .decimal_input_loop
.decimal_input_arttir:
	INC ebx
	JMP .decimal_input_ready
.negative_decimal_input:
	MOV BYTE [_negative_number_check],'-'
	INC ebx
	JMP .decimal_input_loop
.decimal_input_loop:
        xor edx,edx
        CMP DWORD [_bytesRead],ebx
        JBE .my_scanf_done
        CMP BYTE [_buffer_input+ebx],'0'
        JL .decimal_input_done
        CMP BYTE [_buffer_input+ebx],'9'
        JG .decimal_input_done
        MOV dl,[_buffer_input+ebx]
        SUB dl,'0'
        IMUL eax,eax,10
        ADD eax,edx
        INC ebx
        JMP .decimal_input_loop
.decimal_input_done:
	CMP BYTE [_negative_number_check],'-'
	JE .negative_decimal_input_done
        MOV [ecx],eax
        MOV [_buffer_input_sayac],ebx
        JMP .my_scanf_loop_ready
.negative_decimal_input_done:
	NEG eax
	MOV [ecx],eax
	MOV [_buffer_input_sayac],ebx
	MOV BYTE [_negative_number_check],'+'
	JMP .my_scanf_loop_ready
.wrong_input:
	MOV eax,-1
	MOV esp,ebp
	POP ebp
	RET

;aşağıdaki yapılarımız limitli olarak tanımlanan %15s %20c %15d gibi yapılardır.


.decimal_input_limit:
	INC eax
        MOV [_buffer_function_sayac],eax

        MOV ebx,[_buffer_input_sayac]

        MOV eax,[_address_sayac]
        MOV ecx,[ebp+eax]
        ADD eax,4
        MOV [_address_sayac],eax
        xor eax,eax
	xor esi,esi
.decimal_input_limit_ready:
        CMP DWORD [_bytesRead],ebx
        JE .wrong_input
        CMP BYTE [_buffer_input+ebx],32
        JE .decimal_input_limit_arttir
        CMP BYTE [_buffer_input+ebx],9
        JE .decimal_input_limit_arttir
	CMP BYTE [_buffer_input+ebx],'-'
	JE .negative_input_limit
	MOV edi,[_sayac_adet]
	xor esi,esi
        JMP .decimal_input_limit_loop
.decimal_input_limit_arttir:
        INC ebx
        JMP .decimal_input_limit_ready
.negative_input_limit:
	MOV BYTE [_negative_number_check],'-'
        INC ebx
        JMP .decimal_input_limit_loop
.decimal_input_limit_loop:
	CMP esi,edi
	JG .decimal_input_limit_done
        xor edx,edx
        CMP DWORD [_bytesRead],ebx
        JBE .my_scanf_done
        CMP BYTE [_buffer_input+ebx],'0'
        JL .decimal_input_limit_done
        CMP BYTE [_buffer_input+ebx],'9'
        JG .decimal_input_limit_done
        MOV dl,[_buffer_input+ebx]
        SUB dl,'0'
        IMUL eax,eax,10
        ADD eax,edx
        INC ebx
	INC esi
        JMP .decimal_input_limit_loop
.decimal_input_limit_done:
	CMP BYTE [_negative_number_check],'-'
	JE .negative_decimal_input_limit_done
        MOV [ecx],eax
        MOV [_buffer_input_sayac],ebx
        JMP .my_scanf_loop_ready
.negative_decimal_input_limit_done:
	NEG eax
	MOV BYTE[_negative_number_check],'+'
	MOV [ecx],eax
	MOV [_buffer_input_sayac],ebx
	JMP .my_scanf_loop_ready




.string_input_limit:

        INC eax
        MOV [_buffer_function_sayac],eax

        MOV eax,[_buffer_input_sayac]

        MOV edx,[_address_sayac]
        MOV ecx,[ebp+edx]
        ADD edx,4
        MOV[_address_sayac],edx
        xor edx,edx
	xor esi,esi
.string_input_limit_ready:
	CMP DWORD [_bytesRead],eax
	JE .wrong_input
        CMP BYTE [_buffer_input+eax],32
        JE .string_input_limit_arttir
        CMP BYTE [_buffer_input+eax],9
        JE .string_input_limit_arttir
	MOV ebx,[_sayac_adet]
	xor esi,esi
        JMP .string_input_limit_loop
.string_input_limit_arttir:
        INC eax
        JMP .string_input_limit_ready
.string_input_limit_loop:
	CMP esi,ebx
	JG .string_input_limit_done
        CMP DWORD [_bytesRead],eax
        JBE .string_input_limit_done
        CMP BYTE [_buffer_input+eax],0
        JE .string_input_limit_done
        CMP BYTE [_buffer_input+eax],32
        JE .string_input_limit_done
        CMP BYTE [_buffer_input+eax],9
        JE .string_input_limit_done
        MOV dl,[_buffer_input+eax]
        MOV [ecx],dl
        INC ecx
        INC eax
	INC esi
        JMP .string_input_limit_loop
.string_input_limit_done:
        MOV BYTE [ecx],0
        INC eax
        MOV DWORD [_buffer_input_sayac],eax
        JMP .my_scanf_loop_ready
.char_input_limit:
	INC eax
	MOV [_buffer_function_sayac],eax

        MOV eax,[_buffer_input_sayac]

        MOV edx,[_address_sayac]
        MOV ecx,[ebp+edx]
        ADD edx,4
        MOV [_address_sayac],edx
	MOV ebx,[_address_sayac]
	DEC ebx
        xor edx,edx
	xor esi,esi
.char_input_limit_loop:
        CMP esi,ebx
        JGE .char_input_limit_done
        CMP DWORD [_bytesRead],eax
        JBE .my_scanf_done
        MOV dl,[_buffer_input+eax]
        MOV [ecx],dl
        INC ecx
        INC eax
        INC esi
	JMP .char_input_limit_loop
.char_input_limit_done:
        MOV [_buffer_input_sayac],eax
        JMP .my_scanf_loop_ready


