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

Img1_CharData: .incbin "../out/res/img1_16.pic"
Img1_CharData_end:
Img1_CharData_size = Img1_CharData_end - Img1_CharData

Img1_ColorData: .incbin "../out/res/img1_16.pal"
Img1_ColorData_end:
Img1_ColorData_size = Img1_ColorData_end - Img1_ColorData

Img1_TileData: .incbin "../out/res/img1_16.map"
Img1_TileData_end:
Img1_TileData_size = Img1_TileData_end - Img1_TileData

Img2_CharData: .incbin "../out/res/img2_16.pic"
Img2_CharData_end:
Img2_CharData_size = Img2_CharData_end - Img2_CharData

Img2_ColorData: .incbin "../out/res/img2_16.pal"
Img2_ColorData_end:
Img2_ColorData_size = Img2_ColorData_end - Img2_ColorData

Img2_TileData: .incbin "../out/res/img2_16.map"
Img2_TileData_end:
Img2_TileData_size = Img2_TileData_end - Img2_TileData

.segment "CODE2"
Img3_CharData: .incbin "../out/res/img3_16.pic"
Img3_CharData_end:
Img3_CharData_size = Img3_CharData_end - Img3_CharData

Img3_ColorData: .incbin "../out/res/img3_16.pal"
Img3_ColorData_end:
Img3_ColorData_size = Img3_ColorData_end - Img3_ColorData

Img3_TileData: .incbin "../out/res/img3_16.map"
Img3_TileData_end:
Img3_TileData_size = Img3_TileData_end - Img3_TileData

EmptyVRAM:
	.res 256, 0    ; 256 bytes of zeros used for the VRAM clear
EmptyVRAM_end:
