# Makefile for assembling and linking a 65816 project

# Tools
BIN_CA65 = ca65
BIN_LD65 = ld65

# Files
PATH_SRC = src
PATH_OUT = out
PATH_INC = inc
SRC = ${PATH_SRC}/main.asm
CFG = ${PATH_SRC}/memmap.cfg
OBJ = ${PATH_OUT}/main.o
OUT = ${PATH_OUT}/main.smc

# Rules
all: $(OUT)

$(OBJ): $(SRC)
	mkdir -p "./${PATH_OUT}"
	$(BIN_CA65)  -o $(OBJ) -I ./inc $(SRC)  --debug-info

$(OUT): $(OBJ) $(CFG)
	$(BIN_LD65) -C $(CFG) $(OBJ) -o $(OUT) --dbgfile "./${PATH_OUT}/main.dbg"

clean:
	$(RM) -r "./${PATH_OUT}"

.PHONY: all clean
