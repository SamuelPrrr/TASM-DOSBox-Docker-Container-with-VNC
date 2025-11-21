.model small
.stack
.Data
    numInvertido db 5 dup(?)
    numTexto db 5 dup(?)
    base db 10
    mssg1 db "Introduce la cantidad: $"
    num db ?
    mssg2 db 10,13,"La suma + 30 =$"
    aux db ?
    expo db 1,10,100
    suma db ?

.code
Principal proc FAR
    mov AX, @Data
    mov DS, AX

    mov AH,0
    mov AL,3
    INT 10H

    mov AH,9
    mov DX, offset mssg1
    int 21H

    mov AL,24h
    push AX

askNum:
    mov AH,1 
    int 21h 
    cmp al, 13
    JE salte
    PUSH AX
    JMP askNum

salte: 
    mov si,0

invierteNum:
    POP DX
    cmp DL,"$"
    JE salte2
    mov numInvertido[si], DL
    inc si
    JMP invierteNum

salte2:
    mov numInvertido[si],"$"

    mov si,0
    mov suma,0
    mov AX,0

convierte:
    mov AL,numInvertido[si]
    CMP AL,"$"
    JE finConvierte
    SUB AL,30H
    mul expo[si]
    add suma,AL
    inc si
    JMP convierte

finConvierte:
    add suma,30

    mov AH, "$"
    push AX
    mov AX, 0
    mov AL, suma

CicloFor1:
    DIV base
    CMP AL, 0
    JE SalidaFor1
    push AX
    mov AH, 0
    JMP CicloFor1

SalidaFor1:
    push AX

CicloFor2:
    pop DX
    CMP DH, "$"
    JE fin
    mov DL, DH
    ADD DL, 30h 
    mov AH, 2
    INT 21h
    JMP CicloFor2

fin:   
    mov AH,4CH
    int 21H
Principal ENDP
END Principal
