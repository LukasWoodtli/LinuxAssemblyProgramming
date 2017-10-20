
AS      = yasm
ASFLAGS = -g dwarf2 -f elf64
LD      = ld
LDFLAGS = -g

SOURCES := $(wildcard *.asm)
OBJECTS := $(patsubst %.asm, %.o, $(SOURCES))
TARGETS := $(patsubst %.asm, %, $(SOURCES))


all: $(TARGETS)

$(TARGETS): %: %.o
	$(LD) $(LDFLAGS) -o $@ $^

%.o:%.asm
	$(AS) $(ASFLAGS) $< -l $@.lst

clean:
	rm -rf *.o *.lst $(TARGETS)

# the empty line at the end is needed
define run-test
$(1)

endef

test:$(TARGETS)
	$(foreach test,$(TARGETS),$(call run-test,./$(test)))
