section .text
        global _my_strncpy
_my_strncpy:
        PUSH ebp
        MOV ebp,esp
        xor edx,edx
        MOV edi,[ebp+8]
        MOV esi,[ebp+12]
        MOV ecx,[ebp+16]
.my_strncpy_loop:
        CMP ecx,0
        JE .my_strncpy_done
        CMP BYTE [esi],0
        JE .fill_null_left
        MOV dl,[esi]
        MOV [edi],dl
        INC esi
        INC edi
        DEC ecx
        JMP .my_strncpy_loop
.fill_null_left:
        CMP ecx,0
        JE .my_strncpy_done
        MOV [edi],0
        DEC ecx
        JMP .fill_null_left
.my_strncpy_done:
        MOV esp,ebp
        POP ebp
        RET