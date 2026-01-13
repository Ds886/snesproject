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

;.macro  dma0trans   p_addr_src p_addr_dest p_size p_tmode
.macro  dma0trans p_addr_src, p_addr_dest, p_size, p_tmode
	lda p_tmode
	sta DMAP0
	lda #p_addr_dest
	sta BBAD0
	ldx #.loword(p_addr_src)
	stx A1T0L
	lda #^p_addr_src
	sta A1B0
	ldx #p_size
	stx DAS0L
	lda #1
	sta MDMAEN
.endmacro

.macro load_tile p_tile_name
	setAXY16
	; load color pallate
	dma0trans  .ident(.concat(.string(p_tile_name), "_ColorData")), CGDATA, .ident(.concat(.string(p_tile_name), "_ColorData_size")), 1
	;  load char
	lda #$80 ; the value $80
	sta VMAIN  ; $2115 = set the increment mode +1
	ldx #$0000
	stx VMADDL ; $2116 set an address in the vram of $0000
	dma0trans .ident(.concat(.string(p_tile_name), "_CharData")), VMDATAL, .ident(.concat(.string(p_tile_name), "_CharData_size")), #1
	; load map
	ldx #$6000
	stx VMADDL ; $2116 set an address in the vram of $6000
	dma0trans .ident(.concat(.string(p_tile_name), "_TileData")), VMDATAL, .ident(.concat(.string(p_tile_name), "_TileData_size")), #1
.endmacro
