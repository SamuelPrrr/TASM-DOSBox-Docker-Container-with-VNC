;   Unidad 3 - Modularidad
;   Demostración del uso de macros en ensamblador

.model small
.stack
.data

; ----- Textos que se mostrarán -----
msg1 db "Hola$",0
msg2 db "Samuel$",0
msg3 db "Bienvenido al uso de macros$",0

; ----- Variables de control -----
contador db 0

.code

;   DEFINICIÓN DE MACROS

; Limpia el contenido de la pantalla
BorrarPantalla Macro
    mov AH, 0
    mov AL, 3
    int 10h
ENDM

; Muestra un texto en pantalla
MostrarTexto Macro texto
    mov AH, 9
    mov DX, offset texto
    int 21h
ENDM

; Coloca el cursor en la posición (x, y) deseada
MoverCursor Macro x, y
    mov AH, 2
    mov DH, y
    mov DL, x
    int 10h
ENDM

; Dibuja líneas horizontales en los bordes superior e inferior
DibujarBordes Macro
Local Ciclo, Pintar, FinCiclo
    mov contador, 1
Ciclo:
    cmp contador, 79
    ja FinCiclo
Pintar:
    MoverCursor contador, 1
    MostrarTexto msg1        ; Puede reemplazarse por otro carácter o texto
    MoverCursor contador, 24
    MostrarTexto msg1
    inc contador
    jmp Ciclo
FinCiclo:
ENDM


Inicio PROC FAR
    mov ax, @data
    mov ds, ax

    ; Borra la pantalla antes de iniciar
    BorrarPantalla

    ; Dibuja las líneas horizontales superior e inferior
    DibujarBordes

    ; Coloca e imprime los mensajes en distintas posiciones
    MoverCursor 38, 1
    MostrarTexto msg1

    MoverCursor 37, 12
    MostrarTexto msg2

    MoverCursor 26, 23
    MostrarTexto msg3

    ; Finaliza el programa
    mov ah, 4Ch
    int 21h
Inicio ENDP

END Inicio
