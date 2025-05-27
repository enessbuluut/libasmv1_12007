section .text
        global _my_strrchr
_my_strrchr:
        PUSH ebp
        MOV ebp,esp
        MOV edi,[ebp+8]; taranacak string base adresi
        MOV esi,[ebp+12]; aranacak karakterin bellekteki base adresi
        ;öncelikle eside bulunan karakterin doğru formatta olup olmadığını test etmeliyiz.
        xor eax,eax
        xor ebx,ebx
        MOV dl,[esi]


        CMP edi,0
        JE .null_string_input
        JNE .strchrr_loop
.null_string_input:
        MOV eax,-2
        MOV esp,ebp
        POP ebp
        RET
.strchrr_loop:
        CMP BYTE [edi],dl
        JE .strchrr_find
        CMP BYTE [edi],0
        JE .strchrr_not_find
        INC edi
        JMP .strchrr_loop
.strchrr_find:
        CMP BYTE [edi],0
        JE .done_input_null
        MOV ebx,edi
        INC edi
        JMP .strchrr_loop
.done_input_null:
        MOV ebx,edi
        JMP .find
.strchrr_not_find:
        CMP ebx,0
        JE .not_find
        JNE .find
.not_find:
        MOV eax,0
        MOV esp,ebp
        POP ebp
        RET
.find:
        MOV eax,ebx
        MOV esp,ebp
        POP ebp
        RET
