# Makefile for assembling and linking a 65816 project

# Tools
CA65 = ca65
LD65 = ld65

# Files
SRC_PREFIX = src
OUT_PREFIX = out
PATH_INC = inc
SRC = ${SRC_PREFIX}/main.asm
OBJ = ${OUT_PREFIX}/main.o
OUT = ${OUT_PREFIX}/main.smc
CFG = ${SRC_PREFIX}/memmap.cfg


# CPU target
CPU = 65816

# Rules
all: $(OUT)

$(OBJ): $(SRC)
	mkdir -p "./${OUT_PREFIX}"
	$(CA65)  -o $(OBJ) -I ./inc $(SRC)  --debug-info

$(OUT): $(OBJ) $(CFG)
	$(LD65) -C $(CFG) $(OBJ) -o $(OUT) --dbgfile "./${OUT_PREFIX}/main.dbg"

clean:
	$(RM) -r "./${OUT_PREFIX}"

.PHONY: all clean
