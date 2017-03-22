#
# Copyright (C) 2014 The Android Open Source Project
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
	%reldir%/libandroid-backtrace.la

%canon_reldir%_libandroid_backtrace_la_CPPFLAGS = \
	$(AM_CPPFLAGS) \
	$(UNWIND_CFLAGS) \
	$(BIONIC_CFLAGS) \
	$(LOG_CFLAGS) \
	$(BASE_CFLAGS) \
	$(CUTILS_CFLAGS)
%canon_reldir%_libandroid_backtrace_la_LDFLAGS = \
	$(AM_LDFLAGS) \
	$(libtool_opts)
%canon_reldir%_libandroid_backtrace_la_LIBADD = \
	$(PTHREAD_LIBS) -lpthread \
	$(UNWIND_LIBS) \
	$(BIONIC_LIBS) \
	$(LOG_LIBS) \
	$(BASE_LIBS)
%canon_reldir%_libandroid_backtrace_la_SOURCES = \
	%reldir%/Backtrace.cpp \
	%reldir%/BacktraceCurrent.cpp \
	%reldir%/BacktraceCurrent.h \
	%reldir%/BacktraceLog.h \
	%reldir%/BacktraceMap.cpp \
	%reldir%/BacktracePtrace.cpp \
	%reldir%/BacktracePtrace.h \
	%reldir%/ThreadEntry.cpp \
	%reldir%/ThreadEntry.h \
	%reldir%/UnwindCurrent.cpp \
	%reldir%/UnwindCurrent.h \
	%reldir%/UnwindMap.cpp \
	%reldir%/UnwindMap.h \
	%reldir%/UnwindPtrace.cpp \
	%reldir%/UnwindPtrace.h \
	%reldir%/thread_utils.c \
	%reldir%/thread_utils.h

pkgconfig_DATA += \
	%reldir%/android-backtrace-$(LAARID_API_VERSION).pc
