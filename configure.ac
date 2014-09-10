AC_INIT([exampleapp],
        [0.0],
        [https://github.com/canek-pelaez/exampleapp/issues],
        [exampleapp],
        [https://github.com/canek-pelaez/exampleapp])
AC_CONFIG_SRCDIR([src/main.vala])

AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([1.11 foreign no-dist-gzip dist-xz])
AM_SILENT_RULES([yes])

AC_PROG_CC
AM_PROG_CC_C_O
AC_PROG_CC_STDC
AM_PROG_VALAC([0.22])
AC_PROG_INSTALL

EXAMPLE_PACKAGES="--pkg gtk+-3.0"
PKG_CHECK_MODULES(EXAMPLE, [ gtk+-3.0 ])

AC_SUBST(EXAMPLE_CFLAGS)
AC_SUBST(EXAMPLE_LIBS)
AC_SUBST(EXAMPLE_PACKAGES)

AC_CONFIG_FILES([
	Makefile
])

AC_OUTPUT
