.model small
.stack
.data  
    m1 db "Estas en el procedimiento 1$"
.code
    pro1 Proc FAR
        public pro1
        mov AX, @data
        mov DS, AX
        ;Limpiar pantalla 
        mov AH, 9
        mov DX , offset m1
        int 21h
        RET
    Pro1 ENDP
End Pro1