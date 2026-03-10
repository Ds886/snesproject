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
	lda #(INIDISP_FORCE_BLANK|INIDISP_BRIGHT_F)
	sta INIDISP
	
	; init nmi
	disableNMI
	; Init DBR
	; lda #$00
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
	setAXY16
	phk
	plb

	lda #1
	sta BGMODE
	lda #(TM_EN_OBJ)
	sta TM
	lda #INIDISP_ON_FULL
	sta INIDISP
	lda #2 ;sprite tiles at $4000
	sta OBSEL ;= $2101
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
