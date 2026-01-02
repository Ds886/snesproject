.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "header.asm"

.segment "BSS"
COUNT_ANIM: .res 1
LO_COLOR: .res 1
HI_COLOR: .res 1

.segment "CODE"
MAX_ANIM = $0C
entry:
	.include "init.asm"
	; init nmi
	lda #$80
	sta NMITIMEN
	cli
	; Init DBR
	lda #$00
	pha
	plb
	jsr init_vars
main_loop:
	lda COUNT_ANIM
	bne main_loop_default
	lda LO_COLOR
	clc
	adc #2
	sta LO_COLOR
	lda  HI_COLOR
	clc
	adc #10
	sta HI_COLOR
	lda #MAX_ANIM
	sta COUNT_ANIM
main_loop_default:
	jsr draw
	wai
	jmp main_loop

draw:
	lda LO_COLOR
	sta CGDATA
	lda HI_COLOR
	sta CGDATA
	lda #$0f
	sta INIDISP
	rts

init_vars:
	lda MAX_ANIM
	sta COUNT_ANIM
	lda #$1f
	sta LO_COLOR
	lda #$00
	sta HI_COLOR
	rts

h_nmi:
	bit RDNMI
	lda COUNT_ANIM
	beq h_nmi_default
	dec COUNT_ANIM
h_nmi_default:
	jmp _rti

_rti:
	rti
