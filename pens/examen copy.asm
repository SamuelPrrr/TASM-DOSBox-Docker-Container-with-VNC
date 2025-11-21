.MODEL SMALL
.STACK 100h
.DATA
    mensaje1 DB 'Introduce una cadena: $'
    mensaje2 DB 0Ah,0Dh,'La palabra es un palindromo$'
    mensaje3 DB 0Ah,0Dh,'La palabra NO es un palindromo$'
    mensaje4 DB 0Ah,0Dh,'Numero de vocales: $'
    mensaje5 DB 0Ah,0Dh,'Numero de caracteres: $'
    buffer DB 50 DUP('$')   
    vocales DB 0
    longitud DB 0
.CODE

Principal PROC FAR
    MOV AX, @DATA
    MOV DS, AX

;mensaje
    LEA DX, mensaje1
    MOV AH, 9
    INT 21h

;
    LEA DX, buffer
    MOV AH, 0Ah
    INT 21h

; En el formato del servicio 0Ah, en DX debe haber un bloque con:
; [0] = tamaño máximo
; [1] = número de caracteres leídos
; [2...] = datos

    MOV AL, [buffer+1]      ; longitud real
    MOV longitud, AL

;Caracteres a pila
    MOV CL, AL              ; contador = longitud
    MOV SI, OFFSET buffer+2 ; primer caracter
PUSH_LOOP:
    CMP CL, 0
    JE FIN_PUSH
    MOV AL, [SI]
    PUSH AX
    INC SI
    DEC CL
    JMP PUSH_LOOP

FIN_PUSH:

;--- Contar vocales ---
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

;--- Verificar si es palíndromo ---
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

;--- Mostrar resultado ---
    CMP AL, 1
    JE ES_PAL
    LEA DX, mensaje3
    JMP MUESTRA_RES
ES_PAL:
    LEA DX, mensaje2
MUESTRA_RES:
    MOV AH, 9
    INT 21h

;--- Mostrar número de vocales ---
    LEA DX, mensaje4
    MOV AH, 9
    INT 21h
    MOV AL, vocales
    CALL IMPRIMIR_NUM

;--- Mostrar número de caracteres ---
    LEA DX, mensaje5
    MOV AH, 9
    INT 21h
    MOV AL, longitud
    CALL IMPRIMIR_NUM

;--- Salir ---
    MOV AH, 4Ch
    INT 21h
Principal ENDP

;==============================
; Rutina para imprimir número (en AL)
;==============================
IMPRIMIR_NUM PROC
    ADD AL, 30h
    MOV DL, AL
    MOV AH, 2
    INT 21h
    RET
IMPRIMIR_NUM ENDP

END Principal
