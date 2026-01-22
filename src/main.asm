.p816
.smart

.include "macros.inc"
.include "registers.inc"


.include "header.asm"

.include "variables.asm"


.segment "CODE"
entry:
	.include "init.asm"
entry_main:
	.a16 ; the setting from init code
	.i16
	phk
	plb
	; init nmi
	lda #$80
	sta NMITIMEN
	; Init DBR
	lda #$00
	pha
	plb
	cli
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
	lda #$00
	sta NMITIMEN
	lda #$80
	sta INIDISP

	setAXY16
	; graphics init stuff

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
	jsr wait_vblank
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
