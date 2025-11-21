.model small
.data
    texto_nombre db "Samuel P$"
    esquina_x1 db ?
    esquina_y1 db ?
    esquina_x2 db ?
    esquina_y2 db ?

.code
public lejano

lejano proc far
    push bp
    mov bp, sp

    ; Obtener parámetros de la pila
    mov ax, [bp+6]      ; x1, y1
    mov esquina_x1, al
    mov esquina_y1, ah

    mov ax, [bp+8]      ; x2, y2
    mov esquina_x2, al
    mov esquina_y2, ah

    ; Limpiar pantalla
    mov ax, 0003h
    int 10h

    ; Dibujar esquina superior izquierda
    mov ah, 2
    mov bh, 0
    mov dl, esquina_x1
    mov dh, esquina_y1
    int 10h
    mov ah, 0Eh
    mov al, 201         ; Caracter ┌
    int 10h

    ; Dibujar esquina superior derecha
    mov ah, 2
    mov bh, 0
    mov dl, esquina_x2
    mov dh, esquina_y1
    int 10h
    mov ah, 0Eh
    mov al, 187         ; Caracter ┐
    int 10h

    ; Dibujar esquina inferior izquierda
    mov ah, 2
    mov bh, 0
    mov dl, esquina_x1
    mov dh, esquina_y2
    int 10h
    mov ah, 0Eh
    mov al, 200         ; Caracter └
    int 10h

    ; Dibujar esquina inferior derecha
    mov ah, 2
    mov bh, 0
    mov dl, esquina_x2
    mov dh, esquina_y2
    int 10h
    mov ah, 0Eh
    mov al, 188         ; Caracter ┘
    int 10h

    ; Dibujar línea horizontal superior
    mov al, 205         ; Caracter ─
    mov cl, esquina_x2
    sub cl, esquina_x1
    dec cl

    mov ah, 2
    mov bh, 0
    mov dl, esquina_x1
    inc dl
    mov dh, esquina_y1
    int 10h

    mov ah, 0Ah
    mov ch, 0
    mov bl, 7
    int 10h

    ; Dibujar línea horizontal inferior
    mov ah, 2
    mov bh, 0
    mov dl, esquina_x1
    inc dl
    mov dh, esquina_y2
    int 10h

    mov ah, 0Ah
    mov ch, 0
    mov bl, 7
    int 10h

    ; Preparar ciclo para líneas verticales
    mov cl, esquina_y2
    sub cl, esquina_y1
    dec cl
    mov dh, esquina_y1
    inc dh

dibujar_verticales:
    ; Dibujar borde izquierdo
    mov ah, 2
    mov bh, 0
    mov dl, esquina_x1
    int 10h
    mov ah, 0Eh
    mov al, 186         ; Caracter │
    int 10h

    ; Dibujar borde derecho
    mov ah, 2
    mov bh, 0
    mov dl, esquina_x2
    int 10h
    mov ah, 0Eh
    mov al, 186         ; Caracter │
    int 10h

    inc dh
    dec cl
    jnz dibujar_verticales

    ; Calcular posición X centrada
    xor ax, ax
    mov al, esquina_x1
    add al, esquina_x2
    shr al, 1

    ; Contar longitud del nombre
    lea si, texto_nombre
    mov bx, 0
calcular_longitud:
    cmp byte ptr [si], '$'
    je longitud_calculada
    inc bx
    inc si
    jmp calcular_longitud
longitud_calculada:

    ; Ajustar X para centrar el texto
    mov cx, bx
    mov bl, cl
    shr bl, 1
    sub al, bl
    mov dl, al

    ; Calcular posición Y centrada
    xor ax, ax
    mov al, esquina_y1
    add al, esquina_y2
    shr al, 1
    mov dh, al

    ; Posicionar cursor
    mov ah, 2
    mov bh, 0
    int 10h

    ; Imprimir nombre
    lea si, texto_nombre
escribir_nombre:
    lodsb
    cmp al, '$'
    je nombre_impreso
    mov dl, al
    mov ah, 2
    int 21h
    jmp escribir_nombre
nombre_impreso:

    ; Posicionar cursor al final de la pantalla
    mov dl, 0
    mov dh, 24
    mov ah, 2
    mov bh, 0
    int 10h

    ; Retornar
    pop bp
    retf 4              ; Limpiar 4 bytes de parámetros

lejano endp
end