.model small
.stack
.data
    m1 db 13, 10, "Acceso concedido!$"
    m2 db 13, 10, "Acceso denegado!$"
    m3 db 13, 10, "Introduzca contrasena: $"
    m4 db 13, 10, "Quedan $"
    m5 db " intento(s) restante(s)$"
    m6 db 13, 10, "BLOQUEADO: Se agotaron los intentos!$"
    m7 db 13, 10, "Intento incorrecto.$"
    numStr db "0$"   ; reservamos 2 bytes: el dígito y el terminador '$'
    pass db "pato" 
    passLen equ ($ - pass)   ; metodo para calcular bytes
    clave db 10 dup(?)  ; aumentamos el buffer para contraseñas más largas
    intentos db 3       ; variable para almacenar los intentos restantes
.code
Principal Proc Far
    mov AX, @data
    mov DS, AX

inicio_programa:
    ; Verificar si quedan intentos
    mov al, intentos
    cmp al, 0
    je bloqueado
    
    ; Mostrar intentos restantes
    mov AH, 9
    mov dx, offset m4
    int 21h
    
    ; Convertir intentos a ASCII y mostrar
    mov al, intentos
    add al, '0'
    mov numStr, al
    mov AH, 9
    mov dx, offset numStr
    int 21h
    
    mov AH, 9
    mov dx, offset m5
    int 21h
    
    ; Pedir contraseña
    mov AH, 9
    mov dx, offset m3
    int 21h

    ; Limpiar buffer de clave antes de usar
    mov cx, 10
    mov di, 0
limpiar_buffer:
    mov clave[di], 0
    inc di
    loop limpiar_buffer
    
    mov si, 0
input:
    mov AH, 7 ; Recibe caracter sin mostrarlo
    int 21h
    cmp al, 13       ; Enter
    je comparar
    cmp si, 9        ; Evitar desbordamiento del buffer
    jge input        ; Si ya llegamos al límite, ignorar más caracteres
    mov clave[si], al
    mov DL, '*'      ; Mostrar asterisco
    mov AH, 2
    int 21h
    inc si
    jmp input

comparar:
    cmp si, passLen
    jne fallo     

    mov bx, 0
cmp_loop:
    mov al, pass[bx]
    mov dl, clave[bx]
    cmp al, dl
    jne fallo
    inc bx
    cmp bx, passLen
    jne cmp_loop
    jmp exito

exito:
    mov AH, 9
    mov dx, offset m1
    int 21h
    jmp fin

fallo:
    ; Decrementar intentos
    dec intentos
    
    ; Mostrar mensaje de intento incorrecto
    mov AH, 9
    mov dx, offset m7
    int 21h
    
    ; Verificar si quedan intentos
    mov al, intentos
    cmp al, 0
    je bloqueado
    
    ; Si quedan intentos, volver a pedir contraseña
    jmp inicio_programa

bloqueado:
    mov AH, 9
    mov dx, offset m6
    int 21h
    jmp fin

fin: 
    mov AH, 4ch
    int 21h
Principal ENDP
END Principal
