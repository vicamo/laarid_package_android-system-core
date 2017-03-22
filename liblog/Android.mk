#
# Copyright (C) 2008-2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

lib_LTLIBRARIES += \
	%reldir%/libandroid-log.la

%canon_reldir%_libandroid_log_la_CPPFLAGS = \
	$(AM_CPPFLAGS) \
	$(BIONIC_CFLAGS)
# This is what we want to do:
#  liblog_cflags := $(shell \
#   sed -n \
#       's/^\([0-9]*\)[ \t]*liblog[ \t].*/-DLIBLOG_LOG_TAG=\1/p' \
#       $(LOCAL_PATH)/event.logtags)
# so make sure we do not regret hard-coding it as follows:
%canon_reldir%_libandroid_log_la_CPPFLAGS += \
	-DLIBLOG_LOG_TAG=1005 \
	-DSNET_EVENT_LOG_TAG=1397638484
%canon_reldir%_libandroid_log_la_CFLAGS = \
	$(AM_CFLAGS) \
	$(PTHREAD_CFLAGS) \
	$(BIONIC_CFLAGS) \
	-fvisibility=hidden
%canon_reldir%_libandroid_log_la_LIBADD = \
	$(PTHREAD_LIBS) -lpthread \
	$(BIONIC_LIBS) \
	libuidmap/libandroid-uidmap.la
%canon_reldir%_libandroid_log_la_LDFLAGS = \
	$(AM_LDFLAGS) \
	$(libtool_opts)
if CPU_ARM
# TODO: This is to work around b/19059885. Remove after root cause is fixed
%canon_reldir%_libandroid_log_la_LDFLAGS += \
	-Wl,--hash-style=both
endif
%canon_reldir%_libandroid_log_la_SOURCES = \
	%reldir%/config_read.c \
	%reldir%/config_read.h \
	%reldir%/config_write.c \
	%reldir%/config_write.h \
	%reldir%/event_tag_map.c \
	%reldir%/log_event_list.c \
	%reldir%/log_event_write.c \
	%reldir%/log_is_loggable.c \
	%reldir%/log_portability.h \
	%reldir%/log_time.cpp \
	%reldir%/logd_reader.c \
	%reldir%/logd_writer.c \
	%reldir%/logger.h \
	%reldir%/logger_lock.c \
	%reldir%/logger_name.c \
	%reldir%/logger_read.c \
	%reldir%/logger_write.c \
	%reldir%/logprint.c \
	%reldir%/pmsg_reader.c \
	%reldir%/pmsg_writer.c \
	%reldir%/uio.c

pkgconfig_DATA += \
	%reldir%/android-log-$(LAARID_API_VERSION).pc
