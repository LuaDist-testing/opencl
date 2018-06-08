-- range of x = Re(z)
X = {-1.401155 - 0.75, -1.401155 + 2.25}
-- range of y = Im(z)
Y = {-1.25, 1.25}
-- number of horizontal pixels
Nx = 5120
-- number of vertical pixels
Ny = math.ceil(Nx * (Y[2] - Y[1]) / (X[2] - X[1]))
-- number of recursions
N = 100
-- escape radius
R = 100
-- PPM image filename
output = "mandelbrot_N" .. N .. ".ppm"
-- OpenCL platform
platform = 1
-- OpenCL device
device = 1
