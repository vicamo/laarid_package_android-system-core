lib_LTLIBRARIES += \
	%reldir%/libandroid-sync.la

%canon_reldir%_libandroid_sync_la_CPPFLAGS = \
	$(AM_CPPFLAGS) \
	$(BIONIC_CFLAGS) \
	-I$(srcdir)/%reldir%/include
%canon_reldir%_libandroid_sync_la_LDFLAGS = \
	$(AM_LDFLAGS) \
	$(libtool_opts)
%canon_reldir%_libandroid_sync_la_LIBADD = \
	$(BIONIC_LIBS)
%canon_reldir%_libandroid_sync_la_SOURCES = \
	%reldir%/sw_sync.h \
	%reldir%/sync.c

%canon_reldir%_libandroid_sync_incdir = $(androidincdir)/sync
%canon_reldir%_libandroid_sync_inc_HEADERS = \
	%reldir%/include/sync/sync.h \
	%reldir%/sw_sync.h

bin_PROGRAMS += \
	%reldir%/sync_test
%canon_reldir%_sync_test_CPPFLAGS = \
	$(AM_CPPFLAGS) \
	-I$(srcdir)/%reldir%/include
%canon_reldir%_sync_test_CFLAGS = \
	$(AM_CFLAGS) \
	$(PTHREAD_CFLAGS)
%canon_reldir%_sync_test_LDADD = \
	$(PTHREAD_LIBS) -lpthread \
	%reldir%/libandroid-sync.la
%canon_reldir%_sync_test_SOURCES = \
	%reldir%/sync_test.c

pkgconfig_DATA += \
	%reldir%/android-sync-$(LAARID_API_VERSION).pc
