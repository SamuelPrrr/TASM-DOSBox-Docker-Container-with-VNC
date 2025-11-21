.model small
.stack
.data
    salto_linea   db 10,13,"$"
    espacio       db " $"
;Samuel Palomares
;Macros
; Imprimir un solo carácter
print_char macro char
    mov dl, char
    mov ah, 2h
    int 21h
endm

; Imprimir una cadena terminada en $
print_string macro label
    mov ah, 9
    mov dx, offset label
    int 21h
endm

; Limpia pantalla (modo texto 80x25)
cls macro
    mov ah, 0
    mov al, 3
    int 10h
endm

; Finaliza el programa
exit_program macro exitcode
    mov ah, 4Ch
    int 21h
endm


.code
; PROCEDIMIENTO: Imprime A–Z
; Entradas: AL = código ASCII inicial
print_uppercase proc near
upper_loop:
        print_char al
        print_string espacio
        inc al            ; siguiente letra
        cmp al, 91        ; 91 = [ (fin de Z=90)
        jne upper_loop
        ret
print_uppercase endp


; PROCEDIMIENTO: Imprime a–z
; Entradas: AL = código ASCII inicial
print_lowercase proc near
lower_loop:
        print_char al
        print_string espacio
        inc al
        cmp al, 123       ; 123 = { (fin de z=122)
        jne lower_loop
        ret
print_lowercase endp


; PROCEDIMIENTO: Imprime 0–9
; Entradas: AL = código ASCII inicial
print_digits proc near
digits_loop:
        print_char al
        print_string espacio
        inc al
        cmp al, 58        ; 58 = : (fin de '9'=57)
        jne digits_loop
        ret
print_digits endp


; PROCEDIMIENTO PRINCIPAL (FAR)
main proc far
    mov ax, @data
    mov ds, ax

    cls

    ; Imprimir A–Z
    mov al, 65           ; 'A'
    call print_uppercase
    print_string salto_linea

    ; Imprimir a–z
    mov al, 97           ; 'a'
    call print_lowercase
    print_string salto_linea

    ; Imprimir 0–9
    mov al, 48           ; '0'
    call print_digits
    print_string salto_linea

    exit_program 0
main endp
end main
