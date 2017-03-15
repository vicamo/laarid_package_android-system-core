# Copyright 2006-2014 The Android Open Source Project

bin_PROGRAMS += \
    %reldir%/logcat

%canon_reldir%_logcat_CPPFLAGS = \
    $(AM_CPPFLAGS) \
    $(BIONIC_CFLAGS) \
    -I$(srcdir)/base/include
%canon_reldir%_logcat_SOURCES = \
    %reldir%/logcat.cpp
# TODO: https://github.com/laarid/package_android-system-core/issues/29
#    %reldir%/event.logtags
%canon_reldir%_logcat_LDADD = \
    $(PCRECPP_LIBS) \
    $(BIONIC_LIBS) \
    liblog/libandroid-log.la \
    base/libandroid-base.la \
    libcutils/libandroid-cutils.la
