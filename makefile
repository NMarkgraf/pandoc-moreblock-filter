# ######################################################################################
# Makefile (C) in 2015 by Norman Markgraf
# ========
# Version 1.0 	nm (09. Okt. 2015) 	First Release
MAKEFILEVERSION=1.6
#
# ######################################################################################

# --------------------------------------------------------------------------------------
#  Setup local variables
#
ifeq ($(OS), Windows_NT)
	GHC=ghc.exe
else
	GHC=ghc
endif

# --------------------------------------------------------------------------------------
#
#
moreblocks-unix:
	@echo "we are making a non-windows(tm) version"
ifneq ($(OS), Windows_NT)
	$(GHC) --make moreblocks
endif

# --------------------------------------------------------------------------------------
#
#
moreblocks-win:
	@echo "we are making a windows(tm) version"
ifeq ($(OS), Windows_NT)
	$(GHC) --make moreblocks -o moreblocks-win
endif


# --------------------------------------------------------------------------------------
#
#
moreblocks: moreblocks-unix moreblocks-win

# --------------------------------------------------------------------------------------
#
#
.PHONY: clean 

clean:
	-rm -rf moreblocks.hi moreblocks.o

# --------------------------------------------------------------------------------------
#
#
propper: clean
ifeq ($(OS), Windows_NT)
	-rm -rf moreblocks-win.exe
else
	-rm -rf moreblocks
endif

all: moreblocks moreblocks-win

info: 
	@echo "########################################################################"
	@echo ""
	@echo "Makefile (C) in 2015 by Norman Markgraf"
	@echo "========-------------------------------"
	@echo "Version: $(MAKEFILEVERSION)"
	@echo ""
	@echo "************************************************************************"
