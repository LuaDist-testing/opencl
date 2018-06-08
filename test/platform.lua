------------------------------------------------------------------------------
-- Test platforms.
-- Copyright © 2013–2014 Peter Colberg.
-- Distributed under the MIT license. (See accompanying file LICENSE.)
------------------------------------------------------------------------------

require("strict")

pcall(require, "luacov")

local cl = require("opencl")
local test = require("test")

local tests = {}

table.insert(tests, function(platform)
  local devices = platform:get_devices("cpu")
  assert(devices == nil or #devices >= 1)
end)

table.insert(tests, function(platform)
  local devices = platform:get_devices("gpu")
  assert(devices == nil or #devices >= 1)
end)

table.insert(tests, function(platform)
  local devices = platform:get_devices("accelerator")
  assert(devices == nil or #devices >= 1)
end)

table.insert(tests, function(platform)
  local devices = platform:get_devices("default")
  assert(devices == nil or #devices >= 1)
end)

table.insert(tests, function(platform)
  local devices = platform:get_devices({"cpu", "gpu", "accelerator"})
  assert(devices == nil or #devices >= 1)
end)

table.insert(tests, function(platform)
  local devices = platform:get_devices()
  assert(devices == nil or #devices >= 1)
end)

table.insert(tests, function(platform)
  assert(type(platform:get_info("name")) == "string")
  assert(type(platform:get_info("vendor")) == "string")
  assert(type(platform:get_info("version")) == "string")
  assert(type(platform:get_info("profile")) == "string")
  assert(type(platform:get_info("extensions")) == "string")
end)

test.test_platforms(tests)
