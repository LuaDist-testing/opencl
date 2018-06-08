------------------------------------------------------------------------------
-- Test devices.
-- Copyright © 2013–2014 Peter Colberg.
-- For conditions of distribution and use, see copyright notice in LICENSE.
------------------------------------------------------------------------------

require("strict")

pcall(require, "luacov")

local cl = require("opencl")
local test = require("test")

local tests = {}

table.insert(tests, function(device)
  local properties = device:get_info("partition_properties")
  if not properties or not properties.equally then return end
  local max_sub_devices = device:get_info("partition_max_sub_devices")
  local sub_devices = device:create_sub_devices("equally", 1)
  assert(#sub_devices == max_sub_devices)
  for _, sub_device in ipairs(sub_devices) do
    assert(sub_device:get_info("parent_device") == device)
    assert(sub_device:get_info("max_compute_units") == 1)
    local name, value = sub_device:get_info("partition_type")
    assert(name == "equally")
    assert(value == 1)
  end
end)

table.insert(tests, function(device)
  local properties = device:get_info("partition_properties")
  if not properties or not properties.by_counts then return end
  local max_sub_devices = device:get_info("partition_max_sub_devices")
  local counts = {}
  for i = 1, max_sub_devices do
    counts[i] = 1
  end
  local sub_devices = device:create_sub_devices("by_counts", counts)
  assert(#sub_devices == max_sub_devices)
  for _, sub_device in ipairs(sub_devices) do
    assert(sub_device:get_info("parent_device") == device)
    assert(sub_device:get_info("max_compute_units") == 1)
    local name, value = sub_device:get_info("partition_type")
    assert(name == "by_counts")
    for i = 1, #counts do
      assert(value[i] == counts[i])
    end
  end
end)

table.insert(tests, function(device)
  local properties = device:get_info("partition_properties")
  if not properties or not properties.by_affinity_domain then return end
  local affinity_domain = device:get_info("partition_affinity_domain")
  for domain, _ in pairs(affinity_domain) do
    local sub_devices = device:create_sub_devices("by_affinity_domain", domain)
    assert(#sub_devices >= 1)
    for _, sub_device in ipairs(sub_devices) do
      assert(sub_device:get_info("parent_device") == device)
      local name, value = sub_device:get_info("partition_type")
      assert(name == "by_affinity_domain")
      assert(affinity_domain[value] == true)
    end
  end
end)

table.insert(tests, function(device)
  assert(type(device:get_info("address_bits")) == "number")
  assert(type(device:get_info("available")) == "boolean")
  assert(type(device:get_info("built_in_kernels") or "") == "string")
  assert(type(device:get_info("compiler_available")) == "boolean")
  assert(type(device:get_info("double_fp_config") or {}) == "table")
  assert(type(device:get_info("endian_little")) == "boolean")
  assert(type(device:get_info("error_correction_support")) == "boolean")
  assert(type(device:get_info("execution_capabilities") == "table"))
  assert(type(device:get_info("extensions")) == "string")
  assert(type(device:get_info("global_mem_cache_size") or 0) == "number")
  assert(type(device:get_info("global_mem_cache_type") or "") == "string")
  assert(type(device:get_info("global_mem_cacheline_size") or 0) == "number")
  assert(type(device:get_info("global_mem_size")) == "number")
  assert(type(device:get_info("half_fp_config") or {}) == "table")
  assert(type(device:get_info("host_unified_memory") or false) == "boolean")
  assert(type(device:get_info("image_support")) == "boolean")
  assert(type(device:get_info("image2d_max_height")) == "number")
  assert(type(device:get_info("image2d_max_width")) == "number")
  assert(type(device:get_info("image3d_max_depth")) == "number")
  assert(type(device:get_info("image3d_max_height")) == "number")
  assert(type(device:get_info("image3d_max_width")) == "number")
  assert(type(device:get_info("image_max_buffer_size") or 0) == "number")
  assert(type(device:get_info("image_max_array_size") or 0) == "number")
  assert(type(device:get_info("linker_available") or false) == "boolean")
  assert(type(device:get_info("local_mem_size")) == "number")
  assert(type(device:get_info("local_mem_type")) == "string")
  assert(type(device:get_info("max_clock_frequency")) == "number")
  assert(type(device:get_info("max_compute_units")) == "number")
  assert(type(device:get_info("max_constant_args")) == "number")
  assert(type(device:get_info("max_constant_buffer_size")) == "number")
  assert(type(device:get_info("max_mem_alloc_size")) == "number")
  assert(type(device:get_info("max_parameter_size")) == "number")
  assert(type(device:get_info("max_read_image_args")) == "number")
  assert(type(device:get_info("max_samplers")) == "number")
  assert(type(device:get_info("max_work_group_size")) == "number")
  assert(type(device:get_info("max_work_item_dimensions")) == "number")
  assert(type(device:get_info("max_work_item_sizes")) == "table")
  assert(type(device:get_info("max_write_image_args")) == "number")
  assert(type(device:get_info("mem_base_addr_align")) == "number")
  assert(type(device:get_info("min_data_type_align_size")) == "number")
  assert(type(device:get_info("name")) == "string")
  assert(type(device:get_info("native_vector_width_char") or 0) == "number")
  assert(type(device:get_info("native_vector_width_short") or 0) == "number")
  assert(type(device:get_info("native_vector_width_int") or 0) == "number")
  assert(type(device:get_info("native_vector_width_long") or 0) == "number")
  assert(type(device:get_info("native_vector_width_float") or 0) == "number")
  assert(type(device:get_info("native_vector_width_double") or 0) == "number")
  assert(type(device:get_info("native_vector_width_half") or 0) == "number")
  assert(type(device:get_info("opencl_c_version") or "") == "string")
  assert(device:get_info("parent_device") == nil)
  assert(type(device:get_info("partition_max_sub_devices") or 0) == "number")
  assert(type(device:get_info("partition_properties") or {}) == "table")
  assert(type(device:get_info("partition_affinity_domain") or {}) == "table")
  assert(device:get_info("partition_type") == nil)
  assert(device:get_info("platform") ~= nil)
  assert(type(device:get_info("preferred_interop_user_sync") or false) == "boolean")
  assert(type(device:get_info("preferred_vector_width_char")) == "number")
  assert(type(device:get_info("preferred_vector_width_short")) == "number")
  assert(type(device:get_info("preferred_vector_width_int")) == "number")
  assert(type(device:get_info("preferred_vector_width_long")) == "number")
  assert(type(device:get_info("preferred_vector_width_float")) == "number")
  assert(type(device:get_info("preferred_vector_width_double") or 0) == "number")
  assert(type(device:get_info("preferred_vector_width_half") or 0) == "number")
  assert(type(device:get_info("printf_buffer_size") or 0) == "number")
  assert(type(device:get_info("profile")) == "string")
  assert(type(device:get_info("profiling_timer_resolution")) == "number")
  assert(type(device:get_info("queue_properties") == "table"))
  assert(type(device:get_info("single_fp_config") == "table"))
  assert(type(device:get_info("type") == "table"))
  assert(type(device:get_info("vendor")) == "string")
  assert(type(device:get_info("vendor_id")) == "number")
  assert(type(device:get_info("version")) == "string")
  assert(type(device:get_info("driver_version")) == "string")
end)

test.test_devices(tests)
