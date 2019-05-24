dosseg
.model small
.data
    greating_msg db "Hello World$"
.code
    ; printing greating_msg
    mov dx,@data ;move offsets to data segment
    mov ds,dx
    
    mov ah,9
    mov dx,offset greating_msg
    int '!' ;21h = '!'
    
    ; Quit the program
    mov ah,'L'
    int '!'
    end
