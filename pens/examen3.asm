.model small
.stack 100h
.data
    coord_x1 db 5
    coord_y1 db 5
    coord_x2 db 74
    coord_y2 db 19

;Samuel Palomares Rios
;Examen 3

.code
extrn lejano:far    

Principal proc far
    mov ax, @data
    mov ds, ax

    ; Preparar retorno FAR
    push ds
    xor ax, ax
    push ax

    ; Limpiar pantalla
    mov ah, 0
    mov al, 3
    int 10h

    ; Pasar parámetros: primero x2,y2 luego x1,y1
    xor ax, ax
    mov al, [coord_x2]
    mov ah, [coord_y2]
    push ax

    xor ax, ax
    mov al, [coord_x1]
    mov ah, [coord_y1]
    push ax

    ; Llamar procedimiento lejano
    call lejano

    ; Terminar programa
    mov ah, 4Ch
    int 21h
Principal endp
end Principal
