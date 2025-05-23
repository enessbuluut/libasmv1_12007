section .text
        global my_strlen
my_strlen:
        PUSH ebp
        MOV ebp,esp
        xor eax,eax
        MOV ecx,[ebp+8]
my_strlen_loop:
        CMP BYTE [ecx],0
        JE my_strlen_done
        INC eax
        INC ecx
        JMP my_strlen_loop
my_strlen_done:
        MOV esp,ebp
        POP ebp
        RET