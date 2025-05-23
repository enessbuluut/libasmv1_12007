section .text
        global _my_strncpy_s
_my_strncpy_s:
        PUSH ebp
        MOV ebp,esp
        MOV edi,[ebp+8] ;hedef string adres
        MOV esi,[ebp+16] ;kaynak string adres
        MOV ebx,[ebp+12] ;hedef dizi size
        MOV ecx,[ebp+20] ;kopyalanacak karakter sayısı
        xor edx,edx
        CMP ebx,ecx
        JL .wrong_input
.my_strncpy_s_loop:
        CMP ecx,0
        JE .my_strncpy_s_done
        CMP BYTE [esi],0
        JE .my_strncpy_s_check1
        MOV dl,[esi]
        MOV [edi],dl
        INC esi
        INC edi
        DEC ecx
        JMP .my_strncpy_s_loop
.wrong_input:
        MOV eax,-1
        MOV esp,ebp
        POP ebp
        RET
.my_strncpy_s_check1:
        CMP ecx,0
        JE .my_strncpy_s_done
        MOV BYTE [edi],0
        INC edi
        DEC ecx
        JMP .my_strncpy_s_check1
.my_strncpy_s_done:
        xor eax,eax
        MOV esp,ebp
        POP ebp
        RET