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
	setA16
	setXY8
	stz $2181 ;WRAM_ADDR_L
	stz $2182 ;WRAM_ADDR_M
	
	lda #$8008 ;fixed transfer to WRAM data 2180
	sta $4300 ; and 4301
	lda	#.loword(DMAZero)
	sta $4302 ; and 4303
	ldx #^DMAZero ;bank #
	stx $4304
	stz $4305 ;and 4306 = size 0000 = $10000
	ldx #1
	stx $420B ; DMA_ENABLE, clear the 1st half of WRAM
	stx $420B ; DMA_ENABLE, clear the 2nd half of WRAM
	
	setA8
	setXY16
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
	stx $2181 ;WRAM_ADDR_L
	stz $2183 ;WRAM_ADDR_H

	ldx #$8008 ;fixed transfer to WRAM data 2180
	stx $4300 ; and 4301
	ldx	#.loword(DMAZero)
	stx $4302 ; and 4303
	lda #^DMAZero ;bank #
	sta $4304
	ldx #$200 ;512 bytes
	stx $4305 ; and 4306
	lda #1
	sta $420B ; DMA_ENABLE start dma, channel 0
	plp
	rts
	
	
DMA_Palette:
;copies the buffer to the CGRAM
	php
	setA8
	setXY16
	stz $2121 ;Palette Address 
	ldx #$2200 ;1 reg 1 write, to PAL_DATA 2122
	stx $4300 ; and 4301
	ldx	#.loword(PAL_BUFFER)
	stx $4302 ; and 4303
	lda #^PAL_BUFFER ;bank #
	sta $4304
	ldx #$200 ;512 bytes
	stx $4305 ; and 4306
	lda #1
	sta $420B ; DMA_ENABLE start dma, channel 0
	plp
	rts

	
Clear_OAM:
;fills the buffer with 224 for low table
;and $00 for high table
	php
	setA8
	setXY16
	ldx #.loword(OAM_BUFFER) 
	stx $2181 ;WRAM_ADDR_L
	stz $2183 ;WRAM_ADDR_H
	
	ldx #$8008 ;fixed transfer to WRAM data 2180
	stx $4300
	ldx	#.loword(SpriteEmptyVal)
	stx $4302 ; and 4303
	lda #^SpriteEmptyVal ;bank #
	sta $4304
	ldx #$200 ;size 512 bytes
	stx $4305 ;and 4306
	lda #1
	sta $420B ; DMA_ENABLE start dma, channel 0

	ldx	#.loword(SpriteUpperEmpty)
	stx $4302 ; and 4303
	lda #^SpriteUpperEmpty ;bank #
	sta $4304
	ldx #$0020 ;size 32 bytes
	stx $4305 ;and 4306
	lda #1
	sta $420B ; DMA_ENABLE start dma, channel 0
	plp
	rts
	
	
DMA_OAM:
;copy from OAM BUFFER to the OAM RAM
	php
	setA16
	setXY8
	stz $2102 ;OAM address
	
	lda #$0400 ;1 reg 1 write, 2104 oam data
	sta $4300
	lda #.loword(OAM_BUFFER)
	sta $4302 ; source
	ldx #^OAM_BUFFER
	stx $4304 ; bank
	lda #544
	sta $4305 ; length
	ldx #1
	stx $420B ; DMA_ENABLE start dma, channel 0
	plp
	rts		


Clear_VRAM:
	php
	setA16
	setXY8
	ldx #$80
	stx $2115 ;VRAM increment mode +1, after the 2119 write
	stz $2116 ;VRAM Address 
	stz $4305 ; size $10000 bytes ($8000 words)
	lda #$1809 ;fixed transfer (2 reg, write once) to VRAM_DATA $2118-19
	sta $4300 ; and 4301
	lda	#.loword(DMAZero)
	sta $4302 ; and 4303
	ldx #^DMAZero ;bank #
	stx $4304
	ldx #1
	stx $420B ; DMA_ENABLE start dma, channel 0
	plp
	rts



SpriteUpperEmpty: ;my sprite code assumes hi table of zero
DMAZero:
.word $0000

SpriteEmptyVal:
.byte 224

setAXY16
