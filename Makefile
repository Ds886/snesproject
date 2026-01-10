# Makefile for assembling and linking a 65816 project

PATH_TOOLS = "../tools"

# Tools
BIN_CA65 = ca65
BIN_LD65 = ld65
BIN_SUPERFAMICONV=superfamiconv

# Files
PATH_SRC = src
PATH_RES = res
PATH_OUT = out
PATH_INC = inc
SRC = ${PATH_SRC}/main.asm 
CFG = ${PATH_SRC}/memmap.cfg
OBJ = ${PATH_OUT}/main.o
OUT = ${PATH_OUT}/main.smc
RES = img_16

# Rules
all: $(OUT)


$(PATH_OUT)/%.chr $(PATH_OUT)/%.pal: $(PATH_RES)/%.png
	mkdir -p "$(PATH_OUT)"
	$(BIN_SUPERFAMICONV)  \
		-M snes \
		-i $< \
		-t $(PATH_OUT)/$*.chr \
		-p $(PATH_OUT)/$*.pal \
		-m $(PATH_OUT)/$*.map \
		-SDR
		
		

$(OBJ): $(SRC) $(RES:%=$(PATH_OUT)/%.chr) $(RES:%=$(PATH_OUT)/%.pal)
	mkdir -p "$(PATH_OUT)"
	$(BIN_CA65) -o $@ -I ./inc $(SRC) --debug-info

$(OUT): $(OBJ) $(CFG)
	$(BIN_LD65) -C $(CFG) $(OBJ) -o $(OUT) --dbgfile "./${PATH_OUT}/main.dbg"

clean:
	$(RM) -r "./${PATH_OUT}"

.PHONY: all clean magic
