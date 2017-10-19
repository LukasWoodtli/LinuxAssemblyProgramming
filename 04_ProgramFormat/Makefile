
AS      = yasm
ASFLAGS = -g dwarf2 -f elf64
LD      = ld
LDFLAGS = -g

SOURCES := $(wildcard *.asm)
OBJECTS := $(patsubst %.asm, %.o, $(SOURCES))
TARGETS := $(patsubst %.asm, %, $(SOURCES))
RUN_TARGETS := $(patsubst %, ./%, $(TARGETS))

$(warning $(TARGETS))

$(TARGETS): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o:%.asm
	$(AS) $(ASFLAGS) $< -l $@.lst

clean:
	rm -rf *.o *.lst $(TARGETS)


test:$(TARGETS)
	$(RUN_TARGETS)
