read_joystick:
  stateStash

  ; Wait for Joystick
  lda HVBJOY
  and #$01
  beq read_joystick
  ; first, check for newly pressed buttons since last frame
  setA16                            ; set A to 16-bit
  lda STDCNTRL1L                      ; get new input from this frame
  ldy JOYPAD1                         ; get input from last frame
  sta JOYPAD1                         ; store new input from this frame
  tya                                 ; check for newly pressed buttons...
  eor JOYPAD1                         ; filter buttons that were not pressed last frame
  and JOYPAD1                         ; filter held buttons from last frame
  sta JOYTRIGGER1                     ; ...and store them
  ; second, check for buttons held from last frame
  tya                                 ; get input from last frame
  and JOYPAD1                         ; filter held buttons from last frame...
  sta JOYHELD1                        ; ...store them
  statePop
  rts

