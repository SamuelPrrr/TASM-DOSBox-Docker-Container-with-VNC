.model small
.stack
.data
    numero db 37
    base db 2
    resta db 1
.code
Principal Proc Far
    mov AX, @data
    mov DS, AX ;Limpiar pantalla

    MOV AH, "$" ;Movemos el caracter $ al registro Alto de AX
    PUSH AX
    MOV AX, 0
    MOV AL, numero 
    MOV Si,0
    ciclo1:
        DIV base ;El residuo de la división se guarda en AH (AX por que acepta 2 bytes) y en AL el resultado
        CMP AL, 0
        JE salir
        PUSH AX
        INC Si
        MOV AH, 0 ;Limpiar acumulador del residuo para que no afecte a la división
    JMP ciclo1

    salir:
    PUSH AX

    addCeros:
    CMP Si, 7
    JE imprimir
    MOV AH, 0
    PUSH AX
    INC Si
    JMP addCeros

    imprimir:
    POP DX
    CMP DH, "$"
    JE fin
    MOV DL, DH ;Cambiamos , por que en DH es donde tenemos el valor de binario
    ADD DL, 30h ; Suma para convertirlo en un caracter ascii valido
    MOV AH, 2
    INT 21h
    JMP imprimir

    fin:
    mov AH, 4ch
    int 21h

;30h sumarselo


    
Principal ENDP
END Principal

