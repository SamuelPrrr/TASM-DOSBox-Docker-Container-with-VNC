.model small
.stack
.data  
    m1 db "Estas en el procedimiento 2$"
.code
    pro2 Proc FAR
        public pro2
        mov AX, @data
        mov DS, AX
        ;Limpiar pantalla 
        mov AH, 9
        mov DX , offset m1
        int 21h
        RET
    Pro2 ENDP
End Pro2
