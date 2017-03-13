# Copyright 2005 The Android Open Source Project

sbin_PROGRAMS += \
    %reldir%/apropd

%canon_reldir%_apropd_CPPFLAGS = \
    $(AM_CPPFLAGS) \
    $(BIONIC_CFLAGS) \
    -I$(top_srcdir)/base/include \
    -DLAARID_APROPD \
    -DALLOW_LOCAL_PROP_OVERRIDE=1

%canon_reldir%_apropd_CXXFLAGS = \
    $(AM_CXXFLAGS) \
    -Wno-unused-parameter

%canon_reldir%_apropd_SOURCES = \
    %reldir%/init.cpp \
    %reldir%/init.h \
    %reldir%/log.cpp \
    %reldir%/log.h \
    %reldir%/property_service.cpp \
    %reldir%/property_service.h \
    %reldir%/util.cpp \
    %reldir%/util.h

%canon_reldir%_apropd_LDADD = \
    $(BIONIC_LIBS) \
    libuidmap/libandroid-uidmap.la \
    libcutils/libandroid-cutils.la \
    base/libandroid-base.la
