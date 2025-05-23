section .text
        global _my_strcat_s
_my_strcat_s:
        PUSH ebp
        MOV ebp,esp
        MOV edx,[ebp+8];hedef dizinin base adresi
        MOV ebx,[ebp+12];hedef dizinin boyutu
        MOV ecx,[ebp+16];kaynak dizinin base adresi
;kullanıcı tarafından uzunluğu alabildiğimiz için burada güvenlik anlamında yapabileceğimiz temel bir iki baş>;Bizler ebx değerinde hedefin alabileceği max karakteri biliyoruz.
;Olması gereken kontrolümüz şu şekilde olacaktır ilk başta bu dizinin içinde kaç karakter var
;Sonrasında buna kaç karakter eklenmeye çalışılıyor (yani kaynağın uzunluğu)
;Sonrasında da yapacağımız işlem ebx değerini aşıp aşmadığı kontrolü çünkü aşarsa istenmeyen sonuçlar doğabil>        CMP ecx,edx
        JE .equal_adress
        ;hedef dizi null ise başlangıç kontrolü
        CMP edx,0
        JE .null_input

        ;Değilse hedef dizideki eleman uzunluğunu alıyoruz.
        xor eax,eax
        MOV edi,edx
        CALL .strlen
        MOV edi,eax

        ;kaynak dizisinde hiç veri yoksa kontrol
        CMP ecx,0
        JE .wrong_input
        ;eğer varsa kaynak dizisindeki eleman uzunluğunu alıyoruz.
        MOV esi,edi
        xor eax,eax
        MOV edi,ecx
        CALL .strlen
        MOV edi,esi
        ADD eax,edi
                ;ecx yani kaynak null ise yine hedef bölgeyi sıfırlayacağız.

                 ; artık hedef dizi ve kaynak dizinin içeriklerinin uzunluğunu öğrenmiş olduk
;ve bu öğrendiğimiz değer şu anda eax içerisinde lakin \0 değeri yok.

        INC eax
        CMP eax,ebx
        JA .wrong_input
        JBE  .my_strcat_loop_ready
.strlen:
        CMP BYTE [edi],0
        JE .strlen_done
        INC edi
        INC eax
        JMP .strlen
.strlen_done:
        RET
.wrong_input:
        JMP .wrong_loop
.wrong_loop:
        CMP edi,0
        JE .wrong_done
        CMP BYTE [edx],0
        JE .wrong_done
        MOV BYTE [edx],0
        DEC edi
        INC edx
        JMP .wrong_loop
.wrong_done:
        MOV esp,ebp
        POP ebp
        MOV eax,-1
        RET
.my_strcat_loop_ready:
        xor eax,eax
        MOV eax,edx
        ADD eax,edi
        ;başlangıç adresimizi koruduk lakin eax içerisinde atama yapacağımız nokta ve sonrasındaki adresler b>        JMP .my_strcat_loop
        MOV ecx,[ebp+16]
.my_strcat_loop:
        CMP BYTE [ecx],0
        JE .my_strcat_done
        MOV bl,[ecx]
        MOV BYTE [eax],bl
        INC eax
        INC ecx
        JMP .my_strcat_loop
.my_strcat_done:
        MOV BYTE [eax],0
        MOV esp,ebp
        POP ebp
        MOV eax,0
        RET
.null_input:
        MOV eax,-1
        MOV esp,ebp
        POP ebp
        RET
.equal_adress:
        MOV eax,-1
        MOV esp,ebp
        POP ebp
        RET