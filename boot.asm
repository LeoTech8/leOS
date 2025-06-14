[org 0x7c00]
mov ah, 0x0e
mov bx, osName

printString:
        mov al, [bx]
        cmp al, 0
        je end
        int 0x10
        inc bx
        jmp printString
end:
        jmp $

osName:
    db "leoOS - Version 0.1 - Get the code at github.com/LeoTech8/leoOS", 0

times 510-($-$$) db 0
db 0x55,0xaa
