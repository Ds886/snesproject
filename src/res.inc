.segment "CODE1"
Moon_CharData: .incbin "../res/moon/moon.chr"
Moon_CharData_end:
Moon_CharData_size = Moon_CharData_end - Moon_CharData

Moon_ColorData: .incbin "../res/moon/moon.pal"
Moon_ColorData_end:
Moon_ColorData_size = Moon_ColorData_end - Moon_ColorData

Moon_TileData: .incbin "../res/moon/moon.map"
Moon_TileData_end:
Moon_TileData_size = Moon_TileData_end - Moon_TileData

Img0_CharData: .incbin "../out/res/img_16.pic"
Img0_CharData_end:
Img0_CharData_size = Img0_CharData_end - Img0_CharData

Img0_ColorData: .incbin "../out/res/img_16.pal"
Img0_ColorData_end:
Img0_ColorData_size = Img0_ColorData_end - Img0_ColorData

Img0_TileData: .incbin "../out/res/img_16.map"
Img0_TileData_end:
Img0_TileData_size = Img0_TileData_end - Img0_TileData

EmptyVRAM:
	.res 256, 0    ; 256 bytes of zeros used for the VRAM clear
EmptyVRAM_end:
