------------------------------------------------------------------------------
-- Test programs.
-- Copyright © 2013–2014 Peter Colberg.
-- For conditions of distribution and use, see copyright notice in LICENSE.
------------------------------------------------------------------------------

require("strict")

pcall(require, "luacov")

local cl = require("opencl")
local test = require("test")

local tests = {}

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local source = [[
    __kernel void add(
      __global float *restrict a,
      __global const float *restrict b)
    {
      const size_t gid = get_global_id(0);
      a[gid] += b[gid];
    }

    __kernel void multiply(
      __global float *restrict a,
      __global const float *restrict b)
    {
      const size_t gid = get_global_id(0);
      a[gid] *= b[gid];
    }
  ]]
  local program = context:create_program_with_source(source)
  program:build()
  assert(program:get_info("context") == context)
  assert(program:get_info("num_devices") == 1)
  local devices = program:get_info("devices")
  assert(#devices == 1)
  assert(devices[1] == device)
  assert(program:get_info("source") == source)
  local binary_sizes = program:get_info("binary_sizes")
  assert(#binary_sizes == 1)
  assert(binary_sizes[1] > 0)
  local binaries = program:get_info("binaries")
  assert(#binaries == 1)
  assert(#binaries[1] == binary_sizes[1])
  if not device:get_info("version"):match("^OpenCL 1%.[01] ") then
    assert(program:get_info("num_kernels") == 2)
    assert(program:get_info("kernel_names") == "add;multiply")
  end
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local program = context:create_program_with_source([[
    __kernel void add(
      __global float *restrict a)
    {
      const size_t gid = get_global_id(0);
      a[gid] += VALUE;
    }
  ]])
  assert(program:get_build_info(device, "status") == nil)
  if not device:get_info("version"):match("^OpenCL 1%.[01] ") then
    assert(program:get_build_info(device, "binary_type") == nil)
  end
  program:build("-D VALUE=1")
  assert(program:get_build_info(device, "status") == "success")
  assert(program:get_build_info(device, "options") == "-D VALUE=1")
  assert(type(program:get_build_info(device, "log")) == "string")
  if not device:get_info("version"):match("^OpenCL 1%.[01] ") then
    assert(program:get_build_info(device, "binary_type") == "executable")
  end
end)

test.test_devices(tests)
