section .text
        global _my_strcat
_my_strcat:
        PUSH ebp
        MOV ebp,esp

        MOV eax,[ebp+8];hedef dizinin adresi
        MOV ebx,[ebp+12];kaynak dizinin adresi
        ;öncelikle hedef dizinin ne kadar uzun olduğunu bulmamız gerekir.
        JMP .len_hedef
.len_hedef:
        CMP BYTE [eax],0
        JE .my_strcat_loop
        INC eax
        JMP .len_hedef
.my_strcat_loop:
        CMP [ebx],0
        JE .my_strcat_done
        MOV cl,[ebx]
        MOV BYTE [eax],cl
        INC eax
        INC ebx
        JMP .my_strcat_loop
.my_strcat_done:
        MOV BYTE [eax],0
        MOV eax,[ebp+8]
        MOV esp,ebp
        POP ebp
        RET