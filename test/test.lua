------------------------------------------------------------------------------
-- Testing tools.
-- Copyright © 2013–2015 Peter Colberg.
-- Distributed under the MIT license. (See accompanying file LICENSE.)
------------------------------------------------------------------------------

require("strict")

pcall(require, "luacov")

local cl = require("opencl")

local _M = {}

-- Executes the given sequence of tests on each OpenCL platform.
function _M.test_platforms(tests)
  local platforms = cl.get_platforms()
  for i, platform in ipairs(platforms) do
    print("platform: " .. i)
    print("name    : " .. platform:get_info("name"))
    print("vendor  : " .. platform:get_info("vendor"))
    print("version : " .. platform:get_info("version"))
    print()
    for _, test in ipairs(tests) do
      test(platform)
    end
  end
end

-- Runs the given sequence of tests on each OpenCL device.
function _M.test_devices(tests)
  local platforms = cl.get_platforms()
  for i, platform in ipairs(platforms) do
    print("platform: " .. i)
    print("name    : " .. platform:get_info("name"))
    print("vendor  : " .. platform:get_info("vendor"))
    print("version : " .. platform:get_info("version"))
    print()
    local devices = platform:get_devices()
    for i, device in ipairs(devices) do
      print("device  : " .. i)
      print("name    : " .. device:get_info("name"))
      print("vendor  : " .. device:get_info("vendor"))
      print("version : " .. device:get_info("version"))
      print()
      for _, test in ipairs(tests) do
        test(device)
      end
    end
  end
end

return _M
