
AS      = yasm
ASFLAGS = -g dwarf2 -f elf64
LD      = ld
LDFLAGS = -g

example:example.o
	ld -g -o example example.o

example.o:example.asm
	yasm -g dwarf2 -f elf64 example.asm -l example.lst

clean:
	rm -r *.o *.lst example

test:example
	./example
