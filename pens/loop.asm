.model small
.stack
.data
    nombre db "Samuel $"
	nombreS db "Saltos propios", 10, 13, "$"
.code
	Principal Proc Far
		mov AX, @data
		mov DS, AX ;Limpiar pantalla
		
		;Limpiar 
		MOV AH, 0
		MOV AL, 3 ;El numero define el ancho de la pantall
		int 10h

        ;Ciclo 1
		MOV CX, 10
		ciclo1:
        MOV AH, 9
        MOV DX, offset nombre
        int 21h

		Loop ciclo1

		;Ciclo 2
		MOV Si, 1
		ciclo2:
		CMP Si, 10
		JBE imprimir
		JMP fin 

		imprimir:
		MOV AH, 9
		MOV DX, offset nombreS
		int 21h
		inc Si
		JMP ciclo2
		
		fin:
		MOV AH, 4ch
		int 21h

	Principal ENDP
END Principal