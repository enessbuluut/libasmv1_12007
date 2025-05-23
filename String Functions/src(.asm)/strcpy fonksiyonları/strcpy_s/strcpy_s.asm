section .text
        global _my_strcpy_s
_my_strcpy_s:
        PUSH ebp
        MOV ebp,esp
        xor edx,edx
        MOV esi,[ebp+8] ;hedef dizinin başlangıç adresi
        MOV eax,[ebp+12] ;hedef dizinin boyutu
        MOV edi,[ebp+16] ; kaynak stringin başlangıç adresi
.mystrcpy_s_loop:
        CMP eax,0 ; eğer hedef dizimiz tamamlandıysa kontrol sağlamamız gerekir kaynak string tamamlandı mı diye        JE .mystrcpy_s_check1

        MOV dl,[edi]
        CMP dl,0 ; eğer kaynak dizisi tamamlandıysa yine kontrol gerekir hedef bitti mi eğer hedef bitmediyse \>        JE .mystrcpy_s_check2
        MOV [esi],dl
        INC esi
        INC edi
        DEC eax
        JMP .mystrcpy_s_loop
.mystrcpy_s_check1:
        CMP dl,0
        JE .done_all
        JNE .error_size
.mystrcpy_s_check2:
        CMP eax,0
        JE .done_all
        JNE .fill_null_left
.fill_null_left:
        CMP eax,0
        JE .done_all
        MOV BYTE [esi],0
        DEC eax
        JMP .fill_null_left
.error_size:
        MOV esi,[ebp+8]
        MOV eax,[ebp+12]
        JMP .fill_null_all
.fill_null_all:
        CMP eax,0
        JE .done_all_with_err1
        MOV BYTE [esi],0
        DEC eax
        JMP .fill_null_all
.done_all_with_err1:
        MOV eax,-1; ben hata kodunu -1 olarak tanımladım, bu hata kodu kaynak size durumunda olacak
;hedef size durumunda olaca>;lakin bu hata kodu gönderilmeden zaten atanan önceki verileri biz temizledik bu sayede veri açığına izin vermedik
        MOV esp,ebp
        POP ebp
        RET
.done_all:
        MOV eax,1
        MOV esp,ebp
        POP ebp
        RET