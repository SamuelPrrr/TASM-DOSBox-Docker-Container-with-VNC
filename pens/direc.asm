Pila Segment para stack 'stack'
    DB 64 dup('stack') ;Definimos espacio 
Pila ENDS

Datos Segment para public 'code'
    dddd dw 0 ; 0
    dddw dw 300 ; 012C
    dddx dw 200 ; 00CB
    dddy dw 150 ; 0096
    dddz dw 125 ; 0070
    dddq dw 900 ; 0064
    dddr dw 80 ; 0050
    ddds dw 70 ; 0046
    dddj dw 60 ; 003C
    dddu dw 50; 0032
Datos ENDS

Codigo Segment para public 'code'
    Principal proc FAR
        Assume CS:Codigo, SS:Pila, DS:Datos
            MOV AX, seg Datos ;Obligatorio
            MOV DS, AX ;Obligatorio

            MOV AX, dddw ; direccionamiento variable-registro o registro-variable
            MOV BX, offset dddx ; offset manda la dirección de memoria (como un puntero)
            MOV AX, [BX] ; [BX] entre corchetes accedemos al contenido ; lo que hicimos con la linea 23 y 24 es un redireccionamiento indirecto
            MOV AX, [BX+2] ; Redireccionamiento relativo a la base
            ; Direccionamiento indexado
            MOV SI, 2 // Short index vale 2
            MOV AX, dddz [SI]  ; direccionamiento indexado de la direccion de memoria de dddz sumale dos indexes y ese valor en su dirección de memoria se la mandara
            ;Direccionamiento indexado a la base 
            MOV BX, offset dddw
            MOV SI, 8
            MOV SI, [BX][SI+2] ; dw salta de dos en dos por son 2 bytes
            MOV Ah, 4h ; interrupciones para terminar el programa
            int 21h
        Principal ENDP ; Terminar proceso
    Codigo ENDS
END Principal

;NO PERMITIDO
@ Variable -> Variable (ddy, ddww)
@ Variable -> Constante (mov 3, ddww)
@ Registro -> Constante (8, SI)
@ Constante -> Constante (8, 8)

