; SNES Registers

; Address Bus B Registers

; INIDISP - 2100
INIDISP     =   $2100   ;   Screen Display Register   single   write   any time

; Individual bits
INIDISP_FORCE_BLANK = $80  ; Force blank ON (screen off)
INIDISP_SCREEN_ON   = $00  ; Force blank OFF (screen on)

; Brightness levels
INIDISP_BRIGHT_0  = $00  ; Screen black
INIDISP_BRIGHT_1  = $01
INIDISP_BRIGHT_4  = $04
INIDISP_BRIGHT_7  = $07
INIDISP_BRIGHT_F  = $0F  ; Full brightness

; Common settings
INIDISP_OFF        = (INIDISP_FORCE_BLANK | INIDISP_BRIGHT_0)   ; $80
INIDISP_ON_FULL    = (INIDISP_SCREEN_ON   | INIDISP_BRIGHT_F)   ; $0F
INIDISP_ON_HALF    = (INIDISP_SCREEN_ON   | INIDISP_BRIGHT_7)   ; $07



OBSEL       =   $2101   ;   Object Size and Character Size Register   single   write   f-blank, v-blank
OAMADDL     =   $2102   ;   OAM Address Registers (Low)   single   write   f-blank, v-blank
OAMADDH     =   $2103   ;   OAM Address Registers (High)   single   write   f-blank, v-blank
OAMDATA     =   $2104   ;   OAM Data Write Register   single   write   f-blank, v-blank

BGMODE      =   $2105   ;   BG Mode and Character Size Register   single   write   f-blank, v-blank, h-blank


MOSAIC      =   $2106   ;   Mosaic Register   single   write   f-blank, v-blank, h-blank

; BGSC

BGSC_SIZE_32x32 = $00  ; 32×32 tiles (default)
BGSC_SIZE_64x32 = $40  ; 64×32 tiles
BGSC_SIZE_32x64 = $80  ; 32×64 tiles
BGSC_SIZE_64x64 = $C0  ; 64×64 tiles


BG1SC       =   $2107   ;   BG Tilemap Address Registers (BG1)   single   write   f-blank, v-blank
BG2SC       =   $2108   ;   BG Tilemap Address Registers (BG2)   single   write   f-blank, v-blank
BG3SC       =   $2109   ;   BG Tilemap Address Registers (BG3)   single   write   f-blank, v-blank
BG4SC       =   $210A   ;   BG Tilemap Address Registers (BG4)   single   write   f-blank, v-blank
BG12NBA     =   $210B   ;   BG Character Address Registers (BG1&2)   single   write   f-blank, v-blank
BG34NBA     =   $210C   ;   BG Character Address Registers (BG3&4)   single   write   f-blank, v-blank
BG1HOFS     =   $210D   ;   BG Scroll Registers (BG1)   dual   write   f-blank, v-blank, h-blank
BG1VOFS     =   $210E   ;   BG Scroll Registers (BG1)   dual   write   f-blank, v-blank, h-blank
BG2HOFS     =   $210F   ;   BG Scroll Registers (BG2)   dual   write   f-blank, v-blank, h-blank
BG2VOFS     =   $2110   ;   BG Scroll Registers (BG2)   dual   write   f-blank, v-blank, h-blank
BG3HOFS     =   $2111   ;   BG Scroll Registers (BG3)   dual   write   f-blank, v-blank, h-blank
BG3VOFS     =   $2112   ;   BG Scroll Registers (BG3)   dual   write   f-blank, v-blank, h-blank
BG4HOFS     =   $2113   ;   BG Scroll Registers (BG4)   dual   write   f-blank, v-blank, h-blank
BG4VOFS     =   $2114   ;   BG Scroll Registers (BG4)   dual   write   f-blank, v-blank, h-blank

; VMAIN

VMAIN_INC_AFTER_HIGH = $80 ; increment after high byte ($2119)
VMAIN_INC_AFTER_LOW  = $00 ; increment after low byte ($2118)
VMAIN_INC_1          = $00 ; increment by 1
VMAIN_INC_32         = $01 ; increment by 32 words
VMAIN_INC_128        = $02 ; increment by 128 words

VMAIN       =   $2115   ;   Video Port Control Register   single   write   f-blank, v-blank


VMADDL      =   $2116   ;   VRAM Address Registers (Low)   single   write   f-blank, v-blank
VMADDH      =   $2117   ;   VRAM Address Registers (High)   single   write   f-blank, v-blank
VMDATAL     =   $2118   ;   VRAM Data Write Registers (Low)   single   write   f-blank, v-blank
VMDATAH     =   $2119   ;   VRAM Data Write Registers (High)   single   write   f-blank, v-blank
M7SEL       =   $211A   ;   Mode 7 Settings Register   single   write   f-blank, v-blank
M7A         =   $211B   ;   Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
M7B         =   $211C   ;   Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
M7C         =   $211D   ;   Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
M7D         =   $211E   ;   Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
M7X         =   $211F   ;   Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
M7Y         =   $2120   ;   Mode 7 Matrix Registers   dual   write   f-blank, v-blank, h-blank
CGADD       =   $2121   ;   CGRAM Address Register   single   write   f-blank, v-blank, h-blank
CGDATA      =   $2122   ;   CGRAM Data Write Register   dual   write   f-blank, v-blank, h-blank
W12SEL      =   $2123   ;   Window Mask Settings Registers   single   write   f-blank, v-blank, h-blank
W34SEL      =   $2124   ;   Window Mask Settings Registers   single   write   f-blank, v-blank, h-blank
WOBJSEL     =   $2125   ;   Window Mask Settings Registers   single   write   f-blank, v-blank, h-blank
WH0         =   $2126   ;   Window Position Registers (WH0)   single   write   f-blank, v-blank, h-blank
WH1         =   $2127   ;   Window Position Registers (WH1)   single   write   f-blank, v-blank, h-blank
WH2         =   $2128   ;   Window Position Registers (WH2)   single   write   f-blank, v-blank, h-blank
WH3         =   $2129   ;   Window Position Registers (WH3)   single   write   f-blank, v-blank, h-blank
WBGLOG      =   $212A   ;   Window Mask Logic registers (BG)   single   write   f-blank, v-blank, h-blank
WOBJLOG     =   $212B   ;   Window Mask Logic registers (OBJ)   single   write   f-blank, v-blank, h-blank

; TM
TM_EN_TM_EN_BG1G1 = $01
TM_EN_TM_EN_BG1G2 = $02
TM_EN_TM_EN_BG1G3 = $04
TM_EN_TM_EN_BG1G4 = $08
TM_EN_TM_EN_BG1BJ = $10

TM          =   $212C   ;   Screen Destination Registers   single   write   f-blank, v-blank, h-blank



TS          =   $212D   ;   Screen Destination Registers   single   write   f-blank, v-blank, h-blank
TMW         =   $212E   ;   Window Mask Destination Registers   single   write   f-blank, v-blank, h-blank
TSW         =   $212F   ;   Window Mask Destination Registers   single   write   f-blank, v-blank, h-blank

; CGWSEL
CGWSEL_MODE_MAIN_BLACK        = $00  ; Never - main screen normal
CGWSEL_MODE_MAIN_OUTSIDE      = $40  ; Outside window only  
CGWSEL_MODE_MAIN_INSIDE       = $80  ; Inside window only
CGWSEL_MODE_MAIN_ALWAYS       = $C0  ; Always

; Subscreen color math enable  
CGWSEL_MODE_SUB_BLACK         = $00  ; Never - subscreen normal
CGWSEL_MODE_SUB_OUTSIDE       = $10  ; Outside window only
CGWSEL_MODE_SUB_INSIDE        = $20  ; Inside window only  
CGWSEL_MODE_SUB_ALWAYS        = $30  ; Always

; Color math clip mode
CGWSEL_MODE_CLIP_NEVER        = $00  ; Never clip colors
CGWSEL_MODE_CLIP_OUTSIDE      = $04  ; Clip outside window
CGWSEL_MODE_CLIP_INSIDE       = $08  ; Clip inside window
CGWSEL_MODE_CLIP_ALWAYS       = $0C  ; Always clip colors



; BGMODE


BGMODE_MODE0_4BG_8_8 = $00  ; 4 BGs, 8x8 tiles
BGMODE_MODE1_2BG_TEXT = $01  ; 2 BGs + optional 3rd text layer (most common)
BGMODE_MODE2_2BG_TILEOFF = $02  ; 2 BGs with offset-per-tile
BGMODE_MODE3_2BG_8BPP = $03  ; 2 BGs, 4/256-color
BGMODE_MODE4_2BG_8BPP_MIXED = $04  ; 2 BGs, 4/256-color, different interleave
BGMODE_MODE5_2BG_HIRES = $05  ; 2 BGs, hires (512px)
BGMODE_MODE6_1BG_ = $06  ; 1 BG, hires (512px)
BGMODE_MODE7 = $07  ; Mode 7 affine background

BGMODE_BG1_8x8 = $00
BGMODE_BG1_16x16 = $10
BGMODE_BG2_8x8 = $00
BGMODE_BG2_16x16 = $20




; Prevent color math
CGWSEL_MODE_PREVENT_NEVER     = $00  ; Never prevent color math
CGWSEL_MODE_PREVENT_BLACK     = $02  ; Prevent math, show black
CGWSEL_MODE_PREVENT_SUBSCREEN = $03  ; Prevent math, show subscreen

CGWSEL      =   $2130   ;   Color Math Registers   single   write   f-blank, v-blank, h-blank


CGADSUB     =   $2131   ;   Color Math Registers   single   write   f-blank, v-blank, h-blank

; COLDATA

; Color enable bits
COLDATA_BLUE_EN          = $80  ; Enable blue component
COLDATA_GREEN_EN         = $40  ; Enable green component
COLDATA_RED_EN           = $20  ; Enable red component

; Common color values
COLDATA_BLACK            = $00  ; Black color
COLDATA_WHITE            = $FF  ; White (all components max)

COLDATA     =   $2132   ;   Color Math Registers   single   write   f-blank, v-blank, h-blank


SETINI      =   $2133   ;   Screen Mode Select Register   single   write   f-blank, v-blank, h-blank
MPYL        =   $2134   ;   Multiplication Result Registers   single   read   f-blank, v-blank, h-blank
MPYM        =   $2135   ;   Multiplication Result Registers   single   read   f-blank, v-blank, h-blank
MPYH        =   $2136   ;   Multiplication Result Registers   single   read   f-blank, v-blank, h-blank
SLHV        =   $2137   ;   Software Latch Register   single      any time
OAMDATAREAD =   $2138   ;   OAM Data Read Register   dual   read   f-blank, v-blank
VMDATALREAD =   $2139   ;   VRAM Data Read Register (Low)   single   read   f-blank, v-blank
VMDATAHREAD =   $213A   ;   VRAM Data Read Register (High)   single   read   f-blank, v-blank
CGDATAREAD  =   $213B   ;   CGRAM Data Read Register   dual   read   f-blank, v-blank
OPHCT       =   $213C   ;   Scanline Location Registers (Horizontal)   dual   read   any time
OPVCT       =   $213D   ;   Scanline Location Registers (Vertical)   dual   read   any time
STAT77      =   $213E   ;   PPU Status Register   single   read   any time
STAT78      =   $213F   ;   PPU Status Register   single   read   any time
APUIO0      =   $2140   ;   APU IO Registers   single   both   any time
APUIO1      =   $2141   ;   APU IO Registers   single   both   any time
APUIO2      =   $2142   ;   APU IO Registers   single   both   any time
APUIO3      =   $2143   ;   APU IO Registers   single   both   any time
WMDATA      =   $2180   ;   WRAM Data Register   single   both   any time
WMADDL      =   $2181   ;   WRAM Address Registers   single   write   any time
WMADDM      =   $2182   ;   WRAM Address Registers   single   write   any time
WMADDH      =   $2183   ;   WRAM Address Registers   single   write   any time


; Old Style Joypad Registers

JOYSER0     =   $4016   ;   Old Style Joypad Registers   single (write)   read/write   any time that is not auto-joypad
JOYSER1     =   $4017   ;   Old Style Joypad Registers   many (read)   read   any time that is not auto-joypad


; Internal CPU Registers

; NMITIMN

NMITIMEN_DISABLE       = $00  ; All interrupts off

; Individual bits
NMITIMEN_VBLANK_ON     = $80  ; Enable NMI on VBlank
NMITIMEN_JOYPAD_ON     = $40  ; Enable automatic joypad read at VBlank
NMITIMEN_HIRQ_ON       = $10  ; Enable H- Count IRQ
NMITIMEN_VIRQ_ON       = $20  ; Enable V- Count IRQ

NMITIMEN    =   $4200   ;   Interrupt Enable Register   single   write   any time


WRIO        =   $4201   ;   IO Port Write Register   single   write   any time
WRMPYA      =   $4202   ;   Multiplicand Registers   single   write   any time
WRMPYB      =   $4203   ;   Multiplicand Registers   single   write   any time
WRDIVL      =   $4204   ;   Divisor & Dividend Registers   single   write   any time
WRDIVH      =   $4205   ;   Divisor & Dividend Registers   single   write   any time
WRDIVB      =   $4206   ;   Divisor & Dividend Registers   single   write   any time
HTIMEL      =   $4207   ;   IRQ Timer Registers (Horizontal - Low)   single   write   any time
HTIMEH      =   $4208   ;   IRQ Timer Registers (Horizontal - High)   single   write   any time
VTIMEL      =   $4209   ;   IRQ Timer Registers (Vertical - Low)   single   write   any time
VTIMEH      =   $420A   ;   IRQ Timer Registers (Vertical - High)   single   write   any time
MDMAEN      =   $420B   ;   DMA Enable Register   single   write   any time
HDMAEN      =   $420C   ;   HDMA Enable Register   single   write   any time

; MEMSEL - rom memory type (fast / slow)
MEMSEL      =   $420D   ;   ROM Speed Register   single   write   any time
MEMSEL_SLOW           = $00  ; $00 - Slow ROM access (2.68MHz)
MEMSEL_FAST           = $01  ; $01 - Fast ROM access (3.58MHz)


RDNMI       =   $4210   ;   Interrupt Flag Registers   single   read   any time
TIMEUP      =   $4211   ;   Interrupt Flag Registers   single   read   any time
HVBJOY      =   $4212   ;   PPU Status Register   single   read   any time
RDIO        =   $4213   ;   IO Port Read Register   single   read   any time
RDDIVL      =   $4214   ;   Multiplication Or Divide Result Registers (Low)   single   read   any time
RDDIVH      =   $4215   ;   Multiplication Or Divide Result Registers (High)   single   read   any time
RDMPYL      =   $4216   ;   Multiplication Or Divide Result Registers (Low)   single   read   any time
RDMPYH      =   $4217   ;   Multiplication Or Divide Result Registers (High)   single   read   any time
JOY1L       =   $4218   ;   Controller Port Data Registers (Pad 1 - Low)   single   read   any time that is not auto-joypad
JOY1H       =   $4219   ;   Controller Port Data Registers (Pad 1 - High)   single   read   any time that is not auto-joypad
JOY2L       =   $421A   ;   Controller Port Data Registers (Pad 2 - Low)   single   read   any time that is not auto-joypad
JOY2H       =   $421B   ;   Controller Port Data Registers (Pad 2 - High)   single   read   any time that is not auto-joypad
JOY3L       =   $421C   ;   Controller Port Data Registers (Pad 3 - Low)   single   read   any time that is not auto-joypad
JOY3H       =   $421D   ;   Controller Port Data Registers (Pad 3 - High)   single   read   any time that is not auto-joypad
JOY4L       =   $421E   ;   Controller Port Data Registers (Pad 4 - Low)   single   read   any time that is not auto-joypad
JOY4H       =   $421F   ;   Controller Port Data Registers (Pad 4 - High)   single   read   any time that is not auto-joypad


; DMA/HDMA Registers

; DMA modes
; Transfer modes
DMA_MODE_1REG_1WRITE     = $00  ; 1 register, write once
DMA_MODE_2REG_1WRITE     = $01  ; 2 registers, write once  
DMA_MODE_1REG_2WRITE     = $02  ; 1 register, write twice
DMA_MODE_2REG_2WRITE     = $03  ; 2 registers, write twice
DMA_MODE_4REG_1WRITE     = $04  ; 4 registers, write once

; Transfer direction
DMA_MODE_TO_PPU          = $00  ; CPU -> PPU (normal)
DMA_MODE_FROM_PPU        = $80  ; PPU -> CPU (read from PPU)

; Address increment
DMA_MODE_INCREMENT       = $00  ; Normal increment
DMA_MODE_DECREMENT       = $10  ; Decrement address
DMA_MODE_FIXED           = $08  ; Fixed address (no increment)

; Common modes
DMA_MODE_PALETTE = (DMA_MODE_1REG_1WRITE | DMA_MODE_TO_PPU | DMA_MODE_FIXED)
DMA_MODE_SPRITE = (DMA_MODE_1REG_1WRITE | DMA_MODE_TO_PPU | DMA_MODE_FIXED)
DMA_MODE_TO_OAM = (DMA_MODE_1REG_1WRITE | DMA_MODE_TO_PPU | DMA_MODE_INCREMENT)
DMA_MODE_TO_VRAM_2REG = (DMA_MODE_2REG_1WRITE | DMA_MODE_TO_PPU | DMA_MODE_FIXED)
DMA_MODE_TO_WRAM_1REG = (DMA_MODE_1REG_1WRITE | DMA_MODE_TO_PPU | DMA_MODE_FIXED)
DMA_MODE_TO_CGRAM = (DMA_MODE_1REG_1WRITE | DMA_MODE_TO_PPU | DMA_MODE_INCREMENT)

DMAP0       =   $4300   ;   (H)DMA Control Register
BBAD0       =   $4301   ;   (H)DMA Destination Register
A1T0L       =   $4302   ;   (H)DMA Source Address Registers
A1T0H       =   $4303   ;   (H)DMA Source Address Registers
A1B0        =   $4304   ;   (H)DMA Source Address Registers
DAS0L       =   $4305   ;   (H)DMA Size Registers (Low)
DAS0H       =   $4306   ;   (H)DMA Size Registers (High)
DASB0       =   $4307   ;   HDMA Indirect Address Registers
A2A0L       =   $4308   ;   HDMA Mid Frame Table Address Registers (Low)
A2A0H       =   $4309   ;   HDMA Mid Frame Table Address Registers (High)
NTLR0       =   $430A   ;   HDMA Line Counter Register

DMAP1       =   $4310   ;   (H)DMA Control Register
BBAD1       =   $4311   ;   (H)DMA Destination Register
A1T1L       =   $4312   ;   (H)DMA Source Address Registers
A1T1H       =   $4313   ;   (H)DMA Source Address Registers
A1B1        =   $4314   ;   (H)DMA Source Address Registers
DAS1L       =   $4315   ;   (H)DMA Size Registers (Low)
DAS1H       =   $4316   ;   (H)DMA Size Registers (High)
DASB1       =   $4317   ;   HDMA Indirect Address Registers
A2A1L       =   $4318   ;   HDMA Mid Frame Table Address Registers (Low)
A2A1H       =   $4319   ;   HDMA Mid Frame Table Address Registers (High)
NTLR1       =   $431A   ;   HDMA Line Counter Register

DMAP2       =   $4320   ;   (H)DMA Control Register
BBAD2       =   $4321   ;   (H)DMA Destination Register
A1T2L       =   $4322   ;   (H)DMA Source Address Registers
A1T2H       =   $4323   ;   (H)DMA Source Address Registers
A1B2        =   $4324   ;   (H)DMA Source Address Registers
DAS2L       =   $4325   ;   (H)DMA Size Registers (Low)
DAS2H       =   $4326   ;   (H)DMA Size Registers (High)
DASB2       =   $4327   ;   HDMA Indirect Address Registers
A2A2L       =   $4328   ;   HDMA Mid Frame Table Address Registers (Low)
A2A2H       =   $4329   ;   HDMA Mid Frame Table Address Registers (High)
NTLR2       =   $432A   ;   HDMA Line Counter Register

DMAP3       =   $4330   ;   (H)DMA Control Register
BBAD3       =   $4331   ;   (H)DMA Destination Register
A1T3L       =   $4332   ;   (H)DMA Source Address Registers
A1T3H       =   $4333   ;   (H)DMA Source Address Registers
A1B3        =   $4334   ;   (H)DMA Source Address Registers
DAS3L       =   $4335   ;   (H)DMA Size Registers (Low)
DAS3H       =   $4336   ;   (H)DMA Size Registers (High)
DASB3       =   $4337   ;   HDMA Indirect Address Registers
A2A3L       =   $4338   ;   HDMA Mid Frame Table Address Registers (Low)
A2A3H       =   $4339   ;   HDMA Mid Frame Table Address Registers (High)
NTLR3       =   $433A   ;   HDMA Line Counter Register

DMAP4       =   $4340   ;   (H)DMA Control Register
BBAD4       =   $4341   ;   (H)DMA Destination Register
A1T4L       =   $4342   ;   (H)DMA Source Address Registers
A1T4H       =   $4343   ;   (H)DMA Source Address Registers
A1B4        =   $4344   ;   (H)DMA Source Address Registers
DAS4L       =   $4345   ;   (H)DMA Size Registers (Low)
DAS4H       =   $4346   ;   (H)DMA Size Registers (High)
DASB4       =   $4347   ;   HDMA Indirect Address Registers
A2A4L       =   $4348   ;   HDMA Mid Frame Table Address Registers (Low)
A2A4H       =   $4349   ;   HDMA Mid Frame Table Address Registers (High)
NTLR4       =   $434A   ;   HDMA Line Counter Register

DMAP5       =   $4350   ;   (H)DMA Control Register
BBAD5       =   $4351   ;   (H)DMA Destination Register
A1T5L       =   $4352   ;   (H)DMA Source Address Registers
A1T5H       =   $4353   ;   (H)DMA Source Address Registers
A1B5        =   $4354   ;   (H)DMA Source Address Registers
DAS5L       =   $4355   ;   (H)DMA Size Registers (Low)
DAS5H       =   $4356   ;   (H)DMA Size Registers (High)
DASB5       =   $4357   ;   HDMA Indirect Address Registers
A2A5L       =   $4358   ;   HDMA Mid Frame Table Address Registers (Low)
A2A5H       =   $4359   ;   HDMA Mid Frame Table Address Registers (High)
NTLR5       =   $435A   ;   HDMA Line Counter Register

DMAP6       =   $4360   ;   (H)DMA Control Register
BBAD6       =   $4361   ;   (H)DMA Destination Register
A1T6L       =   $4362   ;   (H)DMA Source Address Registers
A1T6H       =   $4363   ;   (H)DMA Source Address Registers
A1B6        =   $4364   ;   (H)DMA Source Address Registers
DAS6L       =   $4365   ;   (H)DMA Size Registers (Low)
DAS6H       =   $4366   ;   (H)DMA Size Registers (High)
DASB6       =   $4367   ;   HDMA Indirect Address Registers
A2A6L       =   $4368   ;   HDMA Mid Frame Table Address Registers (Low)
A2A6H       =   $4369   ;   HDMA Mid Frame Table Address Registers (High)
NTLR6       =   $436A   ;   HDMA Line Counter Register

DMAP7       =   $4370   ;   (H)DMA Control Register
BBAD7       =   $4371   ;   (H)DMA Destination Register
A1T7L       =   $4372   ;   (H)DMA Source Address Registers
A1T7H       =   $4373   ;   (H)DMA Source Address Registers
A1B7        =   $4374   ;   (H)DMA Source Address Registers
DAS7L       =   $4375   ;   (H)DMA Size Registers (Low)
DAS7H       =   $4376   ;   (H)DMA Size Registers (High)
DASB7       =   $4377   ;   HDMA Indirect Address Registers
A2A7L       =   $4378   ;   HDMA Mid Frame Table Address Registers (Low)
A2A7H       =   $4379   ;   HDMA Mid Frame Table Address Registers (High)
NTLR7       =   $437A   ;   HDMA Line Counter Register
