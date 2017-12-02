# This makefile makes an executable from each asm file in a folder

AS       = yasm
ASFLAGS  = -g dwarf2 -f elf64
CXX      = g++
CXXFLAGS = -g -Wall
LD       = ld
LDFLAGS  = -g

BUILDDIR = build

all:example1 example2


example1:main_asm.o stats.o
	$(LD) $(LDFLAGS) -o $(BUILDDIR)/$@ $(addprefix $(BUILDDIR)/, $?)

# linking with g++ avoids warning about not finding _start
# and segmentation fault at exit
example2:main_cpp.o stats.o
	$(CXX) -o $(BUILDDIR)/$@ $(addprefix $(BUILDDIR)/, $?)


%.o:%.asm
	mkdir -p $(BUILDDIR)
	$(AS) $(ASFLAGS) $< -o $(BUILDDIR)/$@ -l $(BUILDDIR)/$@.lst


%.o:%.cpp
	mkdir -p $(BUILDDIR)
	$(CXX) $(CXXFLAGS) -c $< -o $(BUILDDIR)/$@


clean:
	rm -rf *.o *.lst $(TARGETS) $(BUILDDIR)

# the empty line at the end is needed
define run-test
$(1)

endef

test:example1 example2
	$(foreach test, $?, $(call run-test,./$(BUILDDIR)/$(test)))
