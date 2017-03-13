sbin_PROGRAMS += \
    %reldir%/logd

%canon_reldir%_logd_CPPFLAGS = \
    $(AM_CPPFLAGS) \
    $(BIONIC_CFLAGS) \
    -I$(srcdir)/base/include \
    -Ilibpackagelistparser/include
# For logd/libaudit.c
%canon_reldir%_logd_CFLAGS = \
    $(AM_CFLAGS) \
    -Wno-strict-aliasing
%canon_reldir%_logd_SOURCES = \
    %reldir%/main.cpp \
    %reldir%/LogCommand.cpp \
    %reldir%/LogCommand.h \
    %reldir%/CommandListener.cpp \
    %reldir%/CommandListener.h \
    %reldir%/LogListener.cpp \
    %reldir%/LogListener.h \
    %reldir%/LogReader.cpp \
    %reldir%/LogReader.h \
    %reldir%/FlushCommand.cpp \
    %reldir%/FlushCommand.h \
    %reldir%/LogBuffer.cpp \
    %reldir%/LogBuffer.h \
    %reldir%/LogBufferElement.cpp \
    %reldir%/LogBufferElement.h \
    %reldir%/LogTimes.cpp \
    %reldir%/LogTimes.h \
    %reldir%/LogStatistics.cpp \
    %reldir%/LogStatistics.h \
    %reldir%/LogWhiteBlackList.cpp \
    %reldir%/LogWhiteBlackList.h \
    %reldir%/libaudit.c \
    %reldir%/libaudit.h \
    %reldir%/LogAudit.cpp \
    %reldir%/LogAudit.h \
    %reldir%/LogKlog.cpp \
    %reldir%/LogKlog.h \
    %reldir%/LogUtils.h

# TODO: https://github.com/laarid/package_android-system-core/issues/29
#    event.logtags
%canon_reldir%_logd_LDADD = \
    $(ATOMIC_LIBS) \
    $(BIONIC_LIBS) \
    libuidmap/libandroid-uidmap.la \
    libsysutils/libandroid-sysutils.la \
    liblog/libandroid-log.la \
    libcutils/libandroid-cutils.la \
    base/libandroid-base.la \
    libpackagelistparser/libandroid-packagelistparser.la

# This is what we want to do:
#  event_logtags = $(shell \
#    sed -n \
#        "s/^\([0-9]*\)[ \t]*$1[ \t].*/-D`echo $1 | tr a-z A-Z`_LOG_TAG=\1/p" \
#        $(LOCAL_PATH)/$2/event.logtags)
#  event_flag := $(call event_logtags,auditd)
#  event_flag += $(call event_logtags,logd)
# so make sure we do not regret hard-coding it as follows:
%canon_reldir%_logd_CPPFLAGS += \
    -DAUDITD_LOG_TAG=1003 -DLOGD_LOG_TAG=1004

include $(srcdir)/logd/tests/Android.mk
