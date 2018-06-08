/*
 * OpenCL for Lua.
 * Copyright © 2013–2014 Peter Colberg.
 * Distributed under the MIT license. (See accompanying file LICENSE.)
 */

#ifdef __APPLE__
#include <OpenCL/opencl.h>
#else
#include <CL/opencl.h>
#endif

#include "ffi-cdecl.h"
#include "ffi-cdecl-luajit.h"

cdecl_typealias(cl_char, int8_t)
cdecl_typealias(cl_uchar, uint8_t)
cdecl_typealias(cl_short, int16_t)
cdecl_typealias(cl_ushort, uint16_t)
cdecl_typealias(cl_int, int32_t)
cdecl_typealias(cl_uint, uint32_t)
cdecl_typealias(cl_long, int64_t)
cdecl_typealias(cl_ulong, uint64_t)

cdecl_typealias(cl_half, uint16_t)
cdecl_type(cl_float)
cdecl_type(cl_double)

cdecl_type(cl_GLuint)
cdecl_type(cl_GLint)
cdecl_type(cl_GLenum)

#ifdef __CL_CHAR2__
cdecl_typealias(__cl_char2, cl_char)
#endif
#ifdef __CL_CHAR4__
cdecl_typealias(__cl_char4, cl_char)
#endif
#ifdef __CL_CHAR8__
cdecl_typealias(__cl_char8, cl_char)
#endif
#ifdef __CL_CHAR16__
cdecl_typealias(__cl_char16, cl_char)
#endif
#ifdef __CL_DOUBLE2__
cdecl_typealias(__cl_double2, cl_double)
#endif
#ifdef __CL_DOUBLE4__
cdecl_typealias(__cl_double4, cl_double)
#endif
#ifdef __CL_DOUBLE8__
cdecl_typealias(__cl_double8, cl_double)
#endif
#ifdef __CL_DOUBLE16__
cdecl_typealias(__cl_double16, cl_double)
#endif
#ifdef __CL_FLOAT2__
cdecl_typealias(__cl_float2, cl_float)
#endif
#ifdef __CL_FLOAT4__
cdecl_typealias(__cl_float4, cl_float)
#endif
#ifdef __CL_FLOAT8__
cdecl_typealias(__cl_float8, cl_float)
#endif
#ifdef __CL_FLOAT16__
cdecl_typealias(__cl_float16, cl_float)
#endif
#ifdef __CL_INT2__
cdecl_typealias(__cl_int2, cl_int)
#endif
#ifdef __CL_INT4__
cdecl_typealias(__cl_int4, cl_int)
#endif
#ifdef __CL_INT8__
cdecl_typealias(__cl_int8, cl_int)
#endif
#ifdef __CL_INT16__
cdecl_typealias(__cl_int16, cl_int)
#endif
#ifdef __CL_LONG2__
cdecl_typealias(__cl_long2, cl_long)
#endif
#ifdef __CL_LONG4__
cdecl_typealias(__cl_long4, cl_long)
#endif
#ifdef __CL_LONG8__
cdecl_typealias(__cl_long8, cl_long)
#endif
#ifdef __CL_LONG16__
cdecl_typealias(__cl_long16, cl_long)
#endif
#ifdef __CL_SHORT2__
cdecl_typealias(__cl_short2, cl_short)
#endif
#ifdef __CL_SHORT4__
cdecl_typealias(__cl_short4, cl_short)
#endif
#ifdef __CL_SHORT8__
cdecl_typealias(__cl_short8, cl_short)
#endif
#ifdef __CL_SHORT16__
cdecl_typealias(__cl_short16, cl_short)
#endif
#ifdef __CL_UCHAR2__
cdecl_typealias(__cl_uchar2, cl_uchar)
#endif
#ifdef __CL_UCHAR4__
cdecl_typealias(__cl_uchar4, cl_uchar)
#endif
#ifdef __CL_UCHAR8__
cdecl_typealias(__cl_uchar8, cl_uchar)
#endif
#ifdef __CL_UCHAR16__
cdecl_typealias(__cl_uchar16, cl_uchar)
#endif
#ifdef __CL_UINT2__
cdecl_typealias(__cl_uint2, cl_uint)
#endif
#ifdef __CL_UINT4__
cdecl_typealias(__cl_uint4, cl_uint)
#endif
#ifdef __CL_UINT8__
cdecl_typealias(__cl_uint8, cl_uint)
#endif
#ifdef __CL_UINT16__
cdecl_typealias(__cl_uint16, cl_uint)
#endif
#ifdef __CL_ULONG2__
cdecl_typealias(__cl_ulong2, cl_ulong)
#endif
#ifdef __CL_ULONG4__
cdecl_typealias(__cl_ulong4, cl_ulong)
#endif
#ifdef __CL_ULONG8__
cdecl_typealias(__cl_ulong8, cl_ulong)
#endif
#ifdef __CL_ULONG16__
cdecl_typealias(__cl_ulong16, cl_ulong)
#endif
#ifdef __CL_USHORT2__
cdecl_typealias(__cl_ushort2, cl_ushort)
#endif
#ifdef __CL_USHORT4__
cdecl_typealias(__cl_ushort4, cl_ushort)
#endif
#ifdef __CL_USHORT8__
cdecl_typealias(__cl_ushort8, cl_ushort)
#endif
#ifdef __CL_USHORT16__
cdecl_typealias(__cl_ushort16, cl_ushort)
#endif

cdecl_type(cl_char2)
cdecl_memb(cl_char2)
cdecl_type(cl_char4)
cdecl_memb(cl_char4)
cdecl_type(cl_char3)
cdecl_type(cl_char8)
cdecl_memb(cl_char8)
cdecl_type(cl_char16)
cdecl_memb(cl_char16)
cdecl_type(cl_uchar2)
cdecl_memb(cl_uchar2)
cdecl_type(cl_uchar4)
cdecl_memb(cl_uchar4)
cdecl_type(cl_uchar3)
cdecl_type(cl_uchar8)
cdecl_memb(cl_uchar8)
cdecl_type(cl_uchar16)
cdecl_memb(cl_uchar16)
cdecl_type(cl_short2)
cdecl_memb(cl_short2)
cdecl_type(cl_short4)
cdecl_memb(cl_short4)
cdecl_type(cl_short3)
cdecl_type(cl_short8)
cdecl_memb(cl_short8)
cdecl_type(cl_short16)
cdecl_memb(cl_short16)
cdecl_type(cl_ushort2)
cdecl_memb(cl_ushort2)
cdecl_type(cl_ushort4)
cdecl_memb(cl_ushort4)
cdecl_type(cl_ushort3)
cdecl_type(cl_ushort8)
cdecl_memb(cl_ushort8)
cdecl_type(cl_ushort16)
cdecl_memb(cl_ushort16)
cdecl_type(cl_int2)
cdecl_memb(cl_int2)
cdecl_type(cl_int4)
cdecl_memb(cl_int4)
cdecl_type(cl_int3)
cdecl_type(cl_int8)
cdecl_memb(cl_int8)
cdecl_type(cl_int16)
cdecl_memb(cl_int16)
cdecl_type(cl_uint2)
cdecl_memb(cl_uint2)
cdecl_type(cl_uint4)
cdecl_memb(cl_uint4)
cdecl_type(cl_uint3)
cdecl_type(cl_uint8)
cdecl_memb(cl_uint8)
cdecl_type(cl_uint16)
cdecl_memb(cl_uint16)
cdecl_type(cl_long2)
cdecl_memb(cl_long2)
cdecl_type(cl_long4)
cdecl_memb(cl_long4)
cdecl_type(cl_long3)
cdecl_type(cl_long8)
cdecl_memb(cl_long8)
cdecl_type(cl_long16)
cdecl_memb(cl_long16)
cdecl_type(cl_ulong2)
cdecl_memb(cl_ulong2)
cdecl_type(cl_ulong4)
cdecl_memb(cl_ulong4)
cdecl_type(cl_ulong3)
cdecl_type(cl_ulong8)
cdecl_memb(cl_ulong8)
cdecl_type(cl_ulong16)
cdecl_memb(cl_ulong16)
cdecl_type(cl_float2)
cdecl_memb(cl_float2)
cdecl_type(cl_float4)
cdecl_memb(cl_float4)
cdecl_type(cl_float3)
cdecl_type(cl_float8)
cdecl_memb(cl_float8)
cdecl_type(cl_float16)
cdecl_memb(cl_float16)
cdecl_type(cl_double2)
cdecl_memb(cl_double2)
cdecl_type(cl_double4)
cdecl_memb(cl_double4)
cdecl_type(cl_double3)
cdecl_type(cl_double8)
cdecl_memb(cl_double8)
cdecl_type(cl_double16)
cdecl_memb(cl_double16)

cdecl_type(cl_platform_id)
cdecl_type(cl_device_id)
cdecl_type(cl_context)
cdecl_type(cl_command_queue)
cdecl_type(cl_mem)
cdecl_type(cl_program)
cdecl_type(cl_kernel)
cdecl_type(cl_event)
cdecl_type(cl_sampler)

cdecl_typealias(cl_bool, cl_uint)
cdecl_typealias(cl_bitfield, cl_ulong)
cdecl_typealias(cl_device_type, cl_bitfield)
cdecl_typealias(cl_platform_info, cl_uint)
cdecl_typealias(cl_device_info, cl_uint)
cdecl_typealias(cl_device_fp_config, cl_bitfield)
cdecl_typealias(cl_device_mem_cache_type, cl_uint)
cdecl_typealias(cl_device_local_mem_type, cl_uint)
cdecl_typealias(cl_device_exec_capabilities, cl_bitfield)
cdecl_typealias(cl_command_queue_properties, cl_bitfield)
#if CL_VERSION_1_2
cdecl_typealias(cl_device_partition_property, intptr_t)
cdecl_typealias(cl_device_affinity_domain, cl_bitfield)
#endif

cdecl_typealias(cl_context_properties, intptr_t)
cdecl_typealias(cl_context_info, cl_uint)
cdecl_typealias(cl_command_queue_info, cl_uint)
cdecl_typealias(cl_channel_order, cl_uint)
cdecl_typealias(cl_channel_type, cl_uint)
cdecl_typealias(cl_mem_flags, cl_bitfield)
cdecl_typealias(cl_mem_object_type, cl_uint)
cdecl_typealias(cl_mem_info, cl_uint)
#if CL_VERSION_1_2
cdecl_typealias(cl_mem_migration_flags, cl_bitfield)
#endif
cdecl_typealias(cl_image_info, cl_uint)
#if CL_VERSION_1_1
cdecl_typealias(cl_buffer_create_type, cl_uint)
#endif
cdecl_typealias(cl_addressing_mode, cl_uint)
cdecl_typealias(cl_filter_mode, cl_uint)
cdecl_typealias(cl_sampler_info, cl_uint)
cdecl_typealias(cl_map_flags, cl_bitfield)
cdecl_typealias(cl_program_info, cl_uint)
cdecl_typealias(cl_program_build_info, cl_uint)
#if CL_VERSION_1_2
cdecl_typealias(cl_program_binary_type, cl_uint)
#endif
cdecl_typealias(cl_build_status, cl_int)
cdecl_typealias(cl_kernel_info, cl_uint)
#if CL_VERSION_1_2
cdecl_typealias(cl_kernel_arg_info, cl_uint)
cdecl_typealias(cl_kernel_arg_address_qualifier, cl_uint)
cdecl_typealias(cl_kernel_arg_access_qualifier, cl_uint)
cdecl_typealias(cl_kernel_arg_type_qualifier, cl_bitfield)
#endif
cdecl_typealias(cl_kernel_work_group_info, cl_uint)
cdecl_typealias(cl_event_info, cl_uint)
cdecl_typealias(cl_command_type, cl_uint)
cdecl_typealias(cl_profiling_info, cl_uint)

cdecl_type(cl_image_format)
cdecl_memb(cl_image_format)

#if CL_VERSION_1_2
cdecl_type(cl_image_desc)
cdecl_memb(cl_image_desc)
#endif
#if CL_VERSION_1_1
cdecl_type(cl_buffer_region)
cdecl_memb(cl_buffer_region)
#endif

cdecl_const(CL_SUCCESS)
cdecl_const(CL_DEVICE_NOT_FOUND)
cdecl_const(CL_DEVICE_NOT_AVAILABLE)
cdecl_const(CL_COMPILER_NOT_AVAILABLE)
cdecl_const(CL_MEM_OBJECT_ALLOCATION_FAILURE)
cdecl_const(CL_OUT_OF_RESOURCES)
cdecl_const(CL_OUT_OF_HOST_MEMORY)
cdecl_const(CL_PROFILING_INFO_NOT_AVAILABLE)
cdecl_const(CL_MEM_COPY_OVERLAP)
cdecl_const(CL_IMAGE_FORMAT_MISMATCH)
cdecl_const(CL_IMAGE_FORMAT_NOT_SUPPORTED)
cdecl_const(CL_BUILD_PROGRAM_FAILURE)
cdecl_const(CL_MAP_FAILURE)
#if CL_VERSION_1_1
cdecl_const(CL_MISALIGNED_SUB_BUFFER_OFFSET)
cdecl_const(CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST)
#endif
#if CL_VERSION_1_2
cdecl_const(CL_COMPILE_PROGRAM_FAILURE)
cdecl_const(CL_LINKER_NOT_AVAILABLE)
cdecl_const(CL_LINK_PROGRAM_FAILURE)
cdecl_const(CL_DEVICE_PARTITION_FAILED)
cdecl_const(CL_KERNEL_ARG_INFO_NOT_AVAILABLE)
#endif

cdecl_const(CL_INVALID_VALUE)
cdecl_const(CL_INVALID_DEVICE_TYPE)
cdecl_const(CL_INVALID_PLATFORM)
cdecl_const(CL_INVALID_DEVICE)
cdecl_const(CL_INVALID_CONTEXT)
cdecl_const(CL_INVALID_QUEUE_PROPERTIES)
cdecl_const(CL_INVALID_COMMAND_QUEUE)
cdecl_const(CL_INVALID_HOST_PTR)
cdecl_const(CL_INVALID_MEM_OBJECT)
cdecl_const(CL_INVALID_IMAGE_FORMAT_DESCRIPTOR)
cdecl_const(CL_INVALID_IMAGE_SIZE)
cdecl_const(CL_INVALID_SAMPLER)
cdecl_const(CL_INVALID_BINARY)
cdecl_const(CL_INVALID_BUILD_OPTIONS)
cdecl_const(CL_INVALID_PROGRAM)
cdecl_const(CL_INVALID_PROGRAM_EXECUTABLE)
cdecl_const(CL_INVALID_KERNEL_NAME)
cdecl_const(CL_INVALID_KERNEL_DEFINITION)
cdecl_const(CL_INVALID_KERNEL)
cdecl_const(CL_INVALID_ARG_INDEX)
cdecl_const(CL_INVALID_ARG_VALUE)
cdecl_const(CL_INVALID_ARG_SIZE)
cdecl_const(CL_INVALID_KERNEL_ARGS)
cdecl_const(CL_INVALID_WORK_DIMENSION)
cdecl_const(CL_INVALID_WORK_GROUP_SIZE)
cdecl_const(CL_INVALID_WORK_ITEM_SIZE)
cdecl_const(CL_INVALID_GLOBAL_OFFSET)
cdecl_const(CL_INVALID_EVENT_WAIT_LIST)
cdecl_const(CL_INVALID_EVENT)
cdecl_const(CL_INVALID_OPERATION)
cdecl_const(CL_INVALID_GL_OBJECT)
cdecl_const(CL_INVALID_BUFFER_SIZE)
cdecl_const(CL_INVALID_MIP_LEVEL)
cdecl_const(CL_INVALID_GLOBAL_WORK_SIZE)
#if CL_VERSION_1_1
cdecl_const(CL_INVALID_PROPERTY)
#endif
#if CL_VERSION_1_2
cdecl_const(CL_INVALID_IMAGE_DESCRIPTOR)
cdecl_const(CL_INVALID_COMPILER_OPTIONS)
cdecl_const(CL_INVALID_LINKER_OPTIONS)
cdecl_const(CL_INVALID_DEVICE_PARTITION_COUNT)
#endif

cdecl_const(CL_VERSION_1_0)
#if CL_VERSION_1_1
cdecl_const(CL_VERSION_1_1)
#endif
#if CL_VERSION_1_2
cdecl_const(CL_VERSION_1_2)
#endif

cdecl_const(CL_FALSE)
cdecl_const(CL_TRUE)
#if CL_VERSION_1_2
cdecl_const(CL_BLOCKING)
cdecl_const(CL_NON_BLOCKING)
#endif

cdecl_const(CL_PLATFORM_PROFILE)
cdecl_const(CL_PLATFORM_VERSION)
cdecl_const(CL_PLATFORM_NAME)
cdecl_const(CL_PLATFORM_VENDOR)
cdecl_const(CL_PLATFORM_EXTENSIONS)

cdecl_const(CL_DEVICE_TYPE_DEFAULT)
cdecl_const(CL_DEVICE_TYPE_CPU)
cdecl_const(CL_DEVICE_TYPE_GPU)
cdecl_const(CL_DEVICE_TYPE_ACCELERATOR)
#if CL_VERSION_1_2
cdecl_const(CL_DEVICE_TYPE_CUSTOM)
#endif
cdecl_const(CL_DEVICE_TYPE_ALL)

cdecl_const(CL_DEVICE_TYPE)
cdecl_const(CL_DEVICE_VENDOR_ID)
cdecl_const(CL_DEVICE_MAX_COMPUTE_UNITS)
cdecl_const(CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS)
cdecl_const(CL_DEVICE_MAX_WORK_GROUP_SIZE)
cdecl_const(CL_DEVICE_MAX_WORK_ITEM_SIZES)
cdecl_const(CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR)
cdecl_const(CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT)
cdecl_const(CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT)
cdecl_const(CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG)
cdecl_const(CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT)
cdecl_const(CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE)
cdecl_const(CL_DEVICE_MAX_CLOCK_FREQUENCY)
cdecl_const(CL_DEVICE_ADDRESS_BITS)
cdecl_const(CL_DEVICE_MAX_READ_IMAGE_ARGS)
cdecl_const(CL_DEVICE_MAX_WRITE_IMAGE_ARGS)
cdecl_const(CL_DEVICE_MAX_MEM_ALLOC_SIZE)
cdecl_const(CL_DEVICE_IMAGE2D_MAX_WIDTH)
cdecl_const(CL_DEVICE_IMAGE2D_MAX_HEIGHT)
cdecl_const(CL_DEVICE_IMAGE3D_MAX_WIDTH)
cdecl_const(CL_DEVICE_IMAGE3D_MAX_HEIGHT)
cdecl_const(CL_DEVICE_IMAGE3D_MAX_DEPTH)
cdecl_const(CL_DEVICE_IMAGE_SUPPORT)
cdecl_const(CL_DEVICE_MAX_PARAMETER_SIZE)
cdecl_const(CL_DEVICE_MAX_SAMPLERS)
cdecl_const(CL_DEVICE_MEM_BASE_ADDR_ALIGN)
cdecl_const(CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE)
cdecl_const(CL_DEVICE_SINGLE_FP_CONFIG)
cdecl_const(CL_DEVICE_GLOBAL_MEM_CACHE_TYPE)
cdecl_const(CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE)
cdecl_const(CL_DEVICE_GLOBAL_MEM_CACHE_SIZE)
cdecl_const(CL_DEVICE_GLOBAL_MEM_SIZE)
cdecl_const(CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE)
cdecl_const(CL_DEVICE_MAX_CONSTANT_ARGS)
cdecl_const(CL_DEVICE_LOCAL_MEM_TYPE)
cdecl_const(CL_DEVICE_LOCAL_MEM_SIZE)
cdecl_const(CL_DEVICE_ERROR_CORRECTION_SUPPORT)
cdecl_const(CL_DEVICE_PROFILING_TIMER_RESOLUTION)
cdecl_const(CL_DEVICE_ENDIAN_LITTLE)
cdecl_const(CL_DEVICE_AVAILABLE)
cdecl_const(CL_DEVICE_COMPILER_AVAILABLE)
cdecl_const(CL_DEVICE_EXECUTION_CAPABILITIES)
cdecl_const(CL_DEVICE_QUEUE_PROPERTIES)
cdecl_const(CL_DEVICE_NAME)
cdecl_const(CL_DEVICE_VENDOR)
cdecl_const(CL_DRIVER_VERSION)
cdecl_const(CL_DEVICE_PROFILE)
cdecl_const(CL_DEVICE_VERSION)
cdecl_const(CL_DEVICE_EXTENSIONS)
cdecl_const(CL_DEVICE_PLATFORM)
#if CL_VERSION_1_2
cdecl_const(CL_DEVICE_DOUBLE_FP_CONFIG)
#endif
#if CL_VERSION_1_1
cdecl_const(CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF)
cdecl_const(CL_DEVICE_HOST_UNIFIED_MEMORY)
cdecl_const(CL_DEVICE_HALF_FP_CONFIG)
cdecl_const(CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR)
cdecl_const(CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT)
cdecl_const(CL_DEVICE_NATIVE_VECTOR_WIDTH_INT)
cdecl_const(CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG)
cdecl_const(CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT)
cdecl_const(CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE)
cdecl_const(CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF)
cdecl_const(CL_DEVICE_OPENCL_C_VERSION)
#endif
#if CL_VERSION_1_2
cdecl_const(CL_DEVICE_LINKER_AVAILABLE)
cdecl_const(CL_DEVICE_BUILT_IN_KERNELS)
cdecl_const(CL_DEVICE_IMAGE_MAX_BUFFER_SIZE)
cdecl_const(CL_DEVICE_IMAGE_MAX_ARRAY_SIZE)
cdecl_const(CL_DEVICE_PARENT_DEVICE)
cdecl_const(CL_DEVICE_PARTITION_MAX_SUB_DEVICES)
cdecl_const(CL_DEVICE_PARTITION_PROPERTIES)
cdecl_const(CL_DEVICE_PARTITION_AFFINITY_DOMAIN)
cdecl_const(CL_DEVICE_PARTITION_TYPE)
cdecl_const(CL_DEVICE_REFERENCE_COUNT)
cdecl_const(CL_DEVICE_PREFERRED_INTEROP_USER_SYNC)
cdecl_const(CL_DEVICE_PRINTF_BUFFER_SIZE)
#endif

cdecl_const(CL_FP_DENORM)
cdecl_const(CL_FP_INF_NAN)
cdecl_const(CL_FP_ROUND_TO_NEAREST)
cdecl_const(CL_FP_ROUND_TO_ZERO)
cdecl_const(CL_FP_ROUND_TO_INF)
cdecl_const(CL_FP_FMA)
#if CL_VERSION_1_1
cdecl_const(CL_FP_SOFT_FLOAT)
#endif
#if CL_VERSION_1_2
cdecl_const(CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT)
#endif

cdecl_const(CL_NONE)
cdecl_const(CL_READ_ONLY_CACHE)
cdecl_const(CL_READ_WRITE_CACHE)

cdecl_const(CL_LOCAL)
cdecl_const(CL_GLOBAL)

cdecl_const(CL_EXEC_KERNEL)
cdecl_const(CL_EXEC_NATIVE_KERNEL)

cdecl_const(CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE)
cdecl_const(CL_QUEUE_PROFILING_ENABLE)

cdecl_const(CL_CONTEXT_REFERENCE_COUNT)
cdecl_const(CL_CONTEXT_DEVICES)
cdecl_const(CL_CONTEXT_PROPERTIES)
#if CL_VERSION_1_1
cdecl_const(CL_CONTEXT_NUM_DEVICES)
#endif

cdecl_const(CL_CONTEXT_PLATFORM)
#if CL_VERSION_1_2
cdecl_const(CL_CONTEXT_INTEROP_USER_SYNC)
#endif

#if CL_VERSION_1_2
cdecl_const(CL_DEVICE_PARTITION_EQUALLY)
cdecl_const(CL_DEVICE_PARTITION_BY_COUNTS)
cdecl_const(CL_DEVICE_PARTITION_BY_COUNTS_LIST_END)
cdecl_const(CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN)

cdecl_const(CL_DEVICE_AFFINITY_DOMAIN_NUMA)
cdecl_const(CL_DEVICE_AFFINITY_DOMAIN_L4_CACHE)
cdecl_const(CL_DEVICE_AFFINITY_DOMAIN_L3_CACHE)
cdecl_const(CL_DEVICE_AFFINITY_DOMAIN_L2_CACHE)
cdecl_const(CL_DEVICE_AFFINITY_DOMAIN_L1_CACHE)
cdecl_const(CL_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE)
#endif

cdecl_const(CL_QUEUE_CONTEXT)
cdecl_const(CL_QUEUE_DEVICE)
cdecl_const(CL_QUEUE_REFERENCE_COUNT)
cdecl_const(CL_QUEUE_PROPERTIES)

cdecl_const(CL_MEM_READ_WRITE)
cdecl_const(CL_MEM_WRITE_ONLY)
cdecl_const(CL_MEM_READ_ONLY)
cdecl_const(CL_MEM_USE_HOST_PTR)
cdecl_const(CL_MEM_ALLOC_HOST_PTR)
cdecl_const(CL_MEM_COPY_HOST_PTR)
#ifdef cl_amd_device_memory_flags
cdecl_const(CL_MEM_USE_PERSISTENT_MEM_AMD)
#endif
#if CL_VERSION_1_2
cdecl_const(CL_MEM_HOST_WRITE_ONLY)
cdecl_const(CL_MEM_HOST_READ_ONLY)
cdecl_const(CL_MEM_HOST_NO_ACCESS)
#endif

#if CL_VERSION_1_2
cdecl_const(CL_MIGRATE_MEM_OBJECT_HOST)
cdecl_const(CL_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED)
#endif

cdecl_const(CL_R)
cdecl_const(CL_A)
cdecl_const(CL_RG)
cdecl_const(CL_RA)
cdecl_const(CL_RGB)
cdecl_const(CL_RGBA)
cdecl_const(CL_BGRA)
cdecl_const(CL_ARGB)
cdecl_const(CL_INTENSITY)
cdecl_const(CL_LUMINANCE)
#if CL_VERSION_1_1
cdecl_const(CL_Rx)
cdecl_const(CL_RGx)
cdecl_const(CL_RGBx)
#endif

cdecl_const(CL_SNORM_INT8)
cdecl_const(CL_SNORM_INT16)
cdecl_const(CL_UNORM_INT8)
cdecl_const(CL_UNORM_INT16)
cdecl_const(CL_UNORM_SHORT_565)
cdecl_const(CL_UNORM_SHORT_555)
cdecl_const(CL_UNORM_INT_101010)
cdecl_const(CL_SIGNED_INT8)
cdecl_const(CL_SIGNED_INT16)
cdecl_const(CL_SIGNED_INT32)
cdecl_const(CL_UNSIGNED_INT8)
cdecl_const(CL_UNSIGNED_INT16)
cdecl_const(CL_UNSIGNED_INT32)
cdecl_const(CL_HALF_FLOAT)
cdecl_const(CL_FLOAT)

cdecl_const(CL_MEM_OBJECT_BUFFER)
cdecl_const(CL_MEM_OBJECT_IMAGE2D)
cdecl_const(CL_MEM_OBJECT_IMAGE3D)
#if CL_VERSION_1_2
cdecl_const(CL_MEM_OBJECT_IMAGE2D_ARRAY)
cdecl_const(CL_MEM_OBJECT_IMAGE1D)
cdecl_const(CL_MEM_OBJECT_IMAGE1D_ARRAY)
cdecl_const(CL_MEM_OBJECT_IMAGE1D_BUFFER)
#endif

cdecl_const(CL_MEM_TYPE)
cdecl_const(CL_MEM_FLAGS)
cdecl_const(CL_MEM_SIZE)
cdecl_const(CL_MEM_HOST_PTR)
cdecl_const(CL_MEM_MAP_COUNT)
cdecl_const(CL_MEM_REFERENCE_COUNT)
cdecl_const(CL_MEM_CONTEXT)
#if CL_VERSION_1_1
cdecl_const(CL_MEM_ASSOCIATED_MEMOBJECT)
cdecl_const(CL_MEM_OFFSET)
#endif

cdecl_const(CL_IMAGE_FORMAT)
cdecl_const(CL_IMAGE_ELEMENT_SIZE)
cdecl_const(CL_IMAGE_ROW_PITCH)
cdecl_const(CL_IMAGE_SLICE_PITCH)
cdecl_const(CL_IMAGE_WIDTH)
cdecl_const(CL_IMAGE_HEIGHT)
cdecl_const(CL_IMAGE_DEPTH)
#if CL_VERSION_1_2
cdecl_const(CL_IMAGE_ARRAY_SIZE)
cdecl_const(CL_IMAGE_BUFFER)
cdecl_const(CL_IMAGE_NUM_MIP_LEVELS)
cdecl_const(CL_IMAGE_NUM_SAMPLES)
#endif

cdecl_const(CL_ADDRESS_NONE)
cdecl_const(CL_ADDRESS_CLAMP_TO_EDGE)
cdecl_const(CL_ADDRESS_CLAMP)
cdecl_const(CL_ADDRESS_REPEAT)
#if CL_VERSION_1_1
cdecl_const(CL_ADDRESS_MIRRORED_REPEAT)
#endif

cdecl_const(CL_FILTER_NEAREST)
cdecl_const(CL_FILTER_LINEAR)

cdecl_const(CL_SAMPLER_REFERENCE_COUNT)
cdecl_const(CL_SAMPLER_CONTEXT)
cdecl_const(CL_SAMPLER_NORMALIZED_COORDS)
cdecl_const(CL_SAMPLER_ADDRESSING_MODE)
cdecl_const(CL_SAMPLER_FILTER_MODE)

cdecl_const(CL_MAP_READ)
cdecl_const(CL_MAP_WRITE)
#if CL_VERSION_1_2
cdecl_const(CL_MAP_WRITE_INVALIDATE_REGION)
#endif

cdecl_const(CL_PROGRAM_REFERENCE_COUNT)
cdecl_const(CL_PROGRAM_CONTEXT)
cdecl_const(CL_PROGRAM_NUM_DEVICES)
cdecl_const(CL_PROGRAM_DEVICES)
cdecl_const(CL_PROGRAM_SOURCE)
cdecl_const(CL_PROGRAM_BINARY_SIZES)
cdecl_const(CL_PROGRAM_BINARIES)
#if CL_VERSION_1_2
cdecl_const(CL_PROGRAM_NUM_KERNELS)
cdecl_const(CL_PROGRAM_KERNEL_NAMES)
#endif

cdecl_const(CL_PROGRAM_BUILD_STATUS)
cdecl_const(CL_PROGRAM_BUILD_OPTIONS)
cdecl_const(CL_PROGRAM_BUILD_LOG)
#if CL_VERSION_1_2
cdecl_const(CL_PROGRAM_BINARY_TYPE)
#endif

#if CL_VERSION_1_2
cdecl_const(CL_PROGRAM_BINARY_TYPE_NONE)
cdecl_const(CL_PROGRAM_BINARY_TYPE_COMPILED_OBJECT)
cdecl_const(CL_PROGRAM_BINARY_TYPE_LIBRARY)
cdecl_const(CL_PROGRAM_BINARY_TYPE_EXECUTABLE)
#endif

cdecl_const(CL_BUILD_SUCCESS)
cdecl_const(CL_BUILD_NONE)
cdecl_const(CL_BUILD_ERROR)
cdecl_const(CL_BUILD_IN_PROGRESS)

cdecl_const(CL_KERNEL_FUNCTION_NAME)
cdecl_const(CL_KERNEL_NUM_ARGS)
cdecl_const(CL_KERNEL_REFERENCE_COUNT)
cdecl_const(CL_KERNEL_CONTEXT)
cdecl_const(CL_KERNEL_PROGRAM)
#if CL_VERSION_1_2
cdecl_const(CL_KERNEL_ATTRIBUTES)
#endif

#if CL_VERSION_1_2
cdecl_const(CL_KERNEL_ARG_ADDRESS_QUALIFIER)
cdecl_const(CL_KERNEL_ARG_ACCESS_QUALIFIER)
cdecl_const(CL_KERNEL_ARG_TYPE_NAME)
cdecl_const(CL_KERNEL_ARG_TYPE_QUALIFIER)
cdecl_const(CL_KERNEL_ARG_NAME)

cdecl_const(CL_KERNEL_ARG_ADDRESS_GLOBAL)
cdecl_const(CL_KERNEL_ARG_ADDRESS_LOCAL)
cdecl_const(CL_KERNEL_ARG_ADDRESS_CONSTANT)
cdecl_const(CL_KERNEL_ARG_ADDRESS_PRIVATE)

cdecl_const(CL_KERNEL_ARG_ACCESS_READ_ONLY)
cdecl_const(CL_KERNEL_ARG_ACCESS_WRITE_ONLY)
cdecl_const(CL_KERNEL_ARG_ACCESS_READ_WRITE)
cdecl_const(CL_KERNEL_ARG_ACCESS_NONE)

cdecl_const(CL_KERNEL_ARG_TYPE_NONE)
cdecl_const(CL_KERNEL_ARG_TYPE_CONST)
cdecl_const(CL_KERNEL_ARG_TYPE_RESTRICT)
cdecl_const(CL_KERNEL_ARG_TYPE_VOLATILE)
#endif

cdecl_const(CL_KERNEL_WORK_GROUP_SIZE)
cdecl_const(CL_KERNEL_COMPILE_WORK_GROUP_SIZE)
cdecl_const(CL_KERNEL_LOCAL_MEM_SIZE)
#if CL_VERSION_1_1
cdecl_const(CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE)
cdecl_const(CL_KERNEL_PRIVATE_MEM_SIZE)
#endif
#if CL_VERSION_1_2
cdecl_const(CL_KERNEL_GLOBAL_WORK_SIZE)
#endif

cdecl_const(CL_EVENT_COMMAND_QUEUE)
cdecl_const(CL_EVENT_COMMAND_TYPE)
cdecl_const(CL_EVENT_REFERENCE_COUNT)
cdecl_const(CL_EVENT_COMMAND_EXECUTION_STATUS)
#if CL_VERSION_1_1
cdecl_const(CL_EVENT_CONTEXT)
#endif

cdecl_const(CL_COMMAND_NDRANGE_KERNEL)
cdecl_const(CL_COMMAND_TASK)
cdecl_const(CL_COMMAND_NATIVE_KERNEL)
cdecl_const(CL_COMMAND_READ_BUFFER)
cdecl_const(CL_COMMAND_WRITE_BUFFER)
cdecl_const(CL_COMMAND_COPY_BUFFER)
cdecl_const(CL_COMMAND_READ_IMAGE)
cdecl_const(CL_COMMAND_WRITE_IMAGE)
cdecl_const(CL_COMMAND_COPY_IMAGE)
cdecl_const(CL_COMMAND_COPY_IMAGE_TO_BUFFER)
cdecl_const(CL_COMMAND_COPY_BUFFER_TO_IMAGE)
cdecl_const(CL_COMMAND_MAP_BUFFER)
cdecl_const(CL_COMMAND_MAP_IMAGE)
cdecl_const(CL_COMMAND_UNMAP_MEM_OBJECT)
cdecl_const(CL_COMMAND_MARKER)
cdecl_const(CL_COMMAND_ACQUIRE_GL_OBJECTS)
cdecl_const(CL_COMMAND_RELEASE_GL_OBJECTS)
#if CL_VERSION_1_1
cdecl_const(CL_COMMAND_READ_BUFFER_RECT)
cdecl_const(CL_COMMAND_WRITE_BUFFER_RECT)
cdecl_const(CL_COMMAND_COPY_BUFFER_RECT)
cdecl_const(CL_COMMAND_USER)
#endif
#if CL_VERSION_1_2
cdecl_const(CL_COMMAND_BARRIER)
cdecl_const(CL_COMMAND_MIGRATE_MEM_OBJECTS)
cdecl_const(CL_COMMAND_FILL_BUFFER)
cdecl_const(CL_COMMAND_FILL_IMAGE)
#endif

cdecl_const(CL_COMPLETE)
cdecl_const(CL_RUNNING)
cdecl_const(CL_SUBMITTED)
cdecl_const(CL_QUEUED)

#if CL_VERSION_1_1
cdecl_const(CL_BUFFER_CREATE_TYPE_REGION)
#endif

cdecl_const(CL_PROFILING_COMMAND_QUEUED)
cdecl_const(CL_PROFILING_COMMAND_SUBMIT)
cdecl_const(CL_PROFILING_COMMAND_START)
cdecl_const(CL_PROFILING_COMMAND_END)

cdecl_func(clGetPlatformIDs)
cdecl_func(clGetPlatformInfo)

cdecl_func(clGetDeviceIDs)
cdecl_func(clGetDeviceInfo)
#if CL_VERSION_1_2
cdecl_func(clCreateSubDevices)
cdecl_func(clRetainDevice)
cdecl_func(clReleaseDevice)
#endif

cdecl_func(clCreateContext)
cdecl_func(clCreateContextFromType)
cdecl_func(clRetainContext)
cdecl_func(clReleaseContext)
cdecl_func(clGetContextInfo)

cdecl_func(clCreateCommandQueue)
cdecl_func(clRetainCommandQueue)
cdecl_func(clReleaseCommandQueue)
cdecl_func(clGetCommandQueueInfo)

cdecl_func(clCreateBuffer)
#if CL_VERSION_1_1
cdecl_func(clCreateSubBuffer)
#endif
#if CL_VERSION_1_2
cdecl_func(clCreateImage)
#endif
cdecl_func(clRetainMemObject)
cdecl_func(clReleaseMemObject)
cdecl_func(clGetSupportedImageFormats)
cdecl_func(clGetMemObjectInfo)
cdecl_func(clGetImageInfo)
#if CL_VERSION_1_1
cdecl_func(clSetMemObjectDestructorCallback)
#endif

cdecl_func(clCreateSampler)
cdecl_func(clRetainSampler)
cdecl_func(clReleaseSampler)
cdecl_func(clGetSamplerInfo)

cdecl_func(clCreateProgramWithSource)
cdecl_func(clCreateProgramWithBinary)
#if CL_VERSION_1_2
cdecl_func(clCreateProgramWithBuiltInKernels)
#endif
cdecl_func(clRetainProgram)
cdecl_func(clReleaseProgram)
cdecl_func(clBuildProgram)
#if CL_VERSION_1_2
cdecl_func(clCompileProgram)
cdecl_func(clLinkProgram)
cdecl_func(clUnloadPlatformCompiler)
#endif
cdecl_func(clGetProgramInfo)
cdecl_func(clGetProgramBuildInfo)

cdecl_func(clCreateKernel)
cdecl_func(clCreateKernelsInProgram)
cdecl_func(clRetainKernel)
cdecl_func(clReleaseKernel)
cdecl_func(clSetKernelArg)
cdecl_func(clGetKernelInfo)
#if CL_VERSION_1_2
cdecl_func(clGetKernelArgInfo)
#endif
cdecl_func(clGetKernelWorkGroupInfo)

cdecl_func(clWaitForEvents)
cdecl_func(clGetEventInfo)
#if CL_VERSION_1_1
cdecl_func(clCreateUserEvent)
#endif
cdecl_func(clRetainEvent)
cdecl_func(clReleaseEvent)
#if CL_VERSION_1_1
cdecl_func(clSetUserEventStatus)
cdecl_func(clSetEventCallback)
#endif

cdecl_func(clGetEventProfilingInfo)

cdecl_func(clFlush)
cdecl_func(clFinish)

cdecl_func(clEnqueueReadBuffer)
#if CL_VERSION_1_1
cdecl_func(clEnqueueReadBufferRect)
#endif
cdecl_func(clEnqueueWriteBuffer)
#if CL_VERSION_1_1
cdecl_func(clEnqueueWriteBufferRect)
#endif
#if CL_VERSION_1_2
cdecl_func(clEnqueueFillBuffer)
#endif
cdecl_func(clEnqueueCopyBuffer)
#if CL_VERSION_1_1
cdecl_func(clEnqueueCopyBufferRect)
#endif
cdecl_func(clEnqueueReadImage)
cdecl_func(clEnqueueWriteImage)
#if CL_VERSION_1_2
cdecl_func(clEnqueueFillImage)
#endif
cdecl_func(clEnqueueCopyImage)
cdecl_func(clEnqueueCopyImageToBuffer)
cdecl_func(clEnqueueCopyBufferToImage)
cdecl_func(clEnqueueMapBuffer)
cdecl_func(clEnqueueMapImage)
cdecl_func(clEnqueueUnmapMemObject)
#if CL_VERSION_1_2
cdecl_func(clEnqueueMigrateMemObjects)
#endif
cdecl_func(clEnqueueNDRangeKernel)
cdecl_func(clEnqueueTask)
cdecl_func(clEnqueueNativeKernel)
#if CL_VERSION_1_2
cdecl_func(clEnqueueMarkerWithWaitList)
cdecl_func(clEnqueueBarrierWithWaitList)
#endif

#if CL_VERSION_1_2
cdecl_func(clGetExtensionFunctionAddressForPlatform)
#endif

#if !CL_VERSION_1_1 || CL_USE_DEPRECATED_OPENCL_1_0_APIS
cdecl_func(clSetCommandQueueProperty)
#endif

#if !CL_VERSION_1_2 || CL_USE_DEPRECATED_OPENCL_1_1_APIS
cdecl_func(clCreateImage2D)
cdecl_func(clCreateImage3D)
cdecl_func(clEnqueueMarker)
cdecl_func(clEnqueueWaitForEvents)
cdecl_func(clEnqueueBarrier)
cdecl_func(clUnloadCompiler)
cdecl_func(clGetExtensionFunctionAddress)
#endif
