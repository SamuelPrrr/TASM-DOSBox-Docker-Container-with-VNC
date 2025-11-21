.model small
.stack
.data  
    m1 db "Estas en el procedimiento 3$"
.code
    pro3 Proc FAR
        public pro3
        mov AX, @data
        mov DS, AX
        ;Limpiar pantalla 
        mov AH, 9
        mov DX , offset m1
        int 21h
        RET
    Pro3 ENDP
End Pro3
