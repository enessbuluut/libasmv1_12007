section .text
        global _my_strchr
_my_strchr:
        PUSH ebp
        MOV ebp,esp
        MOV edi,[ebp+8];kaynak dizinin base adresi
        MOV esi,[ebp+12]; taranacak karakterin base adresi
        ;esi check yapmamız lazım yani taranacak verimiz tek karakter olacağı için 2 karakter vb. girilince o>        MOV dl,[esi]
        xor eax,eax
        JMP .check_one_chr
.check_one_chr:
        CMP eax,1
        JG .check_not
        CMP BYTE [esi],0
        JE .check_hard
        INC eax
        INC esi
        JMP .check_one_chr
.check_not:
        MOV eax,-1
        MOV esp,ebp
        POP ebp
        RET
.check_hard:
        CMP eax,0
        JE .my_strchr_loop
        CMP eax,1
        JE .my_strchr_loop
        JNE .check_not
.my_strchr_loop:
        CMP BYTE [edi],dl
        JE .chr_find
        CMP BYTE [edi],0
        JE .chr_not_find
        INC edi
        JMP .my_strchr_loop
.chr_find:
        MOV eax,edi
        MOV esp,ebp
        POP ebp
        RET
.chr_not_find:
        MOV eax,-2
        MOV esp,ebp
        POP ebp
	RET