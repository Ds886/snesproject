.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "header.asm"

.segment "CODE7"
SpriteData: .incbin "../out/img_16.chr"
SpriteData_end:
ColorData: .incbin "../out/img_16.pal"
ColorData_end:

.segment "BSS"

.segment "CODE"
entry:
	.include "init.asm"
	; ; init nmi
	; lda #$80
	; sta NMITIMEN
	cli
	; Init DBR
	lda #$00
	pha
	plb
	jsr init_vars
	jsr init_gfx
main_loop:
	nop
main_loop_default:
	jsr draw_sprite
	; jsr draw
	wai
	jmp main_loop

draw_sprite:
	lda #$10
	sta TM
	lda #$0f
	sta INIDISP
	lda #$81
	sta NMITIMEN

	rts

draw:
	lda #$ff
	sta CGDATA
	lda #$ff
	sta CGDATA
	lda #$0f
	sta INIDISP
	rts
; https://georgjz.github.io/snesaa04/
init_gfx:
	; VRAM DATA Load
	stz VMADDL
	stz VMADDH
	lda #$80
	sta BGMODE
	sta VMAIN
	ldx #$00
VRAMLoop:
	; bitpalne 0,2
	lda SpriteData, X
	sta VMDATAL
	inx
	; bitpalne 1,3
	lda SpriteData, X
	sta VMDATAH
	cpx # (SpriteData_end - SpriteData)
	bcc VRAMLoop
	; Color data load
	lda #$80
	sta CGADD
	ldx #$00
CGRAMLoop:
	; Low byte
	lda ColorData, X
	sta CGDATA
	inx
	lda ColorData, X
	sta CGDATA
	inx
	cpx # (ColorData_end - ColorData)
	bcc CGRAMLoop

	; OAMDATA
	stz OAMADDL
	stz OAMADDH
	;horiz
	lda # (256/2 -8)
	sta OAMDATA
	;vert
	lda # (224/2 -8)
	sta OAMDATA
	; name
	lda #$00
	sta OAMDATA
	; no flip prio 0 pal 0
	lda #$00
	sta OAMDATA



	rts

init_vars:
	rts

h_nmi:
	bit RDNMI
	jmp _rti

_rti:
	rti
