ACLOCAL_AMFLAGS = -I m4 ${ACLOCAL_FLAGS}

# Distribution
# ------------
EXTRA_DIST =
BUILT_SOURCES =
CLEANFILES =
DISTCLEANFILES =
MAINTAINERCLEANFILES = \
	$(GITIGNORE_MAINTAINERCLEANFILES_TOPLEVEL) \
	$(GITIGNORE_MAINTAINERCLEANFILES_M4_LIBTOOL) \
	$(GITIGNORE_MAINTAINERCLEANFILES_MAKEFILE_IN) \
	$(srcdir)/ChangeLog \
	$(srcdir)/INSTALL

# We're running CI in docker, which reports host architecture as host,
# not the docker image architecture as we expected, so specifying the
# host/build information is necessary here.
DISTCHECK_CONFIGURE_FLAGS = \
	--host=$(host) \
	--build=$(build) \
	--disable-dependency-tracking \
	--disable-maintainer-mode
if WITH_STAGE_2
DISTCHECK_CONFIGURE_FLAGS += \
	--with-stage=2
endif

GITIGNOREFILES = \
	build \
	debian \
	$(DIST_ARCHIVES)

# Common/global flags
# -------------------
AM_CPPFLAGS = \
	-include config.h \
	-Iinclude \
	-I$(top_srcdir)/include \
	-DLOCALSTATEDIR=\"$(localstatedir)\" \
	-DRUNSTATEDIR=\"$(runstatedir)\" \
	-DSYSCONFDIR=\"$(sysconfdir)\" \
	-DNDEBUG

AM_CFLAGS = \
	-Wall -Werror \
	-Wa,--noexecstack \
	-std=gnu11

AM_CXXFLAGS = \
	-Wall -Werror \
	-Wa,--noexecstack \
	-std=gnu++11

AM_LDFLAGS = \
	-Wl,-z,noexecstack \
	-Wl,--as-needed

libtool_opts = \
	-version-info $(LT_VERSION_INFO) \
	-export-dynamic \
	-rpath $(libdir)

TESTS =
bin_SCRIPTS =
bin_PROGRAMS =
sbin_PROGRAMS =
noinst_PROGRAMS =
check_LTLIBRARIES =
check_PROGRAMS =
lib_LTLIBRARIES =
pkgconfig_DATA =

include $(srcdir)/gtest.mk
include $(srcdir)/include/Makefile.am

# Installable libraries
# ---------------------
# Note: the order how the participatiing libraries are listed here is
# IMPORTANT!!! It has to follow the dependencies between each of them, or you
# will get errors like:
#
#  libtool: install: warning: relinking `libandroid-cutils-0.la'
#  libtool: install: <omited long long line>
#  /usr/bin/ld: cannot find -landroid-log-0
#  collect2: error: ld returned 1 exit status
#  libtool: install: error: relink `libandroid-cutils-0.la' with the above command before installing it

if WITH_STAGE_1
# Stage 1-1: depends on only external packages
include $(srcdir)/liblog/Android.mk
include $(srcdir)/libmincrypt/Android.mk
include $(srcdir)/libsparse/Android.mk

# Stage 1-2: depends on any of above packages
include $(srcdir)/libcutils/Android.mk
include $(srcdir)/libion/Android.mk
include $(srcdir)/libpackagelistparser/Android.mk
include $(srcdir)/libsync/Android.mk

# Stage 1-3: depends on any of above packages
include $(srcdir)/base/Android.mk
include $(srcdir)/libdiskconfig/Android.mk
include $(srcdir)/logwrapper/Android.mk
include $(srcdir)/libnetutils/Android.mk
include $(srcdir)/libsuspend/Android.mk
include $(srcdir)/libsysutils/Android.mk
include $(srcdir)/libusbhost/Android.mk

# Stage 1-4: depends on any of above packages
include $(srcdir)/init/Android.mk
else
if WITH_STAGE_2
# Stage 2-1: depends on external packages that depend on stage 0 packages
include $(srcdir)/libbacktrace/Android.mk
include $(srcdir)/libnativebridge/Android.mk
include $(srcdir)/libnativeloader/Android.mk

# Stage 2-2: depends on any of above packages
include $(srcdir)/libutils/Android.mk

# Stage 2-3: depends on any of above packages
include $(srcdir)/libpixelflinger/Android.mk
include $(srcdir)/libprocessgroup/Android.mk
include $(srcdir)/libziparchive/Android.mk
endif # WITH_STAGE_2
endif # WITH_STAGE_1

# PKG-CONFIG data files
# ---------------------
pkgconfigdir = $(libdir)/pkgconfig
$(pkgconfig_DATA): config.status

EXTRA_DIST += $(pkgconfig_DATA:.pc=.pc.in)
DISTCLEANFILES += $(pkgconfig_DATA)

# Somehow $(bin_SCRIPTS) are not included in DIST_SOURCES by default.
EXTRA_DIST += $(bin_SCRIPTS)
CLEANFILES += $(BUILT_SOURCES)
# Running test programs may result in core dump, which fails distcleancheck.
CLEANFILES += core
GITIGNOREFILES += $(BUILT_SOURCES)

-include $(top_srcdir)/git.mk
