
AS      = yasm
ASFLAGS = -g dwarf2 -f elf64
LD      = ld
LDFLAGS = -g

mov_double_word:mov_double_word.o
	$(LD) $(LDFLAGS) -o mov_double_word mov_double_word.o

mov_double_word.o:mov_double_word.asm
	$(AS) $(ASFLAGS) mov_double_word.asm -l mov_double_word.lst

clean:
	rm -rf *.o *.lst mov_double_word

test:mov_double_word
	./mov_double_word
