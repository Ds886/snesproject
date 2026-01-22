.macro setA8
	sep #$20
.endmacro

.macro setA16
	rep #$20
.endmacro

.macro setAXY8
	sep #$30
.endmacro

.macro setAXY16
	rep #$30
.endmacro

.macro setXY8
	sep #$10
.endmacro

.macro setXY16
	rep #$10
.endmacro

.macro stateStash
	pha
	phx
	phy
.endmacro
.macro statePop
	ply
	plx
	pla
.endmacro

;.macro  dma_trans   p_addr_src p_addr_dest p_size p_tmode
.macro dma_trans  p_chan, p_addr_src, p_addr_dest, p_size, p_tmode, p_count
	stateStash
	setA8
	setXY16

	.local _dmaoff, _i, _reps

	_dmaoff = (p_chan * $10)
	
	.ifblank p_count
        _reps = 1
    .else
        _reps = p_count
    .endif

		lda p_tmode
		sta DMAP0+_dmaoff
		lda #<(p_addr_dest)
		sta BBAD0+_dmaoff
		ldx #.loword(p_addr_src)
		stx A1T0L+_dmaoff
		lda #^p_addr_src
		sta A1B0+_dmaoff
		ldx #p_size
		stx DAS0L+_dmaoff
	.repeat _reps, _i
		lda #(1 << p_chan)
		sta MDMAEN
	.endrepeat

	statePop
.endmacro


.proc wait_vblank
	lda HVBJOY
	bpl wait_vblank
	rts
.endproc


.macro load_tile p_tile_name
	setAXY16
	
	; load color pallate
	dma_trans  1, .ident(.concat(.string(p_tile_name), "_ColorData")), CGDATA, .ident(.concat(.string(p_tile_name), "_ColorData_size")), 1

	;  load char
	; set the increment mode +1
	lda #$80
	sta VMAIN
	; ; VMADDL($2116) set an address in the vram of $0000
	ldx #$0000
	stx VMADDL 
	dma_trans 0, .ident(.concat(.string(p_tile_name), "_CharData")), VMDATAL, .ident(.concat(.string(p_tile_name), "_CharData_size")), #1

	; load map
	; VMADDL($2116) set an address in the vram of WRAM($6000)
	ldx #$6000
	stx VMADDL 
	dma_trans 0, .ident(.concat(.string(p_tile_name), "_TileData")), VMDATAL, .ident(.concat(.string(p_tile_name), "_TileData_size")), #1
.endmacro
