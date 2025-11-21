Extrn nombreProc:FAR, binarioProc:FAR, macrosProc:FAR

.model small
.stack
.data  
    titulo db 10,13,"===== MENU PRINCIPAL =====",10,13,"$"
    op1 db "1. Nombre centrado$"
    op2 db 10,13,"2. Convertir a binario$"
    op3 db 10,13,"3. Marco con macros$"
    op4 db 10,13,"4. Salir$"
    prompt db 10,13,10,13,"Seleccione una opcion: $"
    opcion db ?
.code
    Principal Proc FAR
        mov AX, @data
        mov DS, AX
        
        push DS
        xor AX, AX
        push AX
        
    menu_loop:
        ;Limpiar pantalla
        mov AH, 0
        mov AL, 3
        int 10h
        
        ;Mostrar título
        mov AH, 9
        mov DX, offset titulo
        int 21h
        
        ;Mostrar opciones
        mov DX, offset op1
        int 21h
        mov DX, offset op2
        int 21h
        mov DX, offset op3
        int 21h
        mov DX, offset op4
        int 21h
        
        ;Mostrar prompt
        mov DX, offset prompt
        int 21h
        
        ;Leer opción
        mov AH, 1
        int 21h
        mov opcion, AL
        
        ;Evaluar opción
        cmp opcion, '1'
        je llamar_nombre
        cmp opcion, '2'
        je llamar_binario
        cmp opcion, '3'
        je llamar_macros
        cmp opcion, '4'
        je salir
        jmp menu_loop ;Opción inválida, repetir
        
    llamar_nombre:
        call nombreProc
        jmp menu_loop
        
    llamar_binario:
        call binarioProc
        jmp menu_loop
        
    llamar_macros:
        call macrosProc
        jmp menu_loop
        
    salir:
        mov AH, 4ch
        int 21h
        
    Principal ENDP
End Principal
