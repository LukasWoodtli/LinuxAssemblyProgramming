

all:
	+$(MAKE) -C 04_ProgramFormat
	+$(MAKE) -C other


test:
	+$(MAKE) -C 04_ProgramFormat test
	+$(MAKE) -C other test

clean:
	+$(MAKE) -C 04_ProgramFormat clean
	+$(MAKE) -C other clean
