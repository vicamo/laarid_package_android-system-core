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

lib_LTLIBRARIES += \
	%reldir%/libandroid-utils.la

%canon_reldir%_libandroid_utils_la_CPPFLAGS = \
	$(AM_CPPFLAGS) \
	$(PTHREAD_CFLAGS) \
	$(BIONIC_CFLAGS) \
	$(LOG_CFLAGS) \
	$(CUTILS_CFLAGS) \
	$(NATIVEHELPER_CFLAGS)
# See https://github.com/laarid/package_android-system-core2/issues/6
#%canon_reldir%_libandroid_utils_la_CXXFLAGS = \
#	$(AM_CXXFLAGS) \
#	-fvisibility=protected
%canon_reldir%_libandroid_utils_la_LDFLAGS = \
	$(AM_LDFLAGS) \
	$(libtool_opts)
%canon_reldir%_libandroid_utils_la_LIBADD = \
	$(PTHREAD_LIBS) -lpthread \
	$(LOG_LIBS) \
	$(CUTILS_LIBS)
%canon_reldir%_libandroid_utils_la_SOURCES = \
	%reldir%/BlobCache.cpp \
	%reldir%/FileMap.cpp \
	%reldir%/JenkinsHash.cpp \
	%reldir%/LinearTransform.cpp \
	%reldir%/Log.cpp \
	%reldir%/Looper.cpp \
	%reldir%/NativeHandle.cpp \
	%reldir%/Printer.cpp \
	%reldir%/PropertyMap.cpp \
	%reldir%/RefBase.cpp \
	%reldir%/SharedBuffer.cpp \
	%reldir%/SharedBuffer.h \
	%reldir%/Static.cpp \
	%reldir%/StopWatch.cpp \
	%reldir%/String8.cpp \
	%reldir%/String16.cpp \
	%reldir%/SystemClock.cpp \
	%reldir%/Threads.cpp \
	%reldir%/Timers.cpp \
	%reldir%/Tokenizer.cpp \
	%reldir%/Trace.cpp \
	%reldir%/Unicode.cpp \
	%reldir%/VectorImpl.cpp \
	%reldir%/misc.cpp

if CPU_S390X
# nothing
else
%canon_reldir%_libandroid_utils_la_LIBADD += \
	libbacktrace/libandroid-backtrace.la
%canon_reldir%_libandroid_utils_la_SOURCES += \
	%reldir%/CallStack.cpp \
	%reldir%/ProcessCallStack.cpp
endif

pkgconfig_DATA += \
	%reldir%/android-utils-$(LAARID_API_VERSION).pc

include $(srcdir)/libutils/tests/Android.mk
