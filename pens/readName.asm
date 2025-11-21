.model small
.stack
.data
    nombre db 25 dup(?) ;Definición de arreglo
	Base   db 2        ; base de división (decimal)
    PR     db ?         ; resultado/temporal
.code
	Principal Proc Far
		mov AX, @data
		mov DS, AX ;Limpiar pantalla
		
		;Limpiar 
		MOV AH, 0
		MOV AL, 3 ;El numero define el ancho de la pantalla
		int 10h

        ;Ciclo 1
		MOV SI, 0
		ciclo1:
        MOV AH, 1
		int 21h
		;incremento
		CMP AL, 13 ;Enter en codigo ascii
		JE fin
		MOV nombre[SI], AL
		inc SI
		CMP SI, 24 ;Evitar overflow del buffer
		JL ciclo1

		fin:
		;Calcular posición para centrar
		MOV AX, SI
		MOV BL, 2    ; Dividir entre 2 para centrar
		DIV BL       ; AX/2 -> AL=cociente, AH=residuo
		MOV BL, 40   ; Centro de pantalla (columna 40)
		SUB BL, AL   ; 40 - (longitud/2) = posición inicial
		MOV PR, BL   ; Guardar posición calculada
		MOV nombre[SI], '$' ;Terminador de cadena

		;Limpiar pantalla
		MOV AH, 0
		MOV AL, 3
		int 10h
		
		;Posicionar cursor usando PR calculado
		MOV AH, 2
		MOV DH, 12   ; Fila 12
		MOV DL, PR   ; Columna calculada
		int 10h
		
        ;Impresión
        MOV AH, 9
        MOV DX, offset nombre
        int 21h
        
        ;Pausa - esperar a que se presione una tecla
        MOV AH, 1
        int 21h
        
		;salimos
		MOV AH, 4ch
		int 21h

	Principal ENDP
END Principal