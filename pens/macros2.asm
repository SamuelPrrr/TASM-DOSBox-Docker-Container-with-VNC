.model small
.stack
.data
    nombre db "Bienvenido Samuel$"
.code

; --- Macro para mover el cursor a una posición específica ---
posicionar_cursor MACRO fila, columna
    mov ah, 2
    mov bh, 0
    mov dh, fila
    mov dl, columna
    int 10h
ENDM

; --- Macro para imprimir un carácter varias veces ---
imprimir_caracter MACRO caracter, veces
    mov ah, 9
    mov al, caracter
    mov bh, 0
    mov bl, 7
    mov cx, veces
    int 10h
ENDM

; --- Macro para limpiar la pantalla ---
limpiar_pantalla MACRO
    mov ah, 0
    mov al, 3
    int 10h
ENDM

; --- Procedimiento principal ---
inicio proc far
    mov ax, @data
    mov ds, ax

    limpiar_pantalla

    ; --- Esquinas del marco ---
    posicionar_cursor 0, 0
    imprimir_caracter 201, 1

    posicionar_cursor 0, 79
    imprimir_caracter 187, 1

    posicionar_cursor 24, 0
    imprimir_caracter 200, 1

    posicionar_cursor 24, 79
    imprimir_caracter 188, 1

    ; --- Bordes horizontales ---
    posicionar_cursor 0, 1
    imprimir_caracter 205, 78

    posicionar_cursor 24, 1
    imprimir_caracter 205, 78

    ; --- Bordes verticales ---
    mov cx, 23
    mov dh, 1
dibujar_bordes_verticales:
    posicionar_cursor dh, 0
    imprimir_caracter 186, 1

    posicionar_cursor dh, 79
    imprimir_caracter 186, 1

    inc dh
    loop dibujar_bordes_verticales

    ; --- Escribir el nombre centrado en cada fila ---
    mov dh, 1
    mov cx, 23
rellenar_filas:
    push cx
    push dx

    posicionar_cursor dh, 38
    lea si, nombre
mostrar_nombre:
    mov dl, [si]
    cmp dl, '$'
    je siguiente_fila
    mov ah, 2
    int 21h
    inc si
    jmp mostrar_nombre

siguiente_fila:
    pop dx
    pop cx
    inc dh
    loop rellenar_filas

    ; --- Salir del programa ---
    mov ah, 4Ch
    int 21h
inicio endp
end inicio
