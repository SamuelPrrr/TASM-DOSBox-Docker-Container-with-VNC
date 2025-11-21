Pila Segment para stack 'stack'
DB 64 dup ('stack')
Pila ENDS

Datos Segment Para Public 'Data'
    men1 DB "Introduce valor 1 $" ; Define Byte → “define un byte (o varios bytes) en memoria dentro de un segmento de datos”.
    men2 DB 10,13, "Introduce valor2 $" ; 10 = mueve al inicio, 13 = salto de linea
    men3 DB 10,13, "La suma es: $"
    V1 DB ?        
    V2 DB ?
    R DB ?
    BDecimal DB 10
    Residuo DB ?
Datos ENDS

Codigo Segment Para Public 'code'
    Principal Proc FAR ; define el procedimiento principal, “FAR” significa que puede estar en un segmento diferente al que llama.
    Assume CS:Codigo, DS:Datos, SS:Pila, 

    ;Limpiar pantalla
    mov AX, Seg Datos
    mov DS, AX
    int 10h

    mov AH, 9 ;Tabla de interrupciones
    mov DX, offset men1 ;Offset es el movimiento de dezplazamiento a mensaje 1
    Int 21h

    ;captura un caracter numerico
    ;AL tiene 34 
    mov AH, 1 ;Solicitamos valor
    int 21h ;Ejecutamos
    SUB AL, 30h ; Restamos en hexadecimal 30h por que los numeros empiezan en 30h = 0 en ASCII, entonces al restarle 30h obtenemos el numero en decimal
    mov v1, AL

     mov AH, 9 ;Tabla de interrupciones
    mov DX, offset men2 ;Offset es el movimiento de dezplazamiento a mensaje 2
    Int 21h

    ;captura un caracter numerico
    ;AL tiene 34 
    mov AH, 1
    int 21h

    SUB AL, 30h
    mov V2, AL

    ADD AL, V1

    mov R, AL 
   
    
    ;Imprimir el valor de R

    mov AH, 9 ;Tabla de interrupciones
    mov DX, offset men3 ;Offset es el movimiento de dezplazamiento a mensaje 3
    Int 21h

    ;mov DL, R
    ;mov AH, 2
    ;int 21h
    
    mov AX,0 
    mov AL, R
    div BDecimal
    mov Residuo, AH
    mov DL, AL ;AL=1
    add DL, 30h
    mov AH, 2 ; AH=2 Decimal
    int 21h 

    mov DL, Residuo
    add DL, 30h
    mov AH, 2
    int 21h

    mov AH, 4ch
    int 21h



     Principal ENDP
     Codigo ENDS
    END Principal

