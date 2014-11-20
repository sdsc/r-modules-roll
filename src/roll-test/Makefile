REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Rules.mk

build:

install:: typical-roll-test-install
	# Additional replacement needed for this test
	perl -pi -e 's#R_MODULES#$(R_MODULES)#g;' \
	  $(ROOT)/$(PKGROOT)/*.t

clean::
