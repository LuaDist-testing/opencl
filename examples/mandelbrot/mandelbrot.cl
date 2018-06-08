/*
 * Mandelbrot set.
 * Copyright © 2014 Peter Colberg.
 * Distributed under the MIT license. (See accompanying file LICENSE.)
 */

#if !CL_VERSION_1_2
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
#endif

/*
 * Returns RGB tuple of 8-bit integers given a scalar.
 *
 * R     __     G   __       B __
 * |    /  \    |  /  \      |/  \
 * |___/        |_/    \_    |    \___
 *
 * The plots show the intensities of red, green and blue, where the
 * range of the scalar is [0.0, 1.0], and the range of each color
 * intensity is [0.0, 1.0], or, transformed to an integer, [0, 255].
 */
uchar3 colormap(float s)
{
  const float3 t = s - (float3)(0.75, 0.5, 0.25);
  const float3 c = (float)(${1.5 * 256}) - fabs(t) * (float)(${4 * 256});
  return convert_uchar3_sat(c);
}

/*
 * Calculate the Mandelbrot set of points in the complex plane.
 *
 * The algorithm uses a fractional recursion count for smooth coloring.
 *
 * https://en.wikipedia.org/wiki/Mandelbrot_set
 * https://en.wikipedia.org/wiki/Mandelbrot_set#Continuous_.28smooth.29_coloring
 */
__kernel void mandelbrot(__global uchar3 *restrict d_image)
{
  const uint px = get_global_id(0);
  const uint py = get_global_id(1);
  const double x0 = ${X[1]} + ${(X[2] - X[1]) / Nx} * px;
  const double y0 = ${Y[1]} + ${(Y[2] - Y[1]) / Ny} * (${Ny - 1} - py);
  double x = 0;
  double y = 0;
  uchar3 rgb = (uchar3)(0, 0, 0);
  for (int n = 0; n < ${N}; ++n) {
    const double x2 = x * x;
    const double y2 = y * y;
    const float r2 = x2 + y2;
    if (r2 > (float)(${R ^ 2})) {
      const float f = log2(log(r2) * (float)(${0.5 / math.log(R)}));
      const float s = (n + 1 - f) * (float)(${1 / N});
      rgb = colormap(s);
      break;
    }
    y = 2 * x * y + y0;
    x = x2 - y2 + x0;
  }
  d_image[px + py * ${Nx}] = rgb;
}
