# android-system-core versioning
# -------------------------
# To make new release:
#
#   laarid_micro_version += 1
#   laarid_interface_revision += 1
#
# if any functions have been added:
#
#   laarid_micro_version += 1
#   laarid_interface_revision = 0
#
#   or
#
#   laarid_minor_version += 1
#   laarid_micro_version = 0
#   laarid_interface_revision = 0
#
# if backwards compatibility has been broken:
#
#   laarid_major_version += 1
#   laarid_minor_version = 0
#   laarid_micro_version = 0
#   laarid_interface_revision = 0
m4_define([laarid_major_version], [0])
m4_define([laarid_minor_version], [0])
m4_define([laarid_micro_version], [15])
m4_define([laarid_interface_revision], [0])
m4_define([laarid_api_version], [laarid_major_version.0])
m4_define([laarid_release_number], [laarid_major_version])
m4_define([laarid_version],
  [laarid_major_version.laarid_minor_version.laarid_micro_version])

# Require autoconf 2.69 for aarch64
AC_PREREQ(2.69)

AC_INIT([android-system-core], [laarid_version],
  [https://github.com/laarid/package_android-system-core/issues], [],
  [https://github.com/laarid/package_android-system-core])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_SRCDIR([include/log/log.h])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects no-define tar-ustar])
AM_MAINTAINER_MODE([enable])
AM_SILENT_RULES([yes])

LAARID_MAJOR_VERSION=laarid_major_version
LAARID_MINOR_VERSION=laarid_minor_version
LAARID_MICRO_VERSION=laarid_micro_version
LAARID_API_VERSION=laarid_api_version
LAARID_RELEASE_NUMBER=laarid_release_number
AC_SUBST([LAARID_MAJOR_VERSION])
AC_SUBST([LAARID_MINOR_VERSION])
AC_SUBST([LAARID_MICRO_VERSION])
AC_SUBST([LAARID_API_VERSION])
AC_SUBST([LAARID_RELEASE_NUMBER])

# Define _GNU_SOURCE etc. where appropriate, e.g. for strptime() on glibc
AC_USE_SYSTEM_EXTENSIONS

# Large file support
# ------------------
AC_SYS_LARGEFILE

# Host environment
# ----------------
AC_CANONICAL_HOST

os_linux=no
case "$host" in
  *-*-linux*)
    os_linux=yes
    ;;
esac

AM_CONDITIONAL(OS_LINUX, test "$os_linux" = "yes")

cpu_arm=no
cpu_aarch64=no
cpu_mips=no
cpu_mips64=no
cpu_x86=no
cpu_x86_64=no
case "$host_cpu" in
  arm*)
    cpu_arm=yes
    ;;
  aarch64*)
    cpu_aarch64=yes
    ;;
  mips64*)
    cpu_mips64=yes
    ;;
  mips*)
    cpu_mips=yes
    ;;
  i?86 | x86)
    cpu_x86=yes
    ;;
  x86_64 | amd64)
    cpu_x86_64=yes
    ;;
esac

AM_CONDITIONAL(CPU_ARM, test "$cpu_arm" = "yes")
AM_CONDITIONAL(CPU_AARCH64, test "$cpu_aarch64" = "yes")
AM_CONDITIONAL(CPU_MIPS, test "$cpu_mips" = "yes")
AM_CONDITIONAL(CPU_MIPS64, test "$cpu_mips64" = "yes")
AM_CONDITIONAL(CPU_X86, test "$cpu_x86" = "yes")
AM_CONDITIONAL(CPU_X86_64, test "$cpu_x86_64" = "yes")

AM_PROG_AR
AM_PROG_AS
AC_PROG_CC
AC_PROG_CXX

# libtool versioning
# ------------------
LT_INIT

LT_RELEASE="laarid_api_version"
AC_SUBST(LT_RELEASE)

m4_define([laarid_binary_age], [m4_eval(100 * laarid_minor_version + laarid_micro_version)])
m4_define([lt_current], [m4_eval(laarid_binary_age - laarid_interface_revision)])
m4_define([lt_revision], [laarid_interface_revision])
# Whenever backward compatibility is broken, we generate libraries of different
# release number. That follows the library files of the same release are always
# compatible, and they have their lt_age equal to lt_current.
m4_define([lt_age], [lt_current])
LT_VERSION_INFO="lt_current:lt_revision:lt_age"
AC_SUBST(LT_VERSION_INFO)

# System dlloader
# ---------------
LT_LIB_DLLOAD

LT_OUTPUT

# Build stages
# ------------
# Android source code might have circular dependency between two or more
# source repositories, so spliting them into some stages is necessary. Here
# we have currently stage 1 and 2 only.
AC_ARG_WITH([stage],
  [AS_HELP_STRING([--with-stage], [Stage to build with @<:@default=1@:>@])],
  [AS_CASE([${with_stage}],
    [1|2], [AC_MSG_RESULT([Building for stage ${with_stage}])],
    [AC_MSG_ERROR([Unknown stage "${with_stage}"])])],
  [with_stage=1])
AM_CONDITIONAL([WITH_STAGE_1], [test "x${with_stage}" = x1])
AM_CONDITIONAL([WITH_STAGE_2], [test "x${with_stage}" = x2])

# Required libraries
# ------------------

PKG_CHECK_MODULES([ZLIB], [zlib])
AC_SUBST([ZLIB_CFLAGS])
AC_SUBST([ZLIB_LIBS])

BIONIC_API_VERSION=0.0
BIONIC_REQUIRED_VERSION=0.1.6
AC_SUBST([BIONIC_API_VERSION])
AC_SUBST([BIONIC_REQUIRED_VERSION])
PKG_CHECK_MODULES([BIONIC], [android-bionic-$BIONIC_API_VERSION >= $BIONIC_REQUIRED_VERSION])
AC_SUBST([BIONIC_CFLAGS])
AC_SUBST([BIONIC_LIBS])

AS_IF([test "x${with_stage}" = x1], [
  PKG_CHECK_MODULES([NL], [libnl-3.0])
  AC_SUBST([NL_CFLAGS])
  AC_SUBST([NL_LIBS])
  ],
  [test "x${with_stage}" = x2], [
  LOG_API_VERSION=0.0
  LOG_REQUIRED_VERSION=0.0.12
  AC_SUBST([LOG_API_VERSION])
  AC_SUBST([LOG_REQUIRED_VERSION])
  PKG_CHECK_MODULES([LOG], [android-log-$LOG_API_VERSION >= $LOG_REQUIRED_VERSION])
  AC_SUBST([LOG_CFLAGS])
  AC_SUBST([LOG_LIBS])

  BASE_API_VERSION=0.0
  BASE_REQUIRED_VERSION=0.0.12
  AC_SUBST([BASE_API_VERSION])
  AC_SUBST([BASE_REQUIRED_VERSION])
  PKG_CHECK_MODULES([BASE], [android-base-$BASE_API_VERSION >= $BASE_REQUIRED_VERSION])
  AC_SUBST([BASE_CFLAGS])
  AC_SUBST([BASE_LIBS])

  CUTILS_API_VERSION=0.0
  CUTILS_REQUIRED_VERSION=0.0.12
  AC_SUBST([CUTILS_API_VERSION])
  AC_SUBST([CUTILS_REQUIRED_VERSION])
  PKG_CHECK_MODULES([CUTILS], [android-cutils-$CUTILS_API_VERSION >= $CUTILS_REQUIRED_VERSION])
  AC_SUBST([CUTILS_CFLAGS])
  AC_SUBST([CUTILS_LIBS])

  NATIVEHELPER_API_VERSION=0.0
  NATIVEHELPER_REQUIRED_VERSION=0.0.4
  AC_SUBST([NATIVEHELPER_API_VERSION])
  AC_SUBST([NATIVEHELPER_REQUIRED_VERSION])
  PKG_CHECK_MODULES([NATIVEHELPER], [android-nativehelper-$NATIVEHELPER_API_VERSION >= $NATIVEHELPER_REQUIRED_VERSION])
  AC_SUBST([NATIVEHELPER_CFLAGS])
  AC_SUBST([NATIVEHELPER_LIBS])

  UNWIND_API_VERSION=0.0
  UNWIND_REQUIRED_VERSION=0.0.3
  AC_SUBST([UNWIND_API_VERSION])
  AC_SUBST([UNWIND_REQUIRED_VERSION])
  PKG_CHECK_MODULES([UNWIND], [android-unwind-$UNWIND_API_VERSION >= $UNWIND_REQUIRED_VERSION])
  AC_SUBST([UNWIND_CFLAGS])
  AC_SUBST([UNWIND_LIBS])
])

# Required headers
# ----------------
AC_CHECK_HEADERS([linux/android_alarm.h linux/ioprio.h sched.h sys/socket.h linux/netfilter_ipv4/ipt_ULOG.h safe_iop.h])

# Required functions
# ------------------
AC_CHECK_FUNCS([localtime_r madvise mmap prctl pread strndup strptime])
AC_CHECK_FUNC([clock_gettime],
  [AC_DEFINE([HAVE_POSIX_CLOCKS], [1],
    [Define to 1 if you have the clock_gettime function.])])
AC_FUNC_STRERROR_R

# Required types
# --------------
AC_CHECK_TYPES([struct nd_opt_rdnss], [], [], [#include <netinet/icmp6.h>])
AC_CHECK_TYPES([off64_t])

# Thread implementation
# ---------------------
AX_PTHREAD(
[AC_DEFINE([HAVE_PTHREAD],[1],[Define if you have POSIX threads libraries and header files.])
AC_DEFINE([HAVE_PTHREADS],[1],[Define if you have POSIX threads libraries and header files.])
AC_MSG_CHECKING([for pthread_cond_timedwait_relative])
AC_LINK_IFELSE(
  [AC_LANG_PROGRAM(
    [#include <pthread.h>],
    [pthread_cond_timedwait_relative(NULL, NULL, NULL);])],
  [AC_MSG_RESULT([yes])
  AC_DEFINE([HAVE_PTHREAD_COND_TIMEDWAIT_RELATIVE], [1],
    [Have function pthread_cond_timedwait_relative])],
  [AC_MSG_RESULT([no])])
AC_MSG_CHECKING([for pthread_gettid_np])
AC_LINK_IFELSE(
  [AC_LANG_PROGRAM(
    [#include <pthread.h>],
    [pthread_gettid_np(0);])],
  [AC_MSG_RESULT([yes])
  AC_DEFINE([HAVE_PTHREAD_GETTID_NP], [1],
    [Have function pthread_gettid_np])],
  [AC_MSG_RESULT([no])]
)],
[AC_MSG_FAILURE([pthread not available.])])

# Local socket name space
# -----------------------
AC_CACHE_CHECK([for PF_LOCAL],
  [my_cv_pf_local],
  [AC_COMPILE_IFELSE(
    [AC_LANG_PROGRAM([#include <sys/socket.h>],
      [int sock = socket (PF_LOCAL, SOCK_DGRAM, 0);]
    )],
    [my_cv_pf_local=yes],
    [my_cv_pf_local=no]
  )]
)
if test x$my_cv_pf_local = xyes; then
  AC_DEFINE([HAVE_LINUX_LOCAL_SOCKET_NAMESPACE], [1],
    [Define to 1 if we have Linux-style non-filesystem Unix domain sockets.])
fi

# Android Anonymous Shared Memory(ashmem) support
# -----------------------------------------------
AC_ARG_ENABLE([ashmem],
  [AS_HELP_STRING([--enable-ashmem],
    [Enable Android Anonymous Shared Memory(ashmem) support])],
  [],
  [enable_ashmem=check])
if test x$enable_ashmem = xcheck; then
  AC_CHECK_HEADER([linux/ashmem.h], [enable_ashmem=yes], [enable_ashmem=no])
fi
AM_CONDITIONAL([HAVE_ASHMEM], [test x$enable_ashmem = xyes])

# Android system properties
# -------------------------
AC_CHECK_FUNCS([__system_property_get __system_property_set __system_property_read __system_property_foreach], [], [break])
if test x$ac_cv_func___system_property_foreach = xyes; then
  AC_DEFINE([HAVE_LIBC_SYSTEM_PROPERTIES], [1],
    [Define to 1 if bionic includes Android system properties implementation.])
else
  if test x$ax_pthread_ok = xyes; then
    AC_CACHE_CHECK([for PF_LOCAL],
      [my_cv_pf_unix],
      [AC_COMPILE_IFELSE(
        [AC_LANG_PROGRAM([#include <sys/socket.h>],
          [int sock = socket (PF_LOCAL, SOCK_DGRAM, 0);]
        )],
        [my_cv_pf_unix=yes]
      )]
    )
  fi
  if test x$my_cv_pf_unix = xyes; then
    AC_DEFINE([HAVE_SYSTEM_PROPERTY_SERVER], [1],
      [Define to 1 if system provides a system property server.])
  fi
fi

AC_DEFINE([OS_PATH_SEPARATOR], ['/'],
  [The default path separator for the platform.])

if test x$ac_cv_func_mmap = xyes; then
  AC_DEFINE([HAVE_POSIX_FILEMAP], [1],
    [Define to 1 if we have POSIX mmap.])
fi
if test x$os_windows = xyes; then
  AC_DEFINE([HAVE_WIN32_FILEMAP], [1],
    [Define to 1 if we have Windows {Map,Unmap}ViewOfFile.])
fi

# Optional features
# -----------------
AC_ARG_ENABLE([cpusets],
  [AS_HELP_STRING([--enable-cpusets], [enable use of /dev/cpuset @<:@default=no@:>@])])
AM_CONDITIONAL([ENABLE_CPUSETS], [test x$enable_cpusets = xyes])

AC_ARG_ENABLE([schedboost],
  [AS_HELP_STRING([--enable-schedboost], [enable use of /dev/stune/* @<:@default=no@:>@])])
AM_CONDITIONAL([ENABLE_SCHEDBOOST], [test x$enable_schedboost = xyes])

AS_IF([test "x${cpu_arm}" = xyes],
  [AC_COMPILE_IFELSE([AC_LANG_PROGRAM([#ifndef __ARM_FEATURE_DSP
#error "DSP not supported"
#endif
], [])],
    [enable_arm_dsp=yes],
    [enable_arm_dsp=no])])
AM_CONDITIONAL([CPU_ARM_HAVE_DSP], [test "x${enable_arm_dsp}" = xyes])

AC_ARG_ENABLE([arm-neon],
  [AS_HELP_STRING([--enable-arm-neon], [Enable ARM NEON optimizations])],
  [AS_IF([test "x${enable_arm_neon}" != xno],
    [AC_COMPILE_IFELSE([AC_LANG_PROGRAM([#ifndef __ARM_NEON
#error "NEON not supported"
#endif
], [])],
      [enable_arm_neon=yes],
      [enable_arm_neon=no])])])
AM_CONDITIONAL([CPU_ARM_HAVE_NEON], [test "x${enable_arm_neon}" = xyes])

# GTest
# -----
AC_LANG_PUSH([C++])
AC_ARG_WITH([gtest],
  [AS_HELP_STRING([--with-gtest],
    [Build with Google Test Frameworks based tests @<:@default=check@:>@])],
  [], [])
AS_IF([test "x${with_gtest}" != xno],
  [GTEST_SRCDIR="/usr/src/gtest"
  AS_IF([test "x${with_gtest}" != xyes],
    [AS_IF([test -e "${with_gtest}/include/gtest/gtest.h"],
      [GTEST_SRCDIR="${with_gtest}"])])
  CPPFLAGS_save="$CPPFLAGS"
  GTEST_CPPFLAGS="-I ${GTEST_SRCDIR}/include"
  GTEST_LIBS="libgtest.la libgtest_main.la"
  CPPFLAGS="${GTEST_CPPFLAGS}"
  AC_CHECK_HEADER([gtest/gtest.h], [],
    [AS_IF([test "x${with_gtest}" != xyes],
      [AC_MSG_ERROR([Google Test Frameworks source folder not found])],
      [with_gtest=no])])
  CPPFLAGS="$CPPFLAGS_save"])
AC_SUBST([GTEST_CPPFLAGS])
AC_SUBST([GTEST_LIBS])
AC_SUBST([GTEST_SRCDIR])
AC_LANG_POP()
AM_CONDITIONAL([HAVE_GTEST], [test "x${with_gtest}" != xno])

dnl Whether should we run ION unit tests
AC_CHECK_FILE([/dev/ion])
AM_CONDITIONAL([HAVE_DEV_ION], [test "x${c_cv_file_dev_ion}" = xyes])

AC_CONFIG_FILES([
  Makefile
])
AS_IF([test "x${with_stage}" = x1], [AC_CONFIG_FILES([
  base/android-base-$LAARID_API_VERSION.pc
  libcutils/android-cutils-$LAARID_API_VERSION.pc
  libdiskconfig/android-diskconfig-$LAARID_API_VERSION.pc
  libion/android-ion-$LAARID_API_VERSION.pc
  liblog/android-log-$LAARID_API_VERSION.pc
  libmincrypt/android-mincrypt-$LAARID_API_VERSION.pc
  libnetutils/android-netutils-$LAARID_API_VERSION.pc
  libpackagelistparser/android-packagelistparser-$LAARID_API_VERSION.pc
  libsparse/android-sparse-$LAARID_API_VERSION.pc
  libsuspend/android-suspend-$LAARID_API_VERSION.pc
  libsync/android-sync-$LAARID_API_VERSION.pc
  libsysutils/android-sysutils-$LAARID_API_VERSION.pc
  libusbhost/android-usbhost-$LAARID_API_VERSION.pc
  logwrapper/android-logwrap-$LAARID_API_VERSION.pc
  ])],
  [test "x${with_stage}" = x2], [AC_CONFIG_FILES([
  libbacktrace/android-backtrace-$LAARID_API_VERSION.pc
  libnativebridge/android-nativebridge-$LAARID_API_VERSION.pc
  libnativeloader/android-nativeloader-$LAARID_API_VERSION.pc
  libpixelflinger/android-pixelflinger-$LAARID_API_VERSION.pc
  libprocessgroup/android-processgroup-$LAARID_API_VERSION.pc
  libutils/android-utils-$LAARID_API_VERSION.pc
  libziparchive/android-ziparchive-$LAARID_API_VERSION.pc
  ])])
AC_OUTPUT
