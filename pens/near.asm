.model small
.stack
.data
    
    m1 db 10,13, "Estas en el procedimiento cercano 1$"
    m2 db 10,13, "Estas en el procedimiento cercano 2$"
    m3 db 10,13, "Estas en el procedimiento cercano 3$"

.code
;Samuel Palomares
;Procedimiendo principal
principal proc far
    ; Inicializar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Limpiar pantalla (modo texto 80x25)
    mov ah, 3
    mov al, 0
    int 10h
    
    ; Llamadas a procedimientos cercanos
    call proc2
    call proc1
    call proc3

    ; Finalizar programa
    mov ah, 4Ch
    int 21h
principal endp

;Procedimientos lejanos 
proc1 proc near
    mov ah, 9
    mov dx, offset m1
    int 21h
    ret
proc1 endp

proc2 proc near
    mov ah, 9
    mov dx, offset m2
    int 21h
    ret
proc2 endp

proc3 proc near
    mov ah, 9
    mov dx, offset m3
    int 21h
    ret
proc3 endp

end principal
