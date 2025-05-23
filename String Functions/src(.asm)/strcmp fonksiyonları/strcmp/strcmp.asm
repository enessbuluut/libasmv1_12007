section .text
        global _my_strcmp
_my_strcmp:
        PUSH ebp
        MOV ebp,esp
        xor eax,eax
        xor ebx,ebx
        MOV edi,[ebp+8]
        MOV esi,[ebp+12]
.strcmp_loop:
        MOV al,[edi]
        MOV bl,[esi]

        CMP al,bl
        JNE .not_equal

        CMP al,0
        JE .check_equality
        CMP bl,0
        JE .check_equality

        INC edi
        INC esi


        JMP .strcmp_loop
.check_equality:
        CMP al,0
        JNE .not_equal

        CMP bl,0
        JNE .not_equal

        JMP .equal
.not_equal:
        CMP al,bl
        JG .greater
        JL .lower
.equal:
        MOV esp,ebp
        POP ebp
        MOV eax,0
        RET
.greater:
        MOV esp,ebp
        POP ebp
        MOV eax,1
        RET
.lower:
        MOV esp,ebp
        POP ebp
        MOV eax,-1
        RET