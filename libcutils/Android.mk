#
# Copyright (C) 2008 The Android Open Source Project
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
	%reldir%/libandroid-cutils.la

%canon_reldir%_libandroid_cutils_la_CPPFLAGS = \
	$(AM_CPPFLAGS) \
	$(SYSTEMD_CFLAGS) \
	$(BIONIC_CFLAGS)
if ENABLE_CPUSETS
%canon_reldir%_libandroid_cutils_la_CPPFLAGS += \
	-DUSE_CPUSETS
endif
if ENABLE_SCHEDBOOST
%canon_reldir%_libandroid_cutils_la_CPPFLAGS += \
	-DUSE_SCHEDBOOST
endif
%canon_reldir%_libandroid_cutils_la_CFLAGS = \
	$(AM_CFLAGS) \
	-std=gnu90 \
	$(PTHREAD_CFLAGS) \
	$(BIONIC_CFLAGS)
%canon_reldir%_libandroid_cutils_la_LDFLAGS = \
	$(AM_LDFLAGS) \
	$(libtool_opts)
%canon_reldir%_libandroid_cutils_la_LIBADD = \
	$(PTHREAD_LIBS) -lpthread\
	$(SYSTEMD_LIBS) \
	$(BIONIC_LIBS) \
	libuidmap/libandroid-uidmap.la \
	liblog/libandroid-log.la
%canon_reldir%_libandroid_cutils_la_DEPENDENCIES = \
	liblog/libandroid-log.la
%canon_reldir%_libandroid_cutils_la_SOURCES = \
	%reldir%/android_reboot.c \
	%reldir%/atomic.c \
	%reldir%/config_utils.c \
	%reldir%/debugger.c \
	%reldir%/fs.c \
	%reldir%/hashmap.c \
	%reldir%/iosched_policy.c \
	%reldir%/klog.c \
	%reldir%/load_file.c \
	%reldir%/multiuser.c \
	%reldir%/native_handle.c \
	%reldir%/partition_utils.c \
	%reldir%/process_name.c \
	%reldir%/properties.c \
	%reldir%/qtaguid.c \
	%reldir%/record_stream.c \
	%reldir%/sched_policy.c \
	%reldir%/socket_inaddr_any_server_unix.c \
	%reldir%/socket_local_unix.h \
	%reldir%/socket_local_client_unix.c \
	%reldir%/socket_local_server_unix.c \
	%reldir%/socket_loopback_client_unix.c \
	%reldir%/socket_loopback_server_unix.c \
	%reldir%/socket_network_client_unix.c \
	%reldir%/sockets.cpp \
	%reldir%/sockets_unix.cpp \
	%reldir%/str_parms.c \
	%reldir%/strdup16to8.c \
	%reldir%/strdup8to16.c \
	%reldir%/threads.c \
	%reldir%/uevent.c

if HAVE_ASHMEM
%canon_reldir%_libandroid_cutils_la_SOURCES += \
       %reldir%/ashmem-dev.c
else
%canon_reldir%_libandroid_cutils_la_SOURCES += \
       %reldir%/ashmem-host.c
endif

if OS_LINUX
%canon_reldir%_libandroid_cutils_la_SOURCES += \
	%reldir%/trace-dev.c
endif

if CPU_ARM
%canon_reldir%_libandroid_cutils_la_SOURCES += \
	%reldir%/arch-arm/memset32.S
else
if CPU_AARCH64
%canon_reldir%_libandroid_cutils_la_SOURCES += \
	%reldir%/arch-arm64/android_memset.S
else
if CPU_X86
%canon_reldir%_libandroid_cutils_la_SOURCES += \
	%reldir%/arch-x86/android_memset16.S \
	%reldir%/arch-x86/android_memset32.S \
	%reldir%/arch-x86/cache.h
else
if CPU_X86_64
%canon_reldir%_libandroid_cutils_la_SOURCES += \
	%reldir%/arch-x86_64/android_memset16.S \
	%reldir%/arch-x86_64/android_memset32.S \
	%reldir%/arch-x86_64/cache.h
else
%canon_reldir%_libandroid_cutils_la_SOURCES += \
	%reldir%/arch-mips/android_memset.c
endif # CPU_X86_64
endif # CPU_X86
endif # CPU_AARCH64
endif # CPU_ARM

pkgconfig_DATA += \
	%reldir%/android-cutils-$(LAARID_API_VERSION).pc

bin_PROGRAMS += \
	%reldir%/getprop \
	%reldir%/setprop
%canon_reldir%_getprop_SOURCES = \
	%reldir%/getprop.c
%canon_reldir%_getprop_LDADD = \
	%reldir%/libandroid-cutils.la
%canon_reldir%_setprop_SOURCES = \
	%reldir%/setprop.c
%canon_reldir%_setprop_LDADD = \
	%reldir%/libandroid-cutils.la

include $(srcdir)/libcutils/tests/Android.mk
