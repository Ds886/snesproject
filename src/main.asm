.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "res.inc"

.include "header.asm"

.segment "ZEROPAGE"
in_nmi: .res 2


.segment "BSS"
PAL_BUFFER: .res 512 ;palette
OAM_BUFFER: .res 512 ;low table
OAM_BUFFER2: .res 32 ;high table

.segment "CODE"
entry:
	.include "init_v1.asm"
entry_main:
.a16 ; the setting from init code
.i16
	phk
	plb
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
	; insert alt code path here
	nop
main_loop_default:
	wai
	jmp main_loop
	rts

init_gfx:
	sep #$20
	lda #$80
	sta INIDISP

	setAXY16
	; sep #$20
	; lda #$80
	; sta INIDISP
	load_tile Moon
	jsr reset_gfx
	load_tile Img3

	lda #1
	sta BGMODE
	stz BG12NBA
	lda #$60
	sta BG1SC
	lda #$01 ; BG_on
	sta TM
	lda #$0F
	sta INIDISP
	rts

reset_gfx:
	; jsr Clear_WRAM
	jsr DMA_Palette
	jsr Clear_Palette
	jsr DMA_OAM
	jsr Clear_VRAM

	rts
init_vars:
	rts

h_nmi:
	bit RDNMI
	inc in_nmi
	jmp _rti

_rti:
	rti
