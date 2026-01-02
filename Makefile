# Makefile for assembling and linking a 65816 project

# Tools
CA65 = ca65
LD65 = ld65

# Files
SRC = main.asm
OBJ = main.o
OUT = main.smc
CFG = memmap.cfg


# CPU target
CPU = 65816

# Rules
all: $(OUT)

$(OBJ): $(SRC)
	$(CA65)  -o $(OBJ) $(SRC) --debug-info

$(OUT): $(OBJ) $(CFG)
	$(LD65) -C $(CFG) $(OBJ) -o $(OUT) --dbgfile main.dbg

clean:
	rm -f $(OBJ) $(OUT)

.PHONY: all clean
