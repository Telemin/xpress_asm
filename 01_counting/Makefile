TARGET=16f18855
ASM=gpasm
ASMFLAGS=-c -p $(TARGET)
LD=gplink
LDFLAGS=
prgname=counting
src = $(wildcard *.asm)
obj = $(src:.asm=.o)

$(prgname).hex: $(obj)
	@$(LD)	$(LDFLAGS) -o $(prgname) $^

%.o: %.asm
	@$(ASM)	$(ASMFLAGS) -o $@ $< 

.PHONY : clean

clean :
	@rm -fv $(obj)
	@rm -fv $(prgname).hex
	@rm -fv $(prgname).lst
	@rm -fv $(prgname).cod
