dnl This Source Code Form is subject to the terms of the Mozilla Public
dnl License, v. 2.0. If a copy of the MPL was not distributed with this
dnl file, You can obtain one at http://mozilla.org/MPL/2.0/.

dnl ======================================================
dnl = Enable compiling with ccache
dnl ======================================================
AC_DEFUN([LAARID_CHECK_CCACHE],
  [AC_ARG_WITH([ccache],
    [AS_HELP_STRING([--with-ccache=path/to/ccache],
      [Enable compiling with ccache])],
    [CCACHE=$withval], [CCACHE="no"])
  AS_IF([test "$CCACHE" != "no"],
    [AS_IF([test -z "$CCACHE" -o "$CCACHE" = "yes"],
      [CCACHE=],
      [AS_IF([test ! -e "$CCACHE"],
        [AC_MSG_ERROR([$CCACHE not found])]
      )]
    )
    AC_PATH_PROGS([CCACHE], [$CCACHE ccache])
    AS_IF([test -z "$CCACHE"],
      [AC_MSG_WARN([ccache not found])],
      [AS_IF([test -x "$CCACHE"],
        [CC="$CCACHE $CC"
        CCAS="$CCACHE $CCAS"
        CXX="$CCACHE $CXX"],
        [AC_MSG_ERROR([$CCACHE is not executable])]
      )]
    )]
  )]
)
