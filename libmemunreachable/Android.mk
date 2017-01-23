lib_LTLIBRARIES += \
    %reldir%/libandroid-memunreachable.la

%canon_reldir%_libandroid_memunreachable_la_CPPFLAGS = \
    $(AM_CPPFLAGS) \
    $(BIONIC_CFLAGS) \
    -I$(top_srcdir)/base/include \
    -I$(top_srcdir)/%reldir%/include
%canon_reldir%_libandroid_memunreachable_la_CXXFLAGS = \
    $(AM_CXXFLAGS) \
    -std=c++14
%canon_reldir%_libandroid_memunreachable_la_SOURCES = \
    %reldir%/Allocator.cpp \
    %reldir%/HeapWalker.cpp \
    %reldir%/LeakFolding.cpp \
    %reldir%/LeakPipe.cpp \
    %reldir%/LineBuffer.cpp \
    %reldir%/MemUnreachable.cpp \
    %reldir%/ProcessMappings.cpp \
    %reldir%/PtracerThread.cpp \
    %reldir%/ThreadCapture.cpp
%canon_reldir%_libandroid_memunreachable_la_LIBADD = \
    base/libandroid-base.la \
    liblog/libandroid-log.la
%canon_reldir%_libandroid_memunreachable_la_LDFLAGS = \
    $(AM_LDFLAGS) \
    $(libtool_opts)

pkgconfig_DATA += \
    %reldir%/android-memunreachable-$(SYSTEMCORE_API_VERSION).pc

if HAVE_GTEST
check_PROGRAMS += \
    %reldir%/memunreachable_test

TESTS += \
    %reldir%/memunreachable_test

%canon_reldir%_memunreachable_test_CPPFLAGS = \
    $(AM_CPPFLAGS) \
    $(GTEST_CPPFLAGS) \
    -I$(top_srcdir)/%reldir%/include
%canon_reldir%_memunreachable_test_CXXFLAGS = \
    $(AM_CXXFLAGS) \
    -std=c++14
%canon_reldir%_memunreachable_test_SOURCES = \
    %reldir%/tests/Allocator_test.cpp \
    %reldir%/tests/DisableMalloc_test.cpp \
    %reldir%/tests/HeapWalker_test.cpp \
    %reldir%/tests/LeakFolding_test.cpp \
    %reldir%/tests/MemUnreachable_test.cpp \
    %reldir%/tests/ThreadCapture_test.cpp
%canon_reldir%_memunreachable_test_LDADD = \
    base/libandroid-base.la \
    liblog/libandroid-log.la \
    $(GTEST_LIBS)
%canon_reldir%_memunreachable_test_DEPENDENCIES = \
    base/libandroid-base.la \
    liblog/libandroid-log.la \
    $(GTEST_LIBS)
endif # HAVE_GTEST
