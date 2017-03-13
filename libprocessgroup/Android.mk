lib_LTLIBRARIES += \
	%reldir%/libandroid-processgroup.la

%canon_reldir%_libandroid_processgroup_la_CPPFLAGS = \
	$(AM_CPPFLAGS) \
	-I$(top_srcdir)/%reldir%/include \
	$(BIONIC_CFLAGS) \
	$(LOG_CFLAGS) \
	$(CUTILS_CFLAGS)
%canon_reldir%_libandroid_processgroup_la_LDFLAGS = \
	$(AM_LDFLAGS) \
	$(libtool_opts)
%canon_reldir%_libandroid_processgroup_la_LIBADD = \
	$(LOG_LIBS) \
	$(BIONIC_LIBS) \
	$(UIDMAP_LIBS) \
	libutils/libandroid-utils.la
%canon_reldir%_libandroid_processgroup_la_SOURCES = \
	%reldir%/include/processgroup/processgroup.h \
	%reldir%/processgroup.cpp

pkgconfig_DATA += \
	%reldir%/android-processgroup-$(LAARID_API_VERSION).pc
