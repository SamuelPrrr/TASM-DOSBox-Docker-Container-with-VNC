.model small
.stack
.data
    nombre db "Samuel Palomares Rios$"

.code
Principal Proc Far
    mov AX, @data
    mov DS, AX ;Limpiar pantalla

    MOV AL, "$"
    PUSH AX

    MOV Si, 0
    ciclo1:
    MOV Al, nombre[Si]
    CMP AL, "$"
    JE salir
    PUSH AX
    INC Si
    JMP ciclo1  

    salir:
    POP DX
    CMP DL, "$"
    JE fin
    MOV AH, 2 ;Exhibir caracter en DL 
    int 21h
    JMP salir

    fin:
    mov AH, 4ch
    int 21h
    
Principal ENDP
END Principal

