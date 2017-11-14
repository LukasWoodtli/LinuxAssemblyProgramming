# This makefile makes an executable from each asm file in a folder

AS      = yasm
ASFLAGS = -g dwarf2 -f elf64
LD      = ld
LDFLAGS = -g

SOURCES := $(wildcard *.asm)
OBJECTS := $(patsubst %.asm, %.o, $(SOURCES))
TARGETS := $(patsubst %.asm, %, $(SOURCES))

BUILDDIR = build

all: $(TARGETS)


$(TARGETS): %: %.o
	$(LD) $(LDFLAGS) -o $(BUILDDIR)/$@ $(BUILDDIR)/$^

%.o:%.asm
	mkdir -p $(BUILDDIR)
	$(AS) $(ASFLAGS) $< -o $(BUILDDIR)/$@ -l $(BUILDDIR)/$@.lst

clean:
	rm -rf *.o *.lst $(TARGETS) $(BUILDDIR)

# the empty line at the end is needed
define run-test
$(1)

endef

test:$(TARGETS)
	$(foreach test,$(filter-out $(TESTS_BLACKLIST),$(TARGETS)),$(call run-test,./$(BUILDDIR)/$(test)))
