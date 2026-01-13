.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "header.asm"

.segment "ZEROPAGE"
in_nmi: .res 2

.segment "CODE1"
Moon_CharData: .incbin "../res/moon/moon.chr"
Moon_CharData_end:
Moon_CharData_size = Moon_CharData_end - Moon_CharData
EmptyVRAM:
	.res 256, 0    ; 256 bytes of zeros used for the VRAM clear
EmptyVRAM_end:

.segment "CODE2"
Moon_ColorData: .incbin "../res/moon/moon.pal"
Moon_ColorData_end:
Moon_ColorData_size = Moon_ColorData_end - Moon_ColorData

Moon_TileData: .incbin "../res/moon/moon.map"
Moon_TileData_end:
Moon_TileData_size = Moon_TileData_end - Moon_TileData

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
	; jsr draw_sprite
main_loop:
	nop
main_loop_default:
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

init_gfx:
	sep #$20
	lda #$80
	sta INIDISP

	load_tile Moon

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
init_gfx_clear_rem:
	ldx #$6200
	stx VMADDL
	lda #$80
	sta VMAIN
	dma0trans EmptyVRAM, VMDATAL, $1E00, #0
	rts

init_vars:
	rts

h_nmi:
	bit RDNMI
	inc in_nmi
	jmp _rti

_rti:
	rti
