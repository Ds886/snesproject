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
	lda #(NMITIMEN_VBLANK_ON)
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
	setA8
	lda #NMITIMEN_DISABLE
	sta NMITIMEN
	lda #INIDISP_FORCE_BLANK
	sta INIDISP

	setAXY16
	; graphics init stuff

	lda #BGMODE_MODE1_2BG_TEXT
	sta BGMODE
	stz BG12NBA
	lda #(BGSC_SIZE_64x32 | $20)
	sta BG1SC
	lda #TM_EN_BG1
	sta TM
	lda #INIDISP_ON_FULL
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
