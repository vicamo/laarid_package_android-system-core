lib_LTLIBRARIES += \
	%reldir%/libandroid-packagelistparser.la

%canon_reldir%_libandroid_packagelistparser_la_CPPFLAGS = \
	$(AM_CPPFLAGS) \
	$(BIONIC_CFLAGS) \
	-I$(top_srcdir)/%reldir%/include
%canon_reldir%_libandroid_packagelistparser_la_SOURCES = \
	%reldir%/packagelistparser.c
%canon_reldir%_libandroid_packagelistparser_la_LIBADD = \
	liblog/libandroid-log.la
%canon_reldir%_libandroid_packagelistparser_la_LDFLAGS = \
	$(AM_LDFLAGS) \
	$(libtool_opts)

%canon_reldir%_libandroid_packagelistparser_incdir = $(androidincdir)/packagelistparser
%canon_reldir%_libandroid_packagelistparser_inc_HEADERS = \
	%reldir%/include/packagelistparser/packagelistparser.h

pkgconfig_DATA += \
	%reldir%/android-packagelistparser-$(SYSTEMCORE_API_VERSION).pc
