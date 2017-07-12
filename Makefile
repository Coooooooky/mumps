#
#  This file is part of MUMPS 5.1.1, released
#  on Mon Mar 20 14:34:33 UTC 2017
#
topdir = .
libdir = $(topdir)/lib
LIBEXT=.a

default:	dexamples

.PHONY: default alllib all c z s d \
	sexamples dexamples cexamples zexamples multi_example \
	mumps_lib requiredobj libseqneeded clean

alllib:		c z s d
all:		cexamples zexamples sexamples dexamples multi_example

c:
	$(MAKE) ARITH=c mumps_lib
z:
	$(MAKE) ARITH=z mumps_lib
s:
	$(MAKE) ARITH=s mumps_lib
d:
	$(MAKE) ARITH=d mumps_lib


# Is Makefile.inc available ?
Makefile.inc:

include Makefile.inc

mumps_lib: requiredobj
	$(MAKE) -C src $(ARITH)

cexamples:	c
#	(cd examples ; $(MAKE) c)

zexamples:	z
#	(cd examples ; $(MAKE) z)

sexamples:	s
#	(cd examples ; $(MAKE) s)

dexamples:	d
#	(cd examples ; $(MAKE) d)

multi_example:	s d c z
#	(cd examples ; $(MAKE) multi)

requiredobj: Makefile.inc $(LIBSEQNEEDED) $(libdir)/libpord$(PLAT)$(LIBEXT)

# dummy MPI library (sequential version)

libseqneeded:
	$(MAKE) -C libseq

# Build the libpord.a library and copy it into $(topdir)/lib
$(libdir)/libpord$(PLAT)$(LIBEXT):
ifdef LPORDDIR
	  $(MAKE) -C $(LPORDDIR) CFLAGS="$(OPTC)"
	  cp $(LPORDDIR)/libpord$(LIBEXT) $@
endif

clean:
	$(MAKE) -C src clean
#	$(MAKE) -C examples clean
	$(RM) $(libdir)/*$(PLAT)$(LIBEXT)
	$(MAKE) -C libseq clean
ifdef LPORDDIR
	  $(MAKE) -C $(LPORDDIR) realclean
endif

