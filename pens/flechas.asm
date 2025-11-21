.model small
.stack 100h

;Samuel Palomares Rios

.data
    ancho   dw 40
    alto    dw 12
    simbolo db 15    ; Caracter 

.code
inicio:
    mov ax, @data
    mov ds, ax

    ; Configurar modo de video 
    mov ah, 00h
    mov al, 03h
    int 10h

    ; Calcular coordenadas del cuadro centrado
    mov ax, 80
    sub ax, [ancho]
    shr ax, 1
    mov si, ax      ; X inicial del cuadro

    mov ax, 25
    sub ax, [alto]
    shr ax, 1
    mov di, ax      ; Y inicial del cuadro

    mov ax, si
    add ax, [ancho]
    dec ax
    mov bp, ax      ; X final del cuadro

    mov ax, di
    add ax, [alto]
    dec ax
    mov dx, ax      ; Y final del cuadro

    mov ax, [ancho]
    shr ax, 1
    add ax, si
    mov bx, ax      ; Posición X del símbolo (centro)

    mov ax, [alto]
    shr ax, 1
    add ax, di
    mov cx, ax      ; Posición Y del símbolo (centro)

    push ax
    push bx
    push cx
    call DibujarSimbolo
    pop cx
    pop bx
    pop ax

bucle_principal:
    mov ah, 0
    int 16h          ; Esperar tecla
    cmp al, 27       ; ¿Presionó ESC?
    je fin
    cmp al, 0
    jne bucle_principal
    mov al, ah       ; Tecla especial
    cmp al, 72
    je tecla_arriba
    cmp al, 80
    je tecla_abajo
    cmp al, 75
    je tecla_izquierda
    cmp al, 77
    je tecla_derecha
    jmp bucle_principal

tecla_arriba:
    cmp cx, di
    jle bucle_principal
    dec cx
    jmp colocar_simbolo

tecla_abajo:
    cmp cx, dx
    jge bucle_principal
    inc cx
    jmp colocar_simbolo

tecla_izquierda:
    cmp bx, si
    jle bucle_principal
    dec bx
    jmp colocar_simbolo

tecla_derecha:
    cmp bx, bp
    jge bucle_principal
    inc bx

colocar_simbolo:
    push ax
    push bx
    push cx
    call DibujarSimbolo
    pop cx
    pop bx
    pop ax
    jmp bucle_principal

DibujarSimbolo proc near
    push ax
    push bx
    push cx
    push dx

    mov dl, bl      ; Columna (X)
    mov dh, cl      ; Fila (Y)
    mov bh, 0
    mov ah, 02h     ; Mover cursor
    int 10h

    mov al, [simbolo]
    mov ah, 0Eh     ; Imprimir carácter
    int 10h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
DibujarSimbolo endp

fin:
    mov ah, 4Ch
    xor al, al
    int 21h

end inicio
