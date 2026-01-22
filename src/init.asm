; A very simple SNES init routine
; For serious use, you probably want to do more than this
; This is simple and understandable, though
; Will leave you in A8 XY16 mode

; Disable interrupts and enable native mode
sei
clc
xce
cld

setAXY16

; ZeroCPU registers NMITIMEN through MEMSEL
stz NMITIMEN
stz WRMPYA
stz WRDIVL
stz WRDIVB
stz HTIMEH
stz VTIMEH
stz HDMAEN

lda #$0080
sta INIDISP ; Turn off screen ("forced blank")

; Zero some registers used for rendering
stz OAMADDL
stz OAMADDH
stz BGMODE
stz BG1SC
stz BG3SC
stz BG12NBA
stz VMADDL
stz VMADDH
stz W12SEL
stz WH0
stz WH2
stz WBGLOG
stz TM
stz TMW

; Disable color math / etc
ldx #$0030
stx CGWSEL
ldy #$00E0
sty COLDATA

; setAXY16

; Zero window masks
stz WOBJSEL
Clear_WRAM:
	setA8
	setXY16
	jsr wait_vblank
	stz WMADDL
	stz WMADDM
	; stz WMADDH
	dma_trans 0, DMAZero, $80, $0000, #$08, 2

	jsr Clear_Palette
	jsr DMA_Palette
	jsr Clear_OAM
	jsr DMA_OAM
	jsr Clear_VRAM

;	A8
	lda #1
	sta $420d ;fastROM

	setAXY16
 jml entry_main;should jump into the $80 bank, fast ROM
	
;we are still in forced blank, main code will have to turn the screen on





;some code below adapted from code by Oziphantom

Clear_Palette:
;fills the buffer with zeros
	php
	setA8
	setXY16
	ldx #.loword(PAL_BUFFER) 
	stx WMADDL ;WRAM_ADDR_L
	stz WMADDH ;WRAM_ADDR_H
	dma_trans 0, DMAZero, WMDATA, $0200, #$08
	plp
	rts
	
	
DMA_Palette:
;copies the buffer to the CGRAM
	php
	setA8
	setXY16
	stz CGADD ;Palette Address

	dma_trans 0, PAL_BUFFER, CGDATA, $0200, #$00
	plp
	rts

	
Clear_OAM:
;fills the buffer with 224 for low table
;and $00 for high table
	php
	setA8
	setXY16

	ldx #.loword(OAM_BUFFER) 
	stx WMADDL ;2181
	stz WMADDH ;2183
	dma_trans 0, SpriteEmptyVal, WMDATA, $0200, #$08
	dma_trans 0, SpriteUpperEmpty, WMDATA, $0020, #$08

	plp
	rts
	
	
DMA_OAM:
;copy from OAM BUFFER to the OAM RAM
	php
	; needed to convince the asmbler
	OAM_BUFFER_H = OAM_BUFFER + $200
	stz OAMADDL ;2102
	stz OAMADDH ;
	dma_trans 0, OAM_BUFFER, OAMDATA, $0200, #$00
	dma_trans 0, OAM_BUFFER_H, OAMDATA, $0020, #$00
	plp
	rts		


Clear_VRAM:
	php
	; needed to convince the asmbler
	VMDATA_LO = .loword(VMDATAL)
	setA8
	setXY16
	ldx #$80
	stx VMAIN ; 2115
	stz VMADDL ; 2116
	stz VMADDH ; 2116
	dma_trans 0, DMAZero, VMDATA_LO, $8000, #$09, 2
	plp
	rts



DMAZero:
.word $0000

SpriteEmptyVal:
.byte 224
SpriteUpperEmpty:

setAXY16
