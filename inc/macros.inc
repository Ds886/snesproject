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
