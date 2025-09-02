Pila Segment para stack 'stack'
    DB 64 dup('stack') ;Definimos espacio 
Pila ENDS

Datos segment para public 'data'
    V1 dw 20
    V2 dw 30
    R dw ? 
Datos ENDS

Codigo Segment para public 'code'
    Principal proc FAR
        Assume CS:Codigo, SS:Pila, DS:Datos
            MOV AX, seg Datos
            MOV DS, AX
            MOV AX, V1
            MOV BX, V2
            ADD AX, BX
            MOV R, AX
            MOV AH, 4cH
            Int 21h 
        Principal ENDP ; Terminar proceso
    Codigo ENDS
END Principal
