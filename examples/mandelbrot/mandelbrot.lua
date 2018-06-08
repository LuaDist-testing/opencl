#!/usr/bin/env luajit
------------------------------------------------------------------------------
-- Mandelbrot set.
-- Copyright © 2014 Peter Colberg.
-- For conditions of distribution and use, see copyright notice in LICENSE.
------------------------------------------------------------------------------

local cl = require("opencl")
local ffi = require("ffi")
local templet = require("templet")

local config = setmetatable({}, {__index = _G})
loadfile(arg[1], nil, config)()
local template = templet.loadfile("mandelbrot.cl")
local source = template(config)

local platform = cl.get_platforms()[config.platform]
local device = platform:get_devices()[config.device]
local context = cl.create_context({device})
local program = context:create_program_with_source(source)
local status, err = pcall(function() return program:build() end)
io.stderr:write(program:get_build_info(device, "log"))
if not status then error(err) end

local Nx, Ny = config.Nx, config.Ny
local d_image = context:create_buffer(Nx * Ny * ffi.sizeof("cl_uchar3"))
local kernel = program:create_kernel("mandelbrot")
kernel:set_arg(0, d_image)
local queue = context:create_command_queue(device, "profiling")
local event = queue:enqueue_ndrange_kernel(kernel, nil, {Nx,  Ny}, {64, 1})

local image = ffi.cast("cl_uchar3 *", queue:enqueue_map_buffer(d_image, true, "read", 0, Nx * Ny * ffi.sizeof("cl_uchar3")))
local f = io.open(config.output, "w")
f:write("P6\n", Nx, " ", Ny, "\n", 255, "\n")
local row = ffi.new("struct { char r, g, b; }[?]", Nx)
for py = 0, Ny - 1 do
  for px = 0, Nx - 1 do
    row[px].r = image[px + py * Nx].s0
    row[px].g = image[px + py * Nx].s1
    row[px].b = image[px + py * Nx].s2
  end
  f:write(ffi.string(row, Nx * 3))
end
f:close()
queue:enqueue_unmap_mem_object(d_image, image)

local start = event:get_profiling_info("start")
local stop = event:get_profiling_info("end")
io.write(("%.4g s\n"):format(tonumber(stop - start) * 1e-9))
