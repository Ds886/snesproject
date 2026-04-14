.segment "ZEROPAGE"
in_nmi: .res 2

.segment "BSS"
PAL_BUFFER: .res 512 ;palette
OAM_BUFFER: .res 512 ;low table
OAM_BUFFER2: .res 32 ;high table

.ifdef GS_IS_JOY

.ifdef GS_IS_JOY1
JOY1_UP: .res 8
JOY1_PRESS: .res 8
.endif

.ifdef GS_IS_JOY2
JOY2_UP: .res 8
JOY2_PRESS: .res 8
.endif

.ifdef GS_IS_JOY3
JOY3_UP: .res 8
JOY3_PRESS: .res 8
.endif

.ifdef GS_IS_JOY4
JOY4_UP: .res 8
JOY4_PRESS: .res 8
.endif

.endif

