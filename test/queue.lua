------------------------------------------------------------------------------
-- Test command queues.
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
  assert(queue:get_info("context") == context)
  assert(queue:get_info("device") == device)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local properties = queue:get_info("properties")
  assert(properties.out_of_order_exec_mode == nil)
  assert(properties.profiling == nil)
end)

table.insert(tests, function(device)
  if not device:get_info("queue_properties").out_of_order_exec_mode then return end
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device, "out_of_order_exec_mode")
  local properties = queue:get_info("properties")
  assert(properties.out_of_order_exec_mode == true)
  assert(properties.profiling == nil)
end)

table.insert(tests, function(device)
  if not device:get_info("queue_properties").profiling then return end
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device, "profiling")
  local properties = queue:get_info("properties")
  assert(properties.out_of_order_exec_mode == nil)
  assert(properties.profiling == true)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local program = context:create_program_with_source([[
  __kernel void test(__global uint *restrict d_buf)
  {
    const size_t gid = get_global_id(0);
    d_buf[gid] = gid + 1;
  }
  ]])
  program:build()
  local kernel = program:create_kernel("test")
  local N = 2 ^ 10
  local d_buf = context:create_buffer(N * ffi.sizeof("cl_uint"))
  kernel:set_arg(0, d_buf)
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
  __kernel void test(__global uint *restrict d_buf, ulong N)
  {
    const size_t gid = get_global_id(0);
    if (gid <= N) d_buf[gid - 1] = gid;
  }
  ]])
  program:build()
  local kernel = program:create_kernel("test")
  local N = 12345
  local d_buf = context:create_buffer(N * ffi.sizeof("cl_uint"))
  local work_size = kernel:get_work_group_info(device, "work_group_size")
  local glob_size = math.ceil(N / work_size) * work_size
  kernel:set_arg(0, d_buf)
  kernel:set_arg(1, ffi.sizeof("cl_ulong"), ffi.new("cl_ulong[1]", N))
  queue:enqueue_ndrange_kernel(kernel, {1}, {glob_size}, {work_size})
  local buf = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf, true, "read", 0, N * ffi.sizeof("cl_uint")))
  for i = 0, N - 1 do
    assert(buf[i] == i + 1)
  end
  queue:enqueue_unmap_mem_object(d_buf, buf)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local N = 2 ^ 10
  local d_buf = context:create_buffer(N * ffi.sizeof("cl_uint"))
  local buf = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf, true, "write", 0, N * ffi.sizeof("cl_uint")))
  for i = 0, N - 1 do
    buf[i] = i + 1
  end
  queue:enqueue_unmap_mem_object(d_buf, buf)
  local buf = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf, true, "read", 0, N * ffi.sizeof("cl_uint")))
  for i = 0, N - 1 do
    assert(buf[i] == i + 1)
  end
  queue:enqueue_unmap_mem_object(d_buf, buf)
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local N = 2 ^ 10
  local d_buf = context:create_buffer(N * ffi.sizeof("cl_uint"))
  local buf1 = ffi.new("cl_uint[?]", N)
  local buf2 = ffi.new("cl_uint[?]", N)
  for i = 0, N - 1 do
    buf1[i] = i + 1
  end
  queue:enqueue_write_buffer(d_buf, true, buf1)
  queue:enqueue_read_buffer(d_buf, true, buf2)
  for i = 0, N - 1 do
    assert(buf2[i] == i + 1)
  end
  queue:enqueue_write_buffer(d_buf, true, N / 2 * ffi.sizeof("cl_uint"), N / 2 * ffi.sizeof("cl_uint"), buf1)
  queue:enqueue_read_buffer(d_buf, true, nil, nil, buf2)
  for i = 0, N / 2 - 1 do
    assert(buf2[i] == i + 1)
  end
  for i = N / 2, N - 1 do
    assert(buf2[i] == i + 1 - N / 2)
  end
  queue:enqueue_write_buffer(d_buf, true, nil, nil, buf1)
  queue:enqueue_read_buffer(d_buf, true, N / 2 * ffi.sizeof("cl_uint"), N / 2 * ffi.sizeof("cl_uint"), buf2)
  for i = 0, N / 2 - 1 do
    assert(buf2[i] == i + 1 + N / 2)
  end
  for i = N / 2, N - 1 do
    assert(buf2[i] == i + 1 - N / 2)
  end
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local N1 = 2 ^ 10
  local d_buf1 = context:create_buffer(N1 * ffi.sizeof("cl_uint"))
  local buf1 = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf1, true, "write", 0, N1 * ffi.sizeof("cl_uint")))
  for i = 0, N1 - 1 do
    buf1[i] = i + 1
  end
  queue:enqueue_unmap_mem_object(d_buf1, buf1)
  local N2 = 2 ^ 9
  local d_buf2 = context:create_buffer(N2 * ffi.sizeof("cl_uint"))
  queue:enqueue_copy_buffer(d_buf1, d_buf2, (N1 - N2) * ffi.sizeof("cl_uint"), 0, N2 * ffi.sizeof("cl_uint"))
  local buf2 = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf2, true, "read", 0, N2 * ffi.sizeof("cl_uint")))
  for i = 0, N2 - 1 do
    assert(buf2[i] == N2 + i + 1)
  end
  queue:enqueue_unmap_mem_object(d_buf2, buf2)
  local d_buf3 = context:create_buffer(N1 * ffi.sizeof("cl_uint"))
  queue:enqueue_copy_buffer(d_buf1, d_buf3)
  local buf3 = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf3, true, "read", 0, N1 * ffi.sizeof("cl_uint")))
  for i = 0, N1 - 1 do
    assert(buf3[i] == i + 1)
  end
  queue:enqueue_unmap_mem_object(d_buf3, buf3)
end)

table.insert(tests, function(device)
  if device:get_info("version"):match("^OpenCL 1%.[01] ") then return end
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device, "profiling")
  local N = 2 ^ 10
  local d_buf = context:create_buffer(N * ffi.sizeof("cl_uint"))
  local pattern = 0xfe654321
  queue:enqueue_fill_buffer(d_buf, ffi.new("cl_uint[1]", pattern), ffi.sizeof("cl_uint"))
  local buf = ffi.cast("cl_uint *", queue:enqueue_map_buffer(d_buf, true, "read", 0, N * ffi.sizeof("cl_uint")))
  for i = 0, N - 1 do
    assert(buf[i] == pattern)
  end
  queue:enqueue_unmap_mem_object(d_buf, buf)
end)

table.insert(tests, function(device)
  if device:get_info("version"):match("^OpenCL 1%.[01] ") then return end
  local context = cl.create_context({device})
  local queue1 = context:create_command_queue(device)
  local queue2 = context:create_command_queue(device)
  local queue3 = context:create_command_queue(device)
  local N = 2 ^ 20
  local d_buf1 = context:create_buffer(N)
  local d_buf2 = context:create_buffer(N)
  local d_buf3 = context:create_buffer(N)
  local event1 = queue1:enqueue_copy_buffer(d_buf1, d_buf2, 0, 0, N)
  queue1:flush()
  local event2 = queue2:enqueue_marker_with_wait_list({event1})
  queue2:flush()
  queue3:enqueue_copy_buffer(d_buf1, d_buf2, 0, 0, N, {event2})
  queue3:finish()
end)

table.insert(tests, function(device)
  if device:get_info("version"):match("^OpenCL 1%.[01] ") then return end
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local N = 2 ^ 20
  local d_buf1 = context:create_buffer(N)
  local d_buf2 = context:create_buffer(N)
  queue:enqueue_copy_buffer(d_buf1, d_buf2, 0, 0, N)
  local event = queue:enqueue_marker_with_wait_list()
  cl.wait_for_events({event})
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local N = 2 ^ 20
  local d_buf1 = context:create_buffer(N)
  local d_buf2 = context:create_buffer(N)
  queue:enqueue_copy_buffer(d_buf1, d_buf2, 0, 0, N)
  local event = queue:enqueue_marker()
  cl.wait_for_events({event})
end)

table.insert(tests, function(device)
  if device:get_info("version"):match("^OpenCL 1%.[01] ") then return end
  local context = cl.create_context({device})
  local queue1 = context:create_command_queue(device)
  local queue2 = context:create_command_queue(device)
  local N = 2 ^ 20
  local d_buf1 = context:create_buffer(N)
  local d_buf2 = context:create_buffer(N)
  local d_buf3 = context:create_buffer(N)
  local event1 = queue1:enqueue_copy_buffer(d_buf1, d_buf2, 0, 0, N)
  queue1:flush()
  queue2:enqueue_barrier_with_wait_list({event1})
  queue2:enqueue_copy_buffer(d_buf2, d_buf3, 0, 0, N)
  queue2:finish()
end)

table.insert(tests, function(device)
  if device:get_info("version"):match("^OpenCL 1%.[01] ") then return end
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  local event = queue:enqueue_barrier_with_wait_list()
  cl.wait_for_events({event})
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device)
  queue:enqueue_barrier()
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue1 = context:create_command_queue(device)
  local queue2 = context:create_command_queue(device)
  local N = 2 ^ 20
  local d_buf1 = context:create_buffer(N)
  local d_buf2 = context:create_buffer(N)
  local event = queue1:enqueue_copy_buffer(d_buf1, d_buf2, 0, 0, N)
  queue2:enqueue_wait_for_events({event})
  queue2:finish()
  assert(event:get_info("command_execution_status") == "complete")
end)

table.insert(tests, function(device)
  local context = cl.create_context({device})
  local queue1 = context:create_command_queue(device)
  local queue2 = context:create_command_queue(device)
  local N = 2 ^ 20
  local d_buf1 = context:create_buffer(N)
  local d_buf2 = context:create_buffer(N)
  local d_buf3 = context:create_buffer(N)
  local event1 = queue1:enqueue_copy_buffer(d_buf1, d_buf2, 0, 0, N)
  queue1:flush()
  queue2:enqueue_copy_buffer(d_buf2, d_buf3, 0, 0, N, {event1})
  queue2:finish()
end)

test.test_devices(tests)
