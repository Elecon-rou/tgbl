; TGBL bootsector

; Args: number of sectors to load
%macro tgblm_boot 1
boot:
	cli
	; Overlap CS and DS to save space
	mov ax, cs
	mov ds, ax
	mov es, ax
	; Setup 4K stack
	xor ax, ax
	mov ss, ax
	mov sp, 0x7c00
	; Save disk number (DL) in stack
	xor dh, dh
	push dx
	; Load next sectors
	mov ah, 0x02
	mov al, %1
	mov cx, 0x0002
	pop dx
	mov bx, bootend
	int 13h
	; Start
	jmp bootend

; Fill the rest of bootsector with zeroes and end it
times 510 - ($ - boot) db 0
dw 0xAA55
bootend:
%endmacro
