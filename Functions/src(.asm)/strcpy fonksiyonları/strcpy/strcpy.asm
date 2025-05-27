section .text
        global _my_strcpy
_my_strcpy:
        PUSH ebp
        MOV ebp,esp
        xor eax,eax
        MOV edi,[ebp+8]
        MOV esi,[ebp+12]
.my_strcpy_loop:
        MOV al,[esi]
        CMP al,0
        JE .my_strcpy_done

        MOV [edi],al
        INC esi
        INC edi
        JMP .my_strcpy_loop
.my_strcpy_done:
        MOV BYTE [edi],0
        MOV eax,[ebp+8]
        MOV esp,ebp
        POP ebp
        RET