#
# OpenCL for Lua.
# Copyright © 2013–2015 Peter Colberg.
# Distributed under the MIT license. (See accompanying file LICENSE.)
#

LUA = luajit

ifdef LUA_PATH
  LUA_PATH := $(CURDIR)/../?.lua;$(CURDIR)/../?/init.lua;$(LUA_PATH)
else
  LUA_PATH := $(CURDIR)/../?.lua;$(CURDIR)/../?/init.lua;;
endif
export LUA_PATH

all: platform device context mem program kernel queue event

%: %.lua
	$(LUA) $<

clean:
	$(RM) *.out

.PHONY: clean
