org 0x0
bits 16


%define ENDL 0x0D, 0x0A


start:
    ; print logo
    mov si, logo
    call puts
    
    ; print hello message
    mov si, msg_hello
    call puts
    

.halt:
    cli
    hlt

;
; Prints a string to the screen
; Params:
;   - ds:si points to string
;
puts:
    ; save registers we will modify
    push si
    push ax
    push bx

.loop:
    lodsb               ; loads next character in al
    or al, al           ; verify if next character is null?
    jz .done

    mov ah, 0x0E        ; call bios interrupt
    mov bh, 0           ; set page number to 0
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si    
    ret


logo: db "                                                                      ", ENDL, "                              ............                            ", ENDL, "                       ..';clloooooooooooollc;'..                     ", ENDL, "                   .';looddddddddddddddddddddddool;'.                 ", ENDL, "                .,cooddddkxdddddddddddddddddddddoodolc,.              ", ENDL, "              'clddddddddOkoodddddddddddddddddxdollodddl:'            ", ENDL, "            ,coddddddddddkkdooddddddddddddddoxdddllldddddoc'          ", ENDL, "          'coddddddddddddkxxxxxxxxxdddddddolodlc:ccldddddddoc.        ", ENDL, "         :lddddddddddddxkkOOOOxxxxxkkkkxxolco;;'';lldddddddddl;       ", ENDL, "       .codddddddddxkkOOO000Okxxxkkkkkkxxxoloo;';lloddddddddddo:      ", ENDL, "      .codddddddddO000O00O00kxdxkOOOOkkkkkkxd:,cdddddddddddddddoc     ", ENDL, "      codddddddddO0K0kd:xOOkxddkOOOkxxxkkkkkkkdddllxddddddddddddoc    ", ENDL, "     cldddddddddkKNX0d:.lOOOxkkkkodo:oxkkkkkkkkkxccdxddddddddddddl;   ", ENDL, "    .cdddddddddxXNN00OxkO000OOxl.Oo..'dkO000OOOOkxdxxdddddddddddddc   ", ENDL, "    clddddddddkXNNNKxxk000000OkxxdxddkO0KKKKKKKKKkxxxxddddddddddddl,  ", ENDL, "    cddddddxxxXNNNx.....,x00000OO0O000KKKKKKKKKKKkdxxxdddddddddddddc  ", ENDL, "    cdddddxxxxXNNX:.....,d0O0000KKKKKKKKKKKKKKKKK0dxxxxddddddddddddc  ", ENDL, "    cdddddddxkNNX0:,...,oOOOOOkO0000KKKKKKKKKKKKK0dxxxxxdddddddddddc  ", ENDL, "    cddddddxxxXNXXx,''''lOOOkkkO0KKKKKKKKKKKKKKK0xdxxxxxddddddddddd:  ", ENDL, "    ;odddddddd0XXXXo::;;;:llc::cO0KKKKKKKKKKKKK0xdxxdxxxxdddddddddo'  ", ENDL, "    .cddddddddxXXXXKOdlodddxxxxO00KKKKKKKKKKKK0xdxxdddxxxdddddddddc   ", ENDL, "     ;oddddddddxXXKKKK0000O000KKKKKKKKKKKKKKKOxdddoodddxxxdddddddo.   ", ENDL, "      :ddddddddk000KKKKK00KKKKKKKKKKKKKK00KK0Oxdolloxxxxxxddddddd;    ", ENDL, "       cdddddddO00OkOKKKKKKKKKKKKKKK00OkO0KKK0kddldxkkOOxddddddd:     ", ENDL, "        cdddddd0000OOkOOO0000OOOkkkxkkO000000OkxxkO00OO0ddddddd;      ", ENDL, "         ;odddx0000000OkkkxxxxxkkkOO00OO0O0OOOO00000000Odddddo'       ", ENDL, "           lddO00000000kxkkxxxkO00OO0OOOO0OOO000000000Okddddl         ", ENDL, "            .o000000000kxxxxkOOO0OOO0OOO0000000000000Oxddol           ", ENDL, "               dO000000OxkOO0OOO00OO000000000000000Oxddoc             ", ENDL, "                 .xO0OOkkOOOOO0OOO0000000000000000xdol.               ", ENDL, "                     ldxkkkkO0000000000000000000kd:                   ", ENDL, "                          :dkO00000000000Okxd;                        ", ENDL, 0
msg_hello: db ENDL, ENDL, ENDL, ENDL, ENDL, ENDL, ENDL, "Hello from Doge!", ENDL, "What this OS does is literally nothing....", ENDL, 0

