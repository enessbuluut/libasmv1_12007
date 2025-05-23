section .text
        global _my_strstr
_my_strstr:
        PUSH ebp
        MOV ebp,esp
        MOV esi,[ebp+8] ;aramanın yapılacağı stringin base adresi
        MOV edi,[ebp+12] ; arama yapılacak stringin base adresi
        JMP .haystack_input_ready ; bu yapımızın amacı arama yapılacak string boş mu değil mi kontrolü
        ;needle haystack isimlendirmesinin sebebi needle iğne haystack samanlık
        ;yaptığımız şey de bir nevi samanlıkta iğne aramak :)

;İlk olarak iğnemiz yani arayacağımız yapının null olmaması gerektiğini kontrol ediyoruz.
.haystack_input_ready:
        xor ebx,ebx
        MOV ecx,esi
.haystack_input_check:
        CMP BYTE [ecx],0
        JE .null_haystack_find
        JNE .strstr_ready
.null_haystack_find:
        CMP BYTE [edi],0
        JNE .wrong_input
        JE .null_input
.wrong_input:
        MOV eax,-2
        MOV esp,ebp
        POP ebp
        RET
.null_input:
        MOV eax,esi
        MOV esp,ebp
        POP ebp
        RET
.strstr_ready:
        MOV dl,[edi]
.strstr_loop:
        CMP BYTE [esi],0
        JE .null_check
        CMP BYTE [esi],dl
        JE .find_check_ready
        INC esi
        JMP .strstr_loop
.null_check:
        CMP BYTE [edi],0
        JE .check_done
        JNE .not_found
.find_check_ready:
        MOV ecx,esi
        MOV ebx,edi
.find_check_loop:
        INC ecx
        INC ebx
        CMP BYTE [ecx],0
        JE .check_level1
        CMP BYTE [ebx],0
        JE .check_done
        MOV dl,[ebx]
        CMP BYTE [ecx],dl
        JE .find_check_loop
        JNE .strstr_ready
.check_level1:
        CMP BYTE [ebx],0
        JE .check_done
        JNE .not_found
.check_done:
        MOV eax,esi
        MOV esp,ebp
        POP ebp
        RET
.not_found:
        MOV eax,-1
        MOV esp,ebp
        POP ebp
        RET