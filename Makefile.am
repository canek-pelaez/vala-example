AUTOMAKE_OPTIONS = subdir-objects

bin_PROGRAMS = src/exampleapp

src_exampleapp_SOURCES =			\
	src/application.vala			\
	src/application-window.vala		\
	src/main.vala				\
	src/resources.c				\
	$(NULL)

src_exampleapp_VALAFLAGS =			\
	--target-glib=2.38			\
	@EXAMPLE_PACKAGES@			\
	--gresources $(gresource_file)		\
	$(NULL)

src_exampleapp_CFLAGS =				\
	@EXAMPLE_CFLAGS@			\
	-w					\
	$(NULL)

src_exampleapp_LDADD =				\
	@EXAMPLE_LIBS@				\
	$(NULL)

gresource_file = $(top_srcdir)/data/exampleapp.gresource.xml
resource_files = 				\
	$(top_srcdir)/data/window.ui		\
	$(NULL)

src/resources.c: $(gresource_file) $(resource_files)
	$(AM_V_GEN) $(GLIB_COMPILE_RESOURCES) 	\
		--target=$@			\
		--sourcedir=$(top_srcdir)/data	\
		--generate-source $<

data_desktopdir = $(datadir)/applications
data_desktop_DATA = data/exampleapp.desktop

data/exampleapp.desktop: data/exampleapp.desktop.in
	$(AM_V_GEN) [ -d $(@D) ] || $(mkdir_p) $(@D) ; \
		sed -e "s|\@bindir\@|$(bindir)|g" $< > $@

data_iconsdir = $(datadir)/icons/hicolor/48x48/apps
data_icons_DATA = data/exampleapp.png

noinst_DATA =					\
	$(gresource_file)			\
	$(resource_files)			\
	$(NULL)

EXTRA_DIST =					\
	data/exampleapp.desktop.in		\
	$(data_icons_DATA)			\
	$(NULL)

DISTCLEANFILES =				\
	$(data_desktop_DATA)
