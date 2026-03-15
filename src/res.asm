.segment "CODE"
resSprites0Data:
        .incbin "../res/Sprites.vra"
resSprites0Data_end:
resSprites0Data_size = resSprites0Data_end - resSprites0Data

resSprites0Pal:
        .incbin "../res/SpriteColors.pal"
resSprites0Pal_end:
.define resSprites0Pal_size  resSprites0Pal_end - resSprites0Pal

resSprites0Table:
        .byte $80, $80, $00, $20
        .byte $80, $90, $20, $20
        .byte $7c, $90, $22, $20
resSprites0Table_end:
resSprites0Table_size  = resSprites0Table_end - resSprites0Table


resSprites1Data:
        .incbin "../res/sprite.chr"
resSprites1Data_end:
resSprites1Data_size = resSprites1Data_end - resSprites1Data


resSprites1Pal:
        .incbin "../res/default.pal"
        .incbin "../res/sprite.pal"
resSprites1Pal_end:
.define resSprites1Pal_size  resSprites1Pal_end - resSprites1Pal

resSprites1Table:
        .byte $80, $80, $00, $20
        .byte $80, $90, $20, $20
        .byte $7c, $90, $22, $20
resSprites1Table_end:
resSprites1Table_size  = resSprites1Table_end - resSprites1Table
