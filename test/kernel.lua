------------------------------------------------------------------------------
-- Test kernels.
-- Copyright © 2013–2015 Peter Colberg.
-- Distributed under the MIT license. (See accompanying file LICENSE.)
------------------------------------------------------------------------------

require("strict")

pcall(require, "luacov")

local cl = require("opencl")
local ffi = require("ffi")
local test = require("test")

local tests = {}

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local program = context:create_program_with_source([[
    __kernel void test(
      __global uint *restrict d_buf,
      uint value)
    {
      const size_t gid = get_global_id(0);
      d_buf[gid] = (gid + 1) * value;
    }
  ]])
  program:build()
  local kernel = program:create_kernel("test")
  local N = 2 ^ 10
  local d_buf = context:create_buffer(N * ffi.sizeof("cl_uint"))
  kernel:set_arg(0, d_buf)
  kernel:set_arg(1, ffi.sizeof("cl_uint"), ffi.new("cl_uint[1]", 42))
  queue:enqueue_ndrange_kernel(kernel, nil, {N})
  local buf = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf, true, "read", 0, N * ffi.sizeof("cl_uint")))
  for i = 0, N - 1 do
    assert(buf[i] == 42 * (i + 1))
  end
  queue:enqueue_unmap_mem_object(d_buf, buf)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local program = context:create_program_with_source([[
    __kernel void test(
      __global uint *restrict d_unused,
      __global uint *restrict d_buf)
    {
      const size_t gid = get_global_id(0);
      d_buf[gid] = gid + 1;
    }
  ]])
  program:build()
  local kernel = program:create_kernel("test")
  local N = 2 ^ 10
  local d_buf = context:create_buffer(N * ffi.sizeof("cl_uint"))
  kernel:set_arg(0, nil)
  kernel:set_arg(1, d_buf)
  queue:enqueue_ndrange_kernel(kernel, nil, {N})
  local buf = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf, true, "read", 0, N * ffi.sizeof("cl_uint")))
  for i = 0, N - 1 do
    assert(buf[i] == i + 1)
  end
  queue:enqueue_unmap_mem_object(d_buf, buf)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local program = context:create_program_with_source([[
    __kernel void test(
      volatile __local uint *restrict l_buf,
      __global uint *restrict d_buf,
      ulong N)
    {
      const size_t gid = get_global_id(0);
      const size_t lid = get_local_id(0);
      l_buf[lid] = gid + 1;
      barrier(CLK_LOCAL_MEM_FENCE);
      if (gid < N) d_buf[gid] = l_buf[lid];
    }
  ]])
  program:build()
  local kernel = program:create_kernel("test")
  local N = 12345
  local d_buf = context:create_buffer(N * ffi.sizeof("cl_uint"))
  local work_size = kernel:get_work_group_info(device, "work_group_size")
  local glob_size = math.ceil(N / work_size) * work_size
  kernel:set_arg(0, work_size * ffi.sizeof("cl_uint"))
  kernel:set_arg(1, d_buf)
  kernel:set_arg(2, ffi.new("cl_ulong[1]", N))
  queue:enqueue_ndrange_kernel(kernel, nil, {glob_size}, {work_size})
  local buf = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf, true, "read", 0, N * ffi.sizeof("cl_uint")))
  for i = 0, N - 1 do
    assert(buf[i] == i + 1)
  end
  queue:enqueue_unmap_mem_object(d_buf, buf)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local program = context:create_program_with_source([[
    __kernel void test(
      __global uint *restrict d_buf,
      float param)
    {
    }
  ]])
  program:build()
  local kernel = program:create_kernel("test")
  assert(kernel:get_info("function_name") == "test")
  assert(kernel:get_info("num_args") == 2)
  assert(kernel:get_info("context") == context)
  assert(kernel:get_info("program") == program)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local program = context:create_program_with_source([[
    __kernel __attribute__((reqd_work_group_size(8, 2, 4)))
    void test(
      __global uint *restrict d_buf)
    {
    }
  ]])
  program:build()
  local kernel = program:create_kernel("test")
  assert(kernel:get_work_group_info(device, "global_work_size") == nil)
  assert(kernel:get_work_group_info(device, "work_group_size") >= 1)
  local compile_work_group_size = kernel:get_work_group_info(device, "compile_work_group_size")
  assert(#compile_work_group_size == 3)
  assert(compile_work_group_size[1] == 8)
  assert(compile_work_group_size[2] == 2)
  assert(compile_work_group_size[3] == 4)
  assert(kernel:get_work_group_info(device, "local_mem_size") == 0)
  assert(kernel:get_work_group_info(device, "preferred_work_group_size_multiple") >= 1)
  assert(kernel:get_work_group_info(device, "private_mem_size") == 0)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local program = context:create_program_with_source([[
    __kernel void test1(__global uint *restrict d_buf)
    {
    }

    __kernel void test2(__global uint *restrict d_buf)
    {
    }
  ]])
  program:build()
  local kernels = program:create_kernels_in_program()
  table.sort(kernels, function(a, b) return a:get_info("function_name") < b:get_info("function_name") end)
  assert(#kernels == 2)
  assert(kernels[1]:get_info("function_name") == "test1")
  assert(kernels[2]:get_info("function_name") == "test2")
end)

table.insert(tests, function(device)
  if device:get_info("version"):match("^OpenCL 1%.[01] ") then return end

  local context = cl.create_context({device})
  local program = context:create_program_with_source([[
    __kernel void test(
      __global int *restrict d_position,
      __constant uint *restrict d_velocity,
      __local volatile float *restrict l_force,
      ulong N)
    {
    }
  ]])
  program:build()
  local kernel = program:create_kernel("test")

  assert(kernel:get_arg_info(0, "name") == "d_position")
  assert(kernel:get_arg_info(0, "address_qualifier") == "global")
  assert(kernel:get_arg_info(0, "access_qualifier") == nil)
  assert(kernel:get_arg_info(0, "type_name") == "int*")
  local type_qualifier = kernel:get_arg_info(0, "type_qualifier")
  assert(type_qualifier.const == nil)
  assert(type_qualifier.restrict == true)
  assert(type_qualifier.volatile == nil)

  assert(kernel:get_arg_info(1, "name") == "d_velocity")
  assert(kernel:get_arg_info(1, "address_qualifier") == "constant")
  assert(kernel:get_arg_info(1, "access_qualifier") == nil)
  assert(kernel:get_arg_info(1, "type_name") == "uint*")
  local type_qualifier = kernel:get_arg_info(1, "type_qualifier")
  assert(type_qualifier.const == true)
  assert(type_qualifier.restrict == true)
  assert(type_qualifier.volatile == nil)

  assert(kernel:get_arg_info(2, "name") == "l_force")
  assert(kernel:get_arg_info(2, "address_qualifier") == "local")
  assert(kernel:get_arg_info(2, "access_qualifier") == nil)
  assert(kernel:get_arg_info(2, "type_name") == "float*")
  local type_qualifier = kernel:get_arg_info(2, "type_qualifier")
  assert(type_qualifier.const == nil)
  assert(type_qualifier.restrict == true)
  assert(type_qualifier.volatile == true)

  assert(kernel:get_arg_info(3, "name") == "N")
  assert(kernel:get_arg_info(3, "address_qualifier") == "private")
  assert(kernel:get_arg_info(3, "access_qualifier") == nil)
  assert(kernel:get_arg_info(3, "type_name") == "ulong")
  local type_qualifier = kernel:get_arg_info(3, "type_qualifier")
  assert(type_qualifier.const == nil)
  assert(type_qualifier.restrict == nil)
  assert(type_qualifier.volatile == nil)
end)

test.test_devices(tests)
