.MODEL SMALL
.STACK 100h
.DATA
    mensaje1 DB 'Introduce una cadena: $'
    mensaje2 DB 0Ah,0Dh,'La palabra es un palindromo$'
    mensaje3 DB 0Ah,0Dh,'La palabra NO es un palindromo$'
    mensaje4 DB 0Ah,0Dh,'Numero de vocales: $'
    buffer DB 50 DUP('$')   
    vocales DB 0
    longitud DB 0
.CODE

Principal PROC FAR
    MOV AX, @DATA
    MOV DS, AX

; mensaje para pedir el texto
    LEA DX, mensaje1
    MOV AH, 9
    INT 21h

; leer cadena
    LEA DX, buffer
    MOV AH, 0Ah
    INT 21h

; obtener longitud de la cadena
    MOV AL, [buffer+1]
    MOV longitud, AL

; caracteres a la pila
    MOV CL, AL
    MOV SI, OFFSET buffer+2
PUSH_LOOP:
    CMP CL, 0
    JE FIN_PUSH
    MOV AL, [SI]
    PUSH AX
    INC SI
    DEC CL
    JMP PUSH_LOOP

FIN_PUSH:

; contar vocales
    MOV CL, longitud
    MOV SI, OFFSET buffer+2
    MOV BL, 0               ; BL = contador de vocales
VOWEL_LOOP:
    CMP CL, 0
    JE FIN_VOWEL
    MOV AL, [SI]
    CMP AL, 'A'
    JE ES_VOCAL
    CMP AL, 'E'
    JE ES_VOCAL
    CMP AL, 'I'
    JE ES_VOCAL
    CMP AL, 'O'
    JE ES_VOCAL
    CMP AL, 'U'
    JE ES_VOCAL
    CMP AL, 'a'
    JE ES_VOCAL
    CMP AL, 'e'
    JE ES_VOCAL
    CMP AL, 'i'
    JE ES_VOCAL
    CMP AL, 'o'
    JE ES_VOCAL
    CMP AL, 'u'
    JE ES_VOCAL
    JMP NO_VOCAL
ES_VOCAL:
    INC BL
NO_VOCAL:
    INC SI
    DEC CL
    JMP VOWEL_LOOP

FIN_VOWEL:
    MOV vocales, BL

; verificar si es palindromo
    MOV CL, longitud
    MOV CH, 0
    MOV SI, OFFSET buffer+2
    MOV DI, OFFSET buffer+2
    ADD DI, CX
    DEC DI
    MOV AL, 1      ; AL=1 significa "es palindromo"

PAL_LOOP:
    CMP SI, DI
    JGE FIN_PAL
    MOV BL, [SI]
    MOV BH, [DI]
    CMP BL, BH
    JNE NO_PAL
    INC SI
    DEC DI
    JMP PAL_LOOP

NO_PAL:
    MOV AL, 0
FIN_PAL:

; imprimir resultado del palindromo
    CMP AL, 1
    JE ES_PAL
    LEA DX, mensaje3
    JMP MUESTRA_RES
ES_PAL:
    LEA DX, mensaje2
MUESTRA_RES:
    MOV AH, 9
    INT 21h

; imprimir número de vocales
    LEA DX, mensaje4
    MOV AH, 9
    INT 21h
    MOV AL, vocales
    CALL IMPRIMIR_NUM

; salir del programa
    MOV AH, 4Ch
    INT 21h
Principal ENDP

IMPRIMIR_NUM PROC
    ADD AL, 30h
    MOV DL, AL
    MOV AH, 2
    INT 21h
    RET
IMPRIMIR_NUM ENDP

END Principal
