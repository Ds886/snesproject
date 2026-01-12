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
init_gfx_cg:
	stz CGADD ; $2121 cgram address = zero
	
	stz $4300 ; transfer mode 0 = 1 register write once
	lda #$22  ; $2122
	sta $4301 ; destination, cgram data
	ldx #.loword(ColorData)
	stx $4302 ; source
	lda #^ColorData
	sta $4304 ; bank
	ldx #32
	stx $4305 ; length
	lda #1
	sta MDMAEN ; $420b start dma, channel 0
	; stz CGADD
	; stz DMAP0
	; ; Load DMA0 Dest to be CGDATA
	; lda #$22
	; ; lda #<CGDATA
	; sta BBAD0
	; ; Store source Color data
	; ldx #.loword(ColorData)
	; stx A1T0L
	; ;store bank
	; lda #^ColorData
	; sta A1B0
	; ; store size
	; ldx ColorData_size
	; stx DAS0L
	; ; start transfer
	; lda #1
	; sta MDMAEN
init_gfx_tiles:
	lda #$80 ; the value $80
	sta VMAIN  ; $2115 = set the increment mode +1
	ldx #$0000
	stx VMADDL ; $2116 set an address in the vram of $0000
	
	lda #1
	sta $4300 ; transfer mode, 2 registers 1 write
			  ; $2118 and $2119 are a pair Low/High
	lda #$18  ; $2118
	sta $4301 ; destination, vram data
	ldx #.loword(CharData)
	stx $4302 ; source
	lda #^CharData
	sta $4304 ; bank
	ldx #(CharData_end-CharData) 
	stx $4305 ; length
	lda #1
	sta MDMAEN ; $420b start dma, channel 0
	; lda #$80
	; sta VMAIN
	; ; zero a vram addr
	; ldx #$0000
	; stx VMADDL
	; lda #$01
	; sta DMAP0
	; lda #<VMDATAL
	; sta BBAD0
	; ldx #.loword(CharData)
	; stx A1T0L
	; lda #^CharData
	; sta A1B0
	; ldx CharData_size
	; stx DAS0L
	; lda #1
	; sta MDMAEN
init_gfx_map:
	ldx #$6000
	stx VMADDL ; $2116 set an address in the vram of $6000
	
	lda #1
	sta $4300 ; transfer mode, 2 registers 1 write
			  ; $2118 and $2119 are a pair Low/High
	lda #$18  ; $2118
	sta $4301 ; destination, vram data
	ldx #.loword(TileData)
	stx $4302 ; source
	lda #^TileData
	sta $4304
	ldx #$700
	stx $4305 ; length
	lda #1
	sta MDMAEN ; $420b start dma, channel 0	
	; ldx #$6000
	; stx VMADDL

	; lda #$01
	; sta DMAP0
	; lda #<VMDATAL
	; sta BBAD0
	; ldx #.loword(TileData)
	; stx A1T0L
	; lda #^TileData
	; sta A1B0
	; ldx TileData_size
	; stx DAS0L
	; lda #1
	; sta MDMAEN
init_gfx_init_bg:
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
	stz $4300
	lda #$18
	sta $4301
	ldx #.loword(EmptyVRAM)
	stx $4302
	lda #^EmptyVRAM
	sta $4304
	ldx #$1E00
	stx $4305
	lda #1
	sta MDMAEN
init_gfx2:
	; VRAM DATA Load
	stz VMADDL
	stz VMADDH
	LDA #%00000001
	STA VMAIN        ; Increment VRAM by word


	LDA #%00000001
	STA DMAP0        ; DMA mode: VRAM write
	LDA #$18
	STA BBAD0        ; Destination: $2118 (VMDATAL)

	LDA #<CharData
	STA A1T0L
	LDA #>CharData
	STA A1T0H
	LDA #^CharData
	STA A1B0

	LDX #CharData_end - CharData
	STX DAS0L

	LDA #%00000001
	STA MDMAEN        ; Start DMA channel 0

	;====================================================
	; Load Palette (CGRAM)
	;====================================================

	LDA #$00
	STA CGADD        ; Start at color 0

	LDA #%00000010
	STA DMAP0        ; DMA mode: write twice (CGRAM write)
	LDA #$22
	STA BBAD0        ; Destination: $2122 (CGDATA)

	LDA #<ColorData
	STA A1T0L
	LDA #>ColorData
	STA A1T0H
	LDA #^ColorData
	STA A1B0

	LDX #.loword(ColorData_end - ColorData)
	STX DAS0L

	LDA #%00000001
	STA MDMAEN        ; Start DMA channel 0

	;====================================================
	; Re-enable screen
	;====================================================
	LDA #$0F          ; Brightness = max (screen on)
	STA INIDISP
	rts

; https://georgjz.github.io/snesaa04/
init_gfx1:
	; VRAM DATA Load
	stz VMADDL
	stz VMADDH
	; lda #$80
	; sta BGMODE
	LDA #%00000000
	STA $210B
	sta VMAIN
	ldx #$00
VRAMLoop:
	; bitpalne 0,2
	lda CharData, X
	sta VMDATAL
	inx
	; bitpalne 1,3
	lda CharData, X
	sta VMDATAH
	cpx # (CharData_end - CharData)
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
	cpx #.loword(ColorData_end - ColorData)
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
	inc in_nmi
	jmp _rti

_rti:
	rti
