dosseg
.model small
.data
    greating_msg db "Welcome in 8086-Calculator type simple equations to solve",10,"   Examples : 1+1 or 5*8",10,"$"
    error_msg db 10,"Exit due error$"
    input db 3 DUP('0')
.code
    ; printing greating_msg
    mov dx,@data ;move offsets to data segment
    mov ds,dx
    
    mov ah,9
    mov dx,offset greating_msg
    int '!'         ; '!' = 21h
    
    mov bx,0
take_input:                        ; loop to take input and print dl for each letter
    mov ah,8        ; to input 1 character
    int '!'
    mov cl,al
    cmp bx,1        ; if it's the second character then it's opreation
    je check_opreation

check_number: ; check if the input is a number (more or equal to 0 and less or equal to 9)
    cmp cl,'0'
    jb print_error_and_quit          ; to stop looping if error
    cmp cl,'9'
    ja print_error_and_quit          ; to stop looping if error
    jmp assign

check_opreation:
    cmp cl,'+'
    je assign
    cmp cl,'-'
    je assign
    ;cmp cl,'*' ; TODO support the following oprations
    ;je assign
    ;cmp cl,'/'
    ;je assign
    jmp print_error_and_quit

assign:
    call print_cl
    mov input[bx],cl
    inc bx
    cmp bx,3
    jne take_input

calculate_input:
    mov cl,input[0]         ; First number
    mov bl,input[1]         ; the mark between the numbers
    mov ch,input[2]          ; Second number
    cmp bl,'+'
    je adding
    cmp bl,'-'
    je subtracting
    ; TODO support the following oprations
    ;cmp bl,'*'
    ;je multiplying
    ;cmp bl,'/'
    ;je dividing
print_error_and_quit:
    mov ah,9
    mov dx,offset error_msg
    int '!'         ; '!' = 21h
    
quit: ; Quit the program
    mov ah,'L'  ; 'L' = 4Ch
    int '!'
    
adding:
    call print_equal_sign
    sub ch,48
    add cl,ch
    call print_cl
    jmp quit
    
subtracting:
    call print_equal_sign
    sub ch,48
    sub cl,ch
    call print_cl
    jmp quit
    
print_equal_sign:
    mov ah,2
    mov dl,'='
    int '!'
    ret
    
print_cl:
    mov ah,2
    mov dl,cl
    int '!'
    ret
end
