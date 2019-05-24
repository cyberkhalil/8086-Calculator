dosseg
.model small
.data
    greating_msg db "Welcome in 8086-Calculator type simple equations to solve",10,"   Examples : 1+1 or 5*8",10,"$"
    input db 3 DUP('0')
.code
    ; printing greating_msg
    mov dx,@data ;move offsets to data segment
    mov ds,dx
    
    mov ah,9
    mov dx,offset greating_msg
    int '!' ;21h = '!'
    
    mov bx,0
    call take_input
    call calculate_input
    
    ; Quit the program
    quit:
    mov ah,'L'
    int '!'

    take_input:                        ; loop to take input and print dl for each letter
    mov ah,8
    int '!'
    mov cl,al
    cmp bx,1
    je check_opreation
    cmp cl,48                          ; 13 in decimal is the ascii for enter
    jb quit_take_input                 ; to stop looping
    cmp cl,57
    ja quit_take_input
    jmp assign
    
    check_opreation:
    cmp cl,'+'
    je assign
    cmp cl,'-'
    je assign
    
    ; TODO support the following oprations
    ;cmp cl,'*'
    ;je assign
    ;cmp cl,'/'
    ;je assign
    
    assign:
    mov input[bx],cl
    mov dl,cl
    mov ah,2
    int '!'
    mov dl,0
    inc bx
    cmp bx,3
    jne take_input
    quit_take_input:
    ret
    
    calculate_input:
    mov cl,input[0]         ; First number
    mov bl,input[1]         ; the mark between the numbers
    mov ch,input[2]          ; Second number
    cmp bl,'+'
    je add_and_quit
    cmp bl,'-'
    je sub_and_quit
    ret
    
    add_and_quit:
    mov ah,2
    sub ch,48
    add cl,ch
    mov dl,'='
    int '!'
    mov dl,cl
    int '!'
    call quit
    ret
    
    sub_and_quit:
    sub ch,48
    sub cl,ch
    mov ah,2
    mov dl,'='
    int '!'
    mov dl,cl
    int '!'
    call quit
    ret
    end
