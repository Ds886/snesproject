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

sep #$20 ; setA8

; Zero window masks
stz WOBJSEL
