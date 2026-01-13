.p816
.smart

.include "macros.inc"
.include "registers.inc"

.include "header.asm"

.segment "ZEROPAGE"
in_nmi: .res 2

.segment "CODE1"
CharData: .incbin "../res/moon/moon.chr"
CharData_end:
CharData_size = CharData_end - CharData
EmptyVRAM:
	.res 256, 0    ; 256 bytes of zeros used for the VRAM clear
EmptyVRAM_end:

.segment "CODE2"
ColorData: .incbin "../res/moon/moon.pal"
ColorData_end:
ColorData_size = ColorData_end - ColorData

TileData: .incbin "../res/moon/moon.map"
TileData_end:
TileData_size = TileData_end - TileData

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

draw:
	lda #$ff
	sta CGDATA
	lda #$ff
	sta CGDATA
	lda #$0f
	sta INIDISP
	rts


init_gfx:
	sep #$20
	lda #$80
	sta INIDISP
	setAXY16
init_gfx_cg:
	; dma0trans #$00, ColorData, #$22, #ColorData_size, #1
	dma0trans  ColorData, CGDATA, ColorData_size, 1 
init_gfx_tiles:
	lda #$80 ; the value $80
	sta VMAIN  ; $2115 = set the increment mode +1
	ldx #$0000
	stx VMADDL ; $2116 set an address in the vram of $0000
	dma0trans CharData, VMDATAL, CharData_size, #1
init_gfx_map:
	ldx #$6000
	stx VMADDL ; $2116 set an address in the vram of $6000

	dma0trans TileData, VMDATAL, TileData_size, #1

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
