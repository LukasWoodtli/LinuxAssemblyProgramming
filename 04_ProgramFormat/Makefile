
AS      = yasm
ASFLAGS = -g dwarf2 -f elf64
LD      = ld
LDFLAGS = -g

example:example.o
	$(LD) $(LDFLAGS) -o example example.o

example.o:example.asm
	$(AS) $(ASFLAGS) example.asm -l example.lst

clean:
	rm -rf *.o *.lst example

test:example
	./example
