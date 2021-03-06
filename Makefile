DIRS_BLACKLIST := ./book/
SUBDIRS := $(filter-out $(DIRS_BLACKLIST), $(sort $(dir $(wildcard ./*/.))))

.PHONY: subdirs $(SUBDIRS)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ $(MAKECMDGOALS)

# test target
TESTDIRS = $(SUBDIRS:%=test-%)

test: $(TESTDIRS)
$(TESTDIRS): 
	$(MAKE) -C $(@:test-%=%) test

.PHONY: subdirs $(TESTDIRS)
.PHONY: test

# clean target
CLEANDIRS = $(SUBDIRS:%=clean-%)

clean: $(CLEANDIRS)
$(CLEANDIRS): 
	$(MAKE) -C $(@:clean-%=%) clean

.PHONY: subdirs $(CLEANDIRS)
.PHONY: clean
