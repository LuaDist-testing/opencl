#
# OpenCL for Lua.
# Copyright © 2013–2015 Peter Colberg.
# Distributed under the MIT license. (See accompanying file LICENSE.)
#

PREFIX = /usr/local
LUADIR = $(PREFIX)/share/lua/5.1
DOCDIR = $(PREFIX)/share/doc/lua-opencl

INSTALL_D = mkdir -p
INSTALL_F = install -m 644
INSTALL_X = install -m 755

FILES_LUA = C.lua init.lua
FILES_DOC = index.mdwn INSTALL.mdwn README.mdwn mandelbrot.mdwn reference.mdwn CHANGES.mdwn
FILES_DOC_HTML = index.html INSTALL.html README.html mandelbrot.html reference.html CHANGES.html pandoc.css lua-opencl.png mandelbrot.png parallel_sum.svg
FILES_EXAMPLES_MANDELBROT_F = mandelbrot.cl config.lua
FILES_EXAMPLES_MANDELBROT_X = mandelbrot.lua
FILES_EXAMPLES_SUM_F = random.lua
FILES_EXAMPLES_SUM_X = sum.lua

all: test

install:
	$(INSTALL_D) $(DESTDIR)$(LUADIR)/opencl
	cd opencl && $(INSTALL_F) $(FILES_LUA) $(DESTDIR)$(LUADIR)/opencl
	$(INSTALL_D) $(DESTDIR)$(DOCDIR)
	cd doc && $(INSTALL_F) $(FILES_DOC) $(FILES_DOC_HTML) $(DESTDIR)$(DOCDIR)
	$(INSTALL_D) $(DESTDIR)$(DOCDIR)/examples/mandelbrot
	cd examples/mandelbrot && $(INSTALL_F) $(FILES_EXAMPLES_MANDELBROT_F) $(DESTDIR)$(DOCDIR)/examples/mandelbrot
	cd examples/mandelbrot && $(INSTALL_X) $(FILES_EXAMPLES_MANDELBROT_X) $(DESTDIR)$(DOCDIR)/examples/mandelbrot
	$(INSTALL_D) $(DESTDIR)$(DOCDIR)/examples/sum
	cd examples/sum && $(INSTALL_F) $(FILES_EXAMPLES_SUM_F) $(DESTDIR)$(DOCDIR)/examples/sum
	cd examples/sum && $(INSTALL_X) $(FILES_EXAMPLES_SUM_X) $(DESTDIR)$(DOCDIR)/examples/sum

clean:
	@$(MAKE) -C test clean

SUBDIRS = test doc

.PHONY: $(SUBDIRS)

$(SUBDIRS):
	@$(MAKE) -C $@
