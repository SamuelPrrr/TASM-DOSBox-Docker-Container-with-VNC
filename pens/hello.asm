Datos segment para public 'data'
    msg db "Hola mundo!$"
Datos ends

Codigo segment para public 'code'
Principal proc far
    assume cs:Codigo, ds:Datos
    mov ax, seg Datos
    mov ds, ax

    mov ah, 09h        ; función 09h = imprimir cadena
    mov dx, offset msg ; dirección de la cadena
    int 21h            ; llamada a DOS

    mov ah, 4Ch        ; salir
    int 21h
Principal endp
Codigo ends
end Principal
