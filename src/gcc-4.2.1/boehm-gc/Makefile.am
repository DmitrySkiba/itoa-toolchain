## Process this file with automake to produce Makefile.in.

## FIXME: `make dist' in this directory will not currently work.  Many
## files that should be in the distribution are not mentioned in this
## Makefile.am.

AUTOMAKE_OPTIONS = cygnus subdir-objects
ACLOCAL_AMFLAGS = -I .. -I ../config

SUBDIRS = include

noinst_LTLIBRARIES = libgcjgc.la libgcjgc_convenience.la

if POWERPC_DARWIN
asm_libgcjgc_sources = powerpc_darwin_mach_dep.s
else
asm_libgcjgc_sources = 
endif

libgcjgc_la_SOURCES = allchblk.c alloc.c blacklst.c checksums.c dbg_mlc.c \
dyn_load.c finalize.c gc_dlopen.c gcj_mlc.c headers.c \
malloc.c mallocx.c mark.c mark_rts.c misc.c new_hblk.c \
obj_map.c os_dep.c pcr_interface.c ptr_chck.c real_malloc.c reclaim.c \
specific.c stubborn.c typd_mlc.c \
backgraph.c win32_threads.c \
pthread_support.c pthread_stop_world.c darwin_stop_world.c \
$(asm_libgcjgc_sources)

libgcjgc_convenience_la_SOURCES = $(libgcjgc_la_SOURCES)

EXTRA_DIST = alpha_mach_dep.S \
mips_sgi_mach_dep.s mips_ultrix_mach_dep.s powerpc_darwin_mach_dep.s \
rs6000_mach_dep.s sparc_mach_dep.S sparc_netbsd_mach_dep.s \
sparc_sunos4_mach_dep.s ia64_save_regs_in_stack.s

extra_ldflags_libgc = @extra_ldflags_libgc@

# Include THREADLIBS here to ensure that the correct versions of
# linuxthread semaphore functions get linked:
libgcjgc_la_LIBADD = @addobjs@ $(THREADLIBS) $(UNWINDLIBS)
libgcjgc_la_DEPENDENCIES = @addobjs@
libgcjgc_la_LDFLAGS = $(extra_ldflags_libgc) -version-info 1:2:0 -rpath $(toolexeclibdir)

libgcjgc_convenience_la_LIBADD = @addobjs@
libgcjgc_convenience_la_DEPENDENCIES = @addobjs@

AM_CXXFLAGS = @GC_CFLAGS@
AM_CFLAGS = @GC_CFLAGS@

check_PROGRAMS = gctest
gctest_SOURCES = tests/test.c
gctest_LDADD = ./libgcjgc.la $(THREADLIBS) $(UNWINDLIBS) $(EXTRA_TEST_LIBS)
gctest_LDFLAGS = -shared-libgcc
TESTS_ENVIRONMENT = LD_LIBRARY_PATH=../../$(MULTIBUILDTOP)gcc
TESTS = gctest

## FIXME: we shouldn't have to do this, but automake forces us to.
.s.lo:
## We use -Wp,-P to strip #line directives.  Irix `as' chokes on
## these.
	$(LTCOMPILE) -Wp,-P -x assembler-with-cpp -c $<
.S.lo:
	$(LTCOMPILE) -Wp,-P -x assembler-with-cpp -c $<

## We have our own definition of LTCOMPILE because we want to use our
## CFLAGS, not those passed in from the top level make.
LTCOMPILE = $(LIBTOOL) --mode=compile $(CC) $(DEFS) $(AM_CPPFLAGS) $(CPPFLAGS) \
	$(AM_CFLAGS) $(MY_CFLAGS) $(GC_CFLAGS) 
LINK = $(LIBTOOL) --mode=link $(CC) $(AM_CFLAGS) $(MY_CFLAGS) $(LDFLAGS) -o $@

# Work around what appears to be a GNU make bug handling MAKEFLAGS
# values defined in terms of make variables, as is the case for CC and
# friends when we are called from the top level Makefile.
AM_MAKEFLAGS = \
	"AR_FLAGS=$(AR_FLAGS)" \
	"CC_FOR_BUILD=$(CC_FOR_BUILD)" \
	"CFLAGS=$(CFLAGS)" \
	"CXXFLAGS=$(CXXFLAGS)" \
	"CFLAGS_FOR_BUILD=$(CFLAGS_FOR_BUILD)" \
	"CFLAGS_FOR_TARGET=$(CFLAGS_FOR_TARGET)" \
	"INSTALL=$(INSTALL)" \
	"INSTALL_DATA=$(INSTALL_DATA)" \
	"INSTALL_PROGRAM=$(INSTALL_PROGRAM)" \
	"INSTALL_SCRIPT=$(INSTALL_SCRIPT)" \
	"LDFLAGS=$(LDFLAGS)" \
	"LIBCFLAGS=$(LIBCFLAGS)" \
	"LIBCFLAGS_FOR_TARGET=$(LIBCFLAGS_FOR_TARGET)" \
	"MAKE=$(MAKE)" \
	"MAKEINFO=$(MAKEINFO) $(MAKEINFOFLAGS)" \
	"PICFLAG=$(PICFLAG)" \
	"PICFLAG_FOR_TARGET=$(PICFLAG_FOR_TARGET)" \
	"SHELL=$(SHELL)" \
	"EXPECT=$(EXPECT)" \
	"RUNTEST=$(RUNTEST)" \
	"RUNTESTFLAGS=$(RUNTESTFLAGS)" \
	"exec_prefix=$(exec_prefix)" \
	"infodir=$(infodir)" \
	"libdir=$(libdir)" \
	"prefix=$(prefix)" \
	"tooldir=$(tooldir)" \
	"AR=$(AR)" \
	"AS=$(AS)" \
	"CC=$(CC)" \
	"CXX=$(CXX)" \
	"LD=$(LD)" \
	"LIBCFLAGS=$(LIBCFLAGS)" \
	"NM=$(NM)" \
	"PICFLAG=$(PICFLAG)" \
	"RANLIB=$(RANLIB)" \
	"DESTDIR=$(DESTDIR)"

CONFIG_STATUS_DEPENDENCIES = $(srcdir)/configure.host

MAKEOVERRIDES=

# No install-html support yet
.PHONY: install-html
install-html:

