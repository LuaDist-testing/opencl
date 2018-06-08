------------------------------------------------------------------------------
-- Test contexts.
-- Copyright © 2013–2015 Peter Colberg.
-- Distributed under the MIT license. (See accompanying file LICENSE.)
------------------------------------------------------------------------------

require("strict")

pcall(require, "luacov")

local cl = require("opencl")
local test = require("test")

local tests = {}

table.insert(tests, function(device)
  local context = cl.create_context({device})
  assert(context:get_info("num_devices") == 1)
  local devices = context:get_info("devices")
  assert(#devices == 1)
  assert(devices[1] == device)
end)

table.insert(tests, function(device)
  local properties = device:get_info("partition_properties")
  if not properties or not properties.equally then return end
  local sub_devices = device:create_sub_devices("equally", 1)
  local context = cl.create_context(sub_devices)
  assert(context:get_info("num_devices") == #sub_devices)
  local devices = context:get_info("devices")
  assert(#devices == #sub_devices)
  for i = 1, #sub_devices do
    assert(devices[i] == sub_devices[i])
  end
end)

test.test_devices(tests)
