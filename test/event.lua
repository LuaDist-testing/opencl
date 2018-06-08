------------------------------------------------------------------------------
-- Test events.
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
  local size = 2 ^ 20
  local d_buf1 = context:create_buffer(size)
  local d_buf2 = context:create_buffer(size)
  local event = queue:enqueue_copy_buffer(d_buf1, d_buf2, 0, 0, size)
  cl.wait_for_events({event})
  assert(event:get_info("command_queue") == queue)
  assert(event:get_info("context") == context)
  assert(event:get_info("command_type") == "copy_buffer")
  assert(event:get_info("command_execution_status") == "complete")
end)

table.insert(tests, function(device)
  if not device:get_info("queue_properties").profiling then return end
  local context = cl.create_context({device})
  local queue = context:create_command_queue(device, "profiling")
  local size = 2 ^ 20
  local d_buf1 = context:create_buffer(size)
  local d_buf2 = context:create_buffer(size)
  local event = queue:enqueue_copy_buffer(d_buf1, d_buf2, 0, 0, size)
  cl.wait_for_events({event})
  assert(ffi.istype("cl_ulong", event:get_profiling_info("queued")))
  assert(ffi.istype("cl_ulong", event:get_profiling_info("submit")))
  assert(ffi.istype("cl_ulong", event:get_profiling_info("start")))
  assert(ffi.istype("cl_ulong", event:get_profiling_info("end")))
end)

test.test_devices(tests)
