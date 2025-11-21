Extrn pro1:FAR, pro2:FAR, pro3:FAR

.model small
.stack
.data  
    m1 db "Estas en el principal$"
.code
    Principal Proc FAR
        mov AX, @data
        mov DS, AX
        ;Limpiar pantalla 
        mov AH, 9
        mov DX , offset m1
        int 21h
        Call pro1
        Call pro2
        Call pro3
        mov AH, 4ch
        int 21h
    Principal ENDP
End Principal