#
# OpenCL for Lua.
# Copyright © 2013–2014 Peter Colberg.
# Distributed under the MIT license. (See accompanying file LICENSE.)
#

CPP       = $(CC)
CC        = gcc
CPPFLAGS  =
CPPOPT    = -DCL_USE_DEPRECATED_OPENCL_1_1_APIS -DCL_USE_DEPRECATED_OPENCL_2_0_APIS
CFLAGS    = -Wall -pedantic -Wno-comment
CCOPT     = -std=gnu99 -msse2 -mavx
GCCLUA    = gcclua
LIBNAME   = OpenCL

all: C.lua

%.lua: %.c %.lua.in
	$(CC) -S -fplugin=$(GCCLUA) -fplugin-arg-gcclua-script=$@.in -fplugin-arg-gcclua-output=$@ -fplugin-arg-gcclua-libname=$(LIBNAME) $(CPPOPT) $(CCOPT) $(CPPFLAGS) $(CFLAGS) $<

clean:
	$(RM) C.lua

.PHONY: clean
