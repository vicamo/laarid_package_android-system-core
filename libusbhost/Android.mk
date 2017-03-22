#
# Copyright (C) 2010 The Android Open Source Project
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
	%reldir%/libandroid-usbhost.la

%canon_reldir%_libandroid_usbhost_la_CPPFLAGS = \
	$(AM_CPPFLAGS) \
	-DUSE_LIBLOG
%canon_reldir%_libandroid_usbhost_la_LDFLAGS = \
	$(AM_LDFLAGS) \
	$(libtool_opts)
%canon_reldir%_libandroid_usbhost_la_LIBADD = \
	liblog/libandroid-log.la
%canon_reldir%_libandroid_usbhost_la_SOURCES = \
	%reldir%/usbhost.c

pkgconfig_DATA += \
	%reldir%/android-usbhost-$(LAARID_API_VERSION).pc
