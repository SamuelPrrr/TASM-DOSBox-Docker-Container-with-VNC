.model small
.stack
.data
    A db 7
    B db 8
    m1 db "A es mayor que B$"
    m2 db "B es mayor que A$"
.code
	Principal Proc Far
		mov AX, @data
		mov DS, AX ;Limpiar pantalla
		
        MOV AL, A
        CMP AL, B
        JA menA 
        MOV AH, 9
        MOV DX, offset m2
        int 21h
        JMP fin ; salto incondicional

        menA:
        MOV AH, 9
        MOV DX, offset m1
        int 21h

        fin: 
		MOV AH, 4ch
		int 21h
	Principal ENDP
END Principal