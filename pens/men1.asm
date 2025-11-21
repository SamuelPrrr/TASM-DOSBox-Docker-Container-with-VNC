Pila Segment para stack 'stack'
    DB 64 dup('stack') ;Definimos espacio 
Pila ENDS

Datos Segment para public 'code'
    mensaje1 db "Hola ", 10 , 13, "$"   
    mensaje2 db "Bienvenido a ensamblador ", 10,13, "$"
    mensaje3 db "Samuel Palomares ", 10, 13, "$" 
Datos ENDS

Codigo Segment para public 'code'
    Principal proc FAR
        Assume CS:Codigo, SS:Pila, DS:Datos
            MOV AX, seg Datos ; Obligatorio
            MOV DS, AX ; Obligatorio
            
            MOV AH, 0
            MOV AL, 3 ; 80 * 25 caracteres blanco y negro 
            INT 10h

            ; Posicionar cursor para mensaje1 (arriba en medio - fila 5, columna 30)
            MOV AH, 02h  ; Función para posicionar cursor
            MOV BH, 0    ; Página de video
            MOV DH, 1    ; Fila (0-24)
            MOV DL, 30   ; Columna (0-79)
            INT 10h
            
            MOV AH, 9
            MOV DX, offset mensaje1 ; imprime hasta el signo de pesos
            int 21h

            MOV AH, 02h  ; Función para posicionar cursor
            MOV BH, 0    ; Página de video
            MOV DH, 12   ; Fila (0-24)
            MOV DL, 20   ; Columna (0-79)
            INT 10h
            
            MOV AH, 9
            MOV DX, offset mensaje2 ; imprime hasta el signo de pesos
            int 21h

            ; Posicionar cursor para mensaje3 (abajo en medio - fila 20, columna 30)
            MOV AH, 02h  ; Función para posicionar cursor
            MOV BH, 0    ; Página de video
            MOV DH, 24   ; Fila (0-24)
            MOV DL, 30   ; Columna (0-79)
            INT 10h
            
            MOV AH, 9
            MOV DX, offset mensaje3 ; imprime hasta el signo de pesos
            int 21h
            
            
            MOV Ah, 4h ; interrupciones para terminar el programa
            int 21h
        Principal ENDP ; Terminar proceso
    Codigo ENDS
END Principal



