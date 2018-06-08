------------------------------------------------------------------------------
-- Test memory objects.
-- Copyright © 2013–2014 Peter Colberg.
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
  local N = 2048
  local d_buf = context:create_buffer(N * ffi.sizeof("cl_int"))
  assert(d_buf:get_info("type") == "buffer")
  assert(d_buf:get_info("size") == N * ffi.sizeof("cl_int"))
  assert(d_buf:get_info("host_ptr") == nil)
  assert(d_buf:get_info("map_count") == 0)
  assert(d_buf:get_info("context") == context)
  assert(d_buf:get_info("associated_memobject") == nil)
  assert(d_buf:get_info("offset") == nil)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local N1 = 2048
  local d_buf1 = context:create_buffer(N1 * ffi.sizeof("cl_int"))
  local N2 = 1024
  local d_buf2 = d_buf1:create_sub_buffer("region", {0, N2 * ffi.sizeof("cl_int")})
  assert(d_buf2:get_info("type") == "buffer")
  assert(d_buf2:get_info("size") == N2 * ffi.sizeof("cl_int"))
  assert(d_buf2:get_info("host_ptr") == nil)
  assert(d_buf2:get_info("map_count") == 0)
  assert(d_buf2:get_info("context") == context)
  assert(d_buf2:get_info("associated_memobject") == d_buf1)
  assert(d_buf2:get_info("offset") == 0)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local d_buf = context:create_buffer("read_write", 1024)
  local flags = d_buf:get_info("flags")
  assert(flags.read_write == true)
  assert(flags.write_only == nil)
  assert(flags.read_only == nil)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local d_buf = context:create_buffer("write_only", 1024)
  local flags = d_buf:get_info("flags")
  assert(flags.read_write == nil)
  assert(flags.write_only == true)
  assert(flags.read_only == nil)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local d_buf = context:create_buffer("read_only", 1024)
  local flags = d_buf:get_info("flags")
  assert(flags.read_write == nil)
  assert(flags.write_only == nil)
  assert(flags.read_only == true)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local buf = ffi.new("char[?]", 1024)
  local d_buf = context:create_buffer({"read_write", "use_host_ptr"}, 1024, buf)
  local flags = d_buf:get_info("flags")
  assert(flags.read_write == true)
  assert(flags.use_host_ptr == true)
  assert(d_buf:get_info("host_ptr") == buf)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local d_buf = context:create_buffer({"read_write", "alloc_host_ptr"}, 1024)
  local flags = d_buf:get_info("flags")
  assert(flags.read_write == true)
  assert(flags.alloc_host_ptr == true)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local N = 1024
  local buf = ffi.new("cl_int[?]", N)
  for i = 0, N - 1 do
    buf[i] = N - i
  end
  local d_buf = context:create_buffer("copy_host_ptr", N * ffi.sizeof("cl_int"), buf)
  local flags = d_buf:get_info("flags")
  assert(flags.copy_host_ptr == true)
  local ptr = ffi.cast("cl_int *", queue:enqueue_map_buffer(d_buf, true, "read", 0, N * ffi.sizeof("cl_int")))
  for i = 0, N - 1 do
    assert(ptr[i] == N - i)
  end
  queue:enqueue_unmap_mem_object(d_buf, ptr)
end)

table.insert(tests, function(device)
  if device:get_info("version"):match("^OpenCL 1%.[01] ") then return end
  local context = cl.create_context({device})
  local d_buf = context:create_buffer("host_write_only", 1024)
  local flags = d_buf:get_info("flags")
  assert(flags.host_write_only == true)
  assert(flags.host_read_only == nil)
  assert(flags.host_no_access == nil)
end)

table.insert(tests, function(device)
  if device:get_info("version"):match("^OpenCL 1%.[01] ") then return end
  local context = cl.create_context({device})
  local d_buf = context:create_buffer("host_read_only", 1024)
  local flags = d_buf:get_info("flags")
  assert(flags.host_write_only == nil)
  assert(flags.host_read_only == true)
  assert(flags.host_no_access == nil)
end)

table.insert(tests, function(device)
  if device:get_info("version"):match("^OpenCL 1%.[01] ") then return end
  local context = cl.create_context({device})
  local d_buf = context:create_buffer("host_no_access", 1024)
  local flags = d_buf:get_info("flags")
  assert(flags.host_write_only == nil)
  assert(flags.host_read_only == nil)
  assert(flags.host_no_access == true)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local N = 2048
  local d_buf1 = context:create_buffer(N * ffi.sizeof("cl_int"))
  local ptr = ffi.cast("cl_int *", queue:enqueue_map_buffer(d_buf1, true, "write", 0, N * ffi.sizeof("cl_int")))
  for i = 0, N - 1 do
    ptr[i] = i + 1
  end
  queue:enqueue_unmap_mem_object(d_buf1, ptr)
  local region = {0, N / 2 * ffi.sizeof("cl_int")}
  local d_buf2 = d_buf1:create_sub_buffer("region", region)
  local ptr = ffi.cast("cl_int *", queue:enqueue_map_buffer(d_buf2, true, "read", 0, N / 2 * ffi.sizeof("cl_int")))
  for i = 0, N / 2 - 1 do
    assert(ptr[i] == i + 1)
  end
  queue:enqueue_unmap_mem_object(d_buf2, ptr)
  local region = {N / 2 * ffi.sizeof("cl_int"), N / 2 * ffi.sizeof("cl_int")}
  local d_buf2 = d_buf1:create_sub_buffer("read_only", "region", region)
  local ptr = ffi.cast("cl_int *", queue:enqueue_map_buffer(d_buf2, true, "read", 0, N / 2 * ffi.sizeof("cl_int")))
  for i = 0, N / 2 - 1 do
    assert(ptr[i] == N / 2 + i + 1)
  end
  queue:enqueue_unmap_mem_object(d_buf2, ptr)
end)

test.test_devices(tests)
