.model small
.stack
.data
    nombre db "Juan $"
.code
	Principal Proc Far
		mov AX, @data
		mov DS, AX ;Limpiar pantalla
		
		;Limpiar 
		MOV AH, 0
		MOV AL, 3 ;El numero define el ancho de la pantall
		int 10h
		
		;Posición
		MOV AH, 2
		MOV DH, 12 ;Fila
		MOV DL, 38 ;Columna 
		int 10h

        ;Impresión
        MOV AH, 9
        MOV DX, offset nombre
        int 21h
		
		MOV AH, 4ch
		int 21h
	Principal ENDP
END Principal