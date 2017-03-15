lib_LTLIBRARIES += \
    %reldir%/libandroid-packagelistparser.la

%canon_reldir%_libandroid_packagelistparser_la_CPPFLAGS = \
    $(AM_CPPFLAGS) \
    $(BIONIC_CFLAGS) \
    -I%reldir%/include
%canon_reldir%_libandroid_packagelistparser_la_SOURCES = \
    %reldir%/packagelistparser.c
nodist_%canon_reldir%_libandroid_packagelistparser_la_SOURCES = \
    %reldir%/include/packagelistparser/packagelistparser.h
%canon_reldir%_libandroid_packagelistparser_la_LDFLAGS = \
    $(AM_LDFLAGS) \
    $(libtool_opts)
%canon_reldir%_libandroid_packagelistparser_la_LIBADD = \
    liblog/libandroid-log.la

%canon_reldir%_libandroid_packagelistparser_incdir = $(androidincdir)/packagelistparser
nodist_%canon_reldir%_libandroid_packagelistparser_inc_HEADERS = \
    %reldir%/include/packagelistparser/packagelistparser.h

EXTRA_DIST += \
    %reldir%/include/packagelistparser/packagelistparser.h.in

pkgconfig_DATA += \
    %reldir%/android-packagelistparser-$(LAARID_API_VERSION).pc
