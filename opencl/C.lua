------------------------------------------------------------------------------
-- OpenCL for Lua.
-- Copyright © 2013 Peter Colberg.
-- For conditions of distribution and use, see copyright notice in LICENSE.
------------------------------------------------------------------------------

local ffi = require("ffi")

ffi.cdef[[
typedef int8_t cl_char;
typedef uint8_t cl_uchar;
typedef int16_t cl_short __attribute__((aligned(2)));
typedef uint16_t cl_ushort __attribute__((aligned(2)));
typedef int32_t cl_int __attribute__((aligned(4)));
typedef uint32_t cl_uint __attribute__((aligned(4)));
typedef int64_t cl_long __attribute__((aligned(8)));
typedef uint64_t cl_ulong __attribute__((aligned(8)));
typedef uint16_t cl_half __attribute__((aligned(2)));
typedef float cl_float __attribute__((aligned(4)));
typedef double cl_double __attribute__((aligned(8)));
typedef unsigned int cl_GLuint;
typedef int cl_GLint;
typedef unsigned int cl_GLenum;
typedef cl_char __attribute__((vector_size(8))) __cl_char8;
typedef cl_char __attribute__((vector_size(16))) __cl_char16;
typedef cl_double __attribute__((vector_size(16))) __cl_double2;
typedef cl_double __attribute__((vector_size(32))) __cl_double4;
typedef cl_float __attribute__((vector_size(8))) __cl_float2;
typedef cl_float __attribute__((vector_size(16))) __cl_float4;
typedef cl_float __attribute__((vector_size(32))) __cl_float8;
typedef cl_int __attribute__((vector_size(8))) __cl_int2;
typedef cl_int __attribute__((vector_size(16))) __cl_int4;
typedef cl_long __attribute__((vector_size(16))) __cl_long2;
typedef cl_short __attribute__((vector_size(8))) __cl_short4;
typedef cl_short __attribute__((vector_size(16))) __cl_short8;
typedef cl_uchar __attribute__((vector_size(8))) __cl_uchar8;
typedef cl_uchar __attribute__((vector_size(16))) __cl_uchar16;
typedef cl_uint __attribute__((vector_size(8))) __cl_uint2;
typedef cl_uint __attribute__((vector_size(16))) __cl_uint4;
typedef cl_ulong __attribute__((vector_size(16))) __cl_ulong2;
typedef cl_ushort __attribute__((vector_size(8))) __cl_ushort4;
typedef cl_ushort __attribute__((vector_size(16))) __cl_ushort8;
typedef union cl_char2 cl_char2;
union cl_char2 {
  cl_char s[2] __attribute__((aligned(2)));
  struct {
    cl_char x;
    cl_char y;
  };
  struct {
    cl_char s0;
    cl_char s1;
  };
  struct {
    cl_char lo;
    cl_char hi;
  };
};
typedef union cl_char4 cl_char4;
union cl_char4 {
  cl_char s[4] __attribute__((aligned(4)));
  struct {
    cl_char x;
    cl_char y;
    cl_char z;
    cl_char w;
  };
  struct {
    cl_char s0;
    cl_char s1;
    cl_char s2;
    cl_char s3;
  };
  struct {
    cl_char2 lo;
    cl_char2 hi;
  };
};
typedef union cl_char4 cl_char3;
typedef union cl_char8 cl_char8;
union cl_char8 {
  cl_char s[8] __attribute__((aligned(8)));
  struct {
    cl_char x;
    cl_char y;
    cl_char z;
    cl_char w;
  };
  struct {
    cl_char s0;
    cl_char s1;
    cl_char s2;
    cl_char s3;
    cl_char s4;
    cl_char s5;
    cl_char s6;
    cl_char s7;
  };
  struct {
    cl_char4 lo;
    cl_char4 hi;
  };
  __cl_char8 v8;
};
typedef union cl_char16 cl_char16;
union cl_char16 {
  cl_char s[16] __attribute__((aligned(16)));
  struct {
    cl_char x;
    cl_char y;
    cl_char z;
    cl_char w;
    cl_char __spacer4;
    cl_char __spacer5;
    cl_char __spacer6;
    cl_char __spacer7;
    cl_char __spacer8;
    cl_char __spacer9;
    cl_char sa;
    cl_char sb;
    cl_char sc;
    cl_char sd;
    cl_char se;
    cl_char sf;
  };
  struct {
    cl_char s0;
    cl_char s1;
    cl_char s2;
    cl_char s3;
    cl_char s4;
    cl_char s5;
    cl_char s6;
    cl_char s7;
    cl_char s8;
    cl_char s9;
    cl_char sA;
    cl_char sB;
    cl_char sC;
    cl_char sD;
    cl_char sE;
    cl_char sF;
  };
  struct {
    cl_char8 lo;
    cl_char8 hi;
  };
  __cl_char8 v8[2];
  __cl_char16 v16;
};
typedef union cl_uchar2 cl_uchar2;
union cl_uchar2 {
  cl_uchar s[2] __attribute__((aligned(2)));
  struct {
    cl_uchar x;
    cl_uchar y;
  };
  struct {
    cl_uchar s0;
    cl_uchar s1;
  };
  struct {
    cl_uchar lo;
    cl_uchar hi;
  };
};
typedef union cl_uchar4 cl_uchar4;
union cl_uchar4 {
  cl_uchar s[4] __attribute__((aligned(4)));
  struct {
    cl_uchar x;
    cl_uchar y;
    cl_uchar z;
    cl_uchar w;
  };
  struct {
    cl_uchar s0;
    cl_uchar s1;
    cl_uchar s2;
    cl_uchar s3;
  };
  struct {
    cl_uchar2 lo;
    cl_uchar2 hi;
  };
};
typedef union cl_uchar4 cl_uchar3;
typedef union cl_uchar8 cl_uchar8;
union cl_uchar8 {
  cl_uchar s[8] __attribute__((aligned(8)));
  struct {
    cl_uchar x;
    cl_uchar y;
    cl_uchar z;
    cl_uchar w;
  };
  struct {
    cl_uchar s0;
    cl_uchar s1;
    cl_uchar s2;
    cl_uchar s3;
    cl_uchar s4;
    cl_uchar s5;
    cl_uchar s6;
    cl_uchar s7;
  };
  struct {
    cl_uchar4 lo;
    cl_uchar4 hi;
  };
  __cl_uchar8 v8;
};
typedef union cl_uchar16 cl_uchar16;
union cl_uchar16 {
  cl_uchar s[16] __attribute__((aligned(16)));
  struct {
    cl_uchar x;
    cl_uchar y;
    cl_uchar z;
    cl_uchar w;
    cl_uchar __spacer4;
    cl_uchar __spacer5;
    cl_uchar __spacer6;
    cl_uchar __spacer7;
    cl_uchar __spacer8;
    cl_uchar __spacer9;
    cl_uchar sa;
    cl_uchar sb;
    cl_uchar sc;
    cl_uchar sd;
    cl_uchar se;
    cl_uchar sf;
  };
  struct {
    cl_uchar s0;
    cl_uchar s1;
    cl_uchar s2;
    cl_uchar s3;
    cl_uchar s4;
    cl_uchar s5;
    cl_uchar s6;
    cl_uchar s7;
    cl_uchar s8;
    cl_uchar s9;
    cl_uchar sA;
    cl_uchar sB;
    cl_uchar sC;
    cl_uchar sD;
    cl_uchar sE;
    cl_uchar sF;
  };
  struct {
    cl_uchar8 lo;
    cl_uchar8 hi;
  };
  __cl_uchar8 v8[2];
  __cl_uchar16 v16;
};
typedef union cl_short2 cl_short2;
union cl_short2 {
  cl_short s[2] __attribute__((aligned(4)));
  struct {
    cl_short x;
    cl_short y;
  };
  struct {
    cl_short s0;
    cl_short s1;
  };
  struct {
    cl_short lo;
    cl_short hi;
  };
};
typedef union cl_short4 cl_short4;
union cl_short4 {
  cl_short s[4] __attribute__((aligned(8)));
  struct {
    cl_short x;
    cl_short y;
    cl_short z;
    cl_short w;
  };
  struct {
    cl_short s0;
    cl_short s1;
    cl_short s2;
    cl_short s3;
  };
  struct {
    cl_short2 lo;
    cl_short2 hi;
  };
  __cl_short4 v4;
};
typedef union cl_short4 cl_short3;
typedef union cl_short8 cl_short8;
union cl_short8 {
  cl_short s[8] __attribute__((aligned(16)));
  struct {
    cl_short x;
    cl_short y;
    cl_short z;
    cl_short w;
  };
  struct {
    cl_short s0;
    cl_short s1;
    cl_short s2;
    cl_short s3;
    cl_short s4;
    cl_short s5;
    cl_short s6;
    cl_short s7;
  };
  struct {
    cl_short4 lo;
    cl_short4 hi;
  };
  __cl_short4 v4[2];
  __cl_short8 v8;
};
typedef union cl_short16 cl_short16;
union cl_short16 {
  cl_short s[16] __attribute__((aligned(32)));
  struct {
    cl_short x;
    cl_short y;
    cl_short z;
    cl_short w;
    cl_short __spacer4;
    cl_short __spacer5;
    cl_short __spacer6;
    cl_short __spacer7;
    cl_short __spacer8;
    cl_short __spacer9;
    cl_short sa;
    cl_short sb;
    cl_short sc;
    cl_short sd;
    cl_short se;
    cl_short sf;
  };
  struct {
    cl_short s0;
    cl_short s1;
    cl_short s2;
    cl_short s3;
    cl_short s4;
    cl_short s5;
    cl_short s6;
    cl_short s7;
    cl_short s8;
    cl_short s9;
    cl_short sA;
    cl_short sB;
    cl_short sC;
    cl_short sD;
    cl_short sE;
    cl_short sF;
  };
  struct {
    cl_short8 lo;
    cl_short8 hi;
  };
  __cl_short4 v4[4];
  __cl_short8 v8[2];
};
typedef union cl_ushort2 cl_ushort2;
union cl_ushort2 {
  cl_ushort s[2] __attribute__((aligned(4)));
  struct {
    cl_ushort x;
    cl_ushort y;
  };
  struct {
    cl_ushort s0;
    cl_ushort s1;
  };
  struct {
    cl_ushort lo;
    cl_ushort hi;
  };
};
typedef union cl_ushort4 cl_ushort4;
union cl_ushort4 {
  cl_ushort s[4] __attribute__((aligned(8)));
  struct {
    cl_ushort x;
    cl_ushort y;
    cl_ushort z;
    cl_ushort w;
  };
  struct {
    cl_ushort s0;
    cl_ushort s1;
    cl_ushort s2;
    cl_ushort s3;
  };
  struct {
    cl_ushort2 lo;
    cl_ushort2 hi;
  };
  __cl_ushort4 v4;
};
typedef union cl_ushort4 cl_ushort3;
typedef union cl_ushort8 cl_ushort8;
union cl_ushort8 {
  cl_ushort s[8] __attribute__((aligned(16)));
  struct {
    cl_ushort x;
    cl_ushort y;
    cl_ushort z;
    cl_ushort w;
  };
  struct {
    cl_ushort s0;
    cl_ushort s1;
    cl_ushort s2;
    cl_ushort s3;
    cl_ushort s4;
    cl_ushort s5;
    cl_ushort s6;
    cl_ushort s7;
  };
  struct {
    cl_ushort4 lo;
    cl_ushort4 hi;
  };
  __cl_ushort4 v4[2];
  __cl_ushort8 v8;
};
typedef union cl_ushort16 cl_ushort16;
union cl_ushort16 {
  cl_ushort s[16] __attribute__((aligned(32)));
  struct {
    cl_ushort x;
    cl_ushort y;
    cl_ushort z;
    cl_ushort w;
    cl_ushort __spacer4;
    cl_ushort __spacer5;
    cl_ushort __spacer6;
    cl_ushort __spacer7;
    cl_ushort __spacer8;
    cl_ushort __spacer9;
    cl_ushort sa;
    cl_ushort sb;
    cl_ushort sc;
    cl_ushort sd;
    cl_ushort se;
    cl_ushort sf;
  };
  struct {
    cl_ushort s0;
    cl_ushort s1;
    cl_ushort s2;
    cl_ushort s3;
    cl_ushort s4;
    cl_ushort s5;
    cl_ushort s6;
    cl_ushort s7;
    cl_ushort s8;
    cl_ushort s9;
    cl_ushort sA;
    cl_ushort sB;
    cl_ushort sC;
    cl_ushort sD;
    cl_ushort sE;
    cl_ushort sF;
  };
  struct {
    cl_ushort8 lo;
    cl_ushort8 hi;
  };
  __cl_ushort4 v4[4];
  __cl_ushort8 v8[2];
};
typedef union cl_int2 cl_int2;
union cl_int2 {
  cl_int s[2] __attribute__((aligned(8)));
  struct {
    cl_int x;
    cl_int y;
  };
  struct {
    cl_int s0;
    cl_int s1;
  };
  struct {
    cl_int lo;
    cl_int hi;
  };
  __cl_int2 v2;
};
typedef union cl_int4 cl_int4;
union cl_int4 {
  cl_int s[4] __attribute__((aligned(16)));
  struct {
    cl_int x;
    cl_int y;
    cl_int z;
    cl_int w;
  };
  struct {
    cl_int s0;
    cl_int s1;
    cl_int s2;
    cl_int s3;
  };
  struct {
    cl_int2 lo;
    cl_int2 hi;
  };
  __cl_int2 v2[2];
  __cl_int4 v4;
};
typedef union cl_int4 cl_int3;
typedef union cl_int8 cl_int8;
union cl_int8 {
  cl_int s[8] __attribute__((aligned(32)));
  struct {
    cl_int x;
    cl_int y;
    cl_int z;
    cl_int w;
  };
  struct {
    cl_int s0;
    cl_int s1;
    cl_int s2;
    cl_int s3;
    cl_int s4;
    cl_int s5;
    cl_int s6;
    cl_int s7;
  };
  struct {
    cl_int4 lo;
    cl_int4 hi;
  };
  __cl_int2 v2[4];
  __cl_int4 v4[2];
};
typedef union cl_int16 cl_int16;
union cl_int16 {
  cl_int s[16] __attribute__((aligned(64)));
  struct {
    cl_int x;
    cl_int y;
    cl_int z;
    cl_int w;
    cl_int __spacer4;
    cl_int __spacer5;
    cl_int __spacer6;
    cl_int __spacer7;
    cl_int __spacer8;
    cl_int __spacer9;
    cl_int sa;
    cl_int sb;
    cl_int sc;
    cl_int sd;
    cl_int se;
    cl_int sf;
  };
  struct {
    cl_int s0;
    cl_int s1;
    cl_int s2;
    cl_int s3;
    cl_int s4;
    cl_int s5;
    cl_int s6;
    cl_int s7;
    cl_int s8;
    cl_int s9;
    cl_int sA;
    cl_int sB;
    cl_int sC;
    cl_int sD;
    cl_int sE;
    cl_int sF;
  };
  struct {
    cl_int8 lo;
    cl_int8 hi;
  };
  __cl_int2 v2[8];
  __cl_int4 v4[4];
};
typedef union cl_uint2 cl_uint2;
union cl_uint2 {
  cl_uint s[2] __attribute__((aligned(8)));
  struct {
    cl_uint x;
    cl_uint y;
  };
  struct {
    cl_uint s0;
    cl_uint s1;
  };
  struct {
    cl_uint lo;
    cl_uint hi;
  };
  __cl_uint2 v2;
};
typedef union cl_uint4 cl_uint4;
union cl_uint4 {
  cl_uint s[4] __attribute__((aligned(16)));
  struct {
    cl_uint x;
    cl_uint y;
    cl_uint z;
    cl_uint w;
  };
  struct {
    cl_uint s0;
    cl_uint s1;
    cl_uint s2;
    cl_uint s3;
  };
  struct {
    cl_uint2 lo;
    cl_uint2 hi;
  };
  __cl_uint2 v2[2];
  __cl_uint4 v4;
};
typedef union cl_uint4 cl_uint3;
typedef union cl_uint8 cl_uint8;
union cl_uint8 {
  cl_uint s[8] __attribute__((aligned(32)));
  struct {
    cl_uint x;
    cl_uint y;
    cl_uint z;
    cl_uint w;
  };
  struct {
    cl_uint s0;
    cl_uint s1;
    cl_uint s2;
    cl_uint s3;
    cl_uint s4;
    cl_uint s5;
    cl_uint s6;
    cl_uint s7;
  };
  struct {
    cl_uint4 lo;
    cl_uint4 hi;
  };
  __cl_uint2 v2[4];
  __cl_uint4 v4[2];
};
typedef union cl_uint16 cl_uint16;
union cl_uint16 {
  cl_uint s[16] __attribute__((aligned(64)));
  struct {
    cl_uint x;
    cl_uint y;
    cl_uint z;
    cl_uint w;
    cl_uint __spacer4;
    cl_uint __spacer5;
    cl_uint __spacer6;
    cl_uint __spacer7;
    cl_uint __spacer8;
    cl_uint __spacer9;
    cl_uint sa;
    cl_uint sb;
    cl_uint sc;
    cl_uint sd;
    cl_uint se;
    cl_uint sf;
  };
  struct {
    cl_uint s0;
    cl_uint s1;
    cl_uint s2;
    cl_uint s3;
    cl_uint s4;
    cl_uint s5;
    cl_uint s6;
    cl_uint s7;
    cl_uint s8;
    cl_uint s9;
    cl_uint sA;
    cl_uint sB;
    cl_uint sC;
    cl_uint sD;
    cl_uint sE;
    cl_uint sF;
  };
  struct {
    cl_uint8 lo;
    cl_uint8 hi;
  };
  __cl_uint2 v2[8];
  __cl_uint4 v4[4];
};
typedef union cl_long2 cl_long2;
union cl_long2 {
  cl_long s[2] __attribute__((aligned(16)));
  struct {
    cl_long x;
    cl_long y;
  };
  struct {
    cl_long s0;
    cl_long s1;
  };
  struct {
    cl_long lo;
    cl_long hi;
  };
  __cl_long2 v2;
};
typedef union cl_long4 cl_long4;
union cl_long4 {
  cl_long s[4] __attribute__((aligned(32)));
  struct {
    cl_long x;
    cl_long y;
    cl_long z;
    cl_long w;
  };
  struct {
    cl_long s0;
    cl_long s1;
    cl_long s2;
    cl_long s3;
  };
  struct {
    cl_long2 lo;
    cl_long2 hi;
  };
  __cl_long2 v2[2];
};
typedef union cl_long4 cl_long3;
typedef union cl_long8 cl_long8;
union cl_long8 {
  cl_long s[8] __attribute__((aligned(64)));
  struct {
    cl_long x;
    cl_long y;
    cl_long z;
    cl_long w;
  };
  struct {
    cl_long s0;
    cl_long s1;
    cl_long s2;
    cl_long s3;
    cl_long s4;
    cl_long s5;
    cl_long s6;
    cl_long s7;
  };
  struct {
    cl_long4 lo;
    cl_long4 hi;
  };
  __cl_long2 v2[4];
};
typedef union cl_long16 cl_long16;
union cl_long16 {
  cl_long s[16] __attribute__((aligned(128)));
  struct {
    cl_long x;
    cl_long y;
    cl_long z;
    cl_long w;
    cl_long __spacer4;
    cl_long __spacer5;
    cl_long __spacer6;
    cl_long __spacer7;
    cl_long __spacer8;
    cl_long __spacer9;
    cl_long sa;
    cl_long sb;
    cl_long sc;
    cl_long sd;
    cl_long se;
    cl_long sf;
  };
  struct {
    cl_long s0;
    cl_long s1;
    cl_long s2;
    cl_long s3;
    cl_long s4;
    cl_long s5;
    cl_long s6;
    cl_long s7;
    cl_long s8;
    cl_long s9;
    cl_long sA;
    cl_long sB;
    cl_long sC;
    cl_long sD;
    cl_long sE;
    cl_long sF;
  };
  struct {
    cl_long8 lo;
    cl_long8 hi;
  };
  __cl_long2 v2[8];
};
typedef union cl_ulong2 cl_ulong2;
union cl_ulong2 {
  cl_ulong s[2] __attribute__((aligned(16)));
  struct {
    cl_ulong x;
    cl_ulong y;
  };
  struct {
    cl_ulong s0;
    cl_ulong s1;
  };
  struct {
    cl_ulong lo;
    cl_ulong hi;
  };
  __cl_ulong2 v2;
};
typedef union cl_ulong4 cl_ulong4;
union cl_ulong4 {
  cl_ulong s[4] __attribute__((aligned(32)));
  struct {
    cl_ulong x;
    cl_ulong y;
    cl_ulong z;
    cl_ulong w;
  };
  struct {
    cl_ulong s0;
    cl_ulong s1;
    cl_ulong s2;
    cl_ulong s3;
  };
  struct {
    cl_ulong2 lo;
    cl_ulong2 hi;
  };
  __cl_ulong2 v2[2];
};
typedef union cl_ulong4 cl_ulong3;
typedef union cl_ulong8 cl_ulong8;
union cl_ulong8 {
  cl_ulong s[8] __attribute__((aligned(64)));
  struct {
    cl_ulong x;
    cl_ulong y;
    cl_ulong z;
    cl_ulong w;
  };
  struct {
    cl_ulong s0;
    cl_ulong s1;
    cl_ulong s2;
    cl_ulong s3;
    cl_ulong s4;
    cl_ulong s5;
    cl_ulong s6;
    cl_ulong s7;
  };
  struct {
    cl_ulong4 lo;
    cl_ulong4 hi;
  };
  __cl_ulong2 v2[4];
};
typedef union cl_ulong16 cl_ulong16;
union cl_ulong16 {
  cl_ulong s[16] __attribute__((aligned(128)));
  struct {
    cl_ulong x;
    cl_ulong y;
    cl_ulong z;
    cl_ulong w;
    cl_ulong __spacer4;
    cl_ulong __spacer5;
    cl_ulong __spacer6;
    cl_ulong __spacer7;
    cl_ulong __spacer8;
    cl_ulong __spacer9;
    cl_ulong sa;
    cl_ulong sb;
    cl_ulong sc;
    cl_ulong sd;
    cl_ulong se;
    cl_ulong sf;
  };
  struct {
    cl_ulong s0;
    cl_ulong s1;
    cl_ulong s2;
    cl_ulong s3;
    cl_ulong s4;
    cl_ulong s5;
    cl_ulong s6;
    cl_ulong s7;
    cl_ulong s8;
    cl_ulong s9;
    cl_ulong sA;
    cl_ulong sB;
    cl_ulong sC;
    cl_ulong sD;
    cl_ulong sE;
    cl_ulong sF;
  };
  struct {
    cl_ulong8 lo;
    cl_ulong8 hi;
  };
  __cl_ulong2 v2[8];
};
typedef union cl_float2 cl_float2;
union cl_float2 {
  cl_float s[2] __attribute__((aligned(8)));
  struct {
    cl_float x;
    cl_float y;
  };
  struct {
    cl_float s0;
    cl_float s1;
  };
  struct {
    cl_float lo;
    cl_float hi;
  };
  __cl_float2 v2;
};
typedef union cl_float4 cl_float4;
union cl_float4 {
  cl_float s[4] __attribute__((aligned(16)));
  struct {
    cl_float x;
    cl_float y;
    cl_float z;
    cl_float w;
  };
  struct {
    cl_float s0;
    cl_float s1;
    cl_float s2;
    cl_float s3;
  };
  struct {
    cl_float2 lo;
    cl_float2 hi;
  };
  __cl_float2 v2[2];
  __cl_float4 v4;
};
typedef union cl_float4 cl_float3;
typedef union cl_float8 cl_float8;
union cl_float8 {
  cl_float s[8] __attribute__((aligned(32)));
  struct {
    cl_float x;
    cl_float y;
    cl_float z;
    cl_float w;
  };
  struct {
    cl_float s0;
    cl_float s1;
    cl_float s2;
    cl_float s3;
    cl_float s4;
    cl_float s5;
    cl_float s6;
    cl_float s7;
  };
  struct {
    cl_float4 lo;
    cl_float4 hi;
  };
  __cl_float2 v2[4];
  __cl_float4 v4[2];
  __cl_float8 v8;
};
typedef union cl_float16 cl_float16;
union cl_float16 {
  cl_float s[16] __attribute__((aligned(64)));
  struct {
    cl_float x;
    cl_float y;
    cl_float z;
    cl_float w;
    cl_float __spacer4;
    cl_float __spacer5;
    cl_float __spacer6;
    cl_float __spacer7;
    cl_float __spacer8;
    cl_float __spacer9;
    cl_float sa;
    cl_float sb;
    cl_float sc;
    cl_float sd;
    cl_float se;
    cl_float sf;
  };
  struct {
    cl_float s0;
    cl_float s1;
    cl_float s2;
    cl_float s3;
    cl_float s4;
    cl_float s5;
    cl_float s6;
    cl_float s7;
    cl_float s8;
    cl_float s9;
    cl_float sA;
    cl_float sB;
    cl_float sC;
    cl_float sD;
    cl_float sE;
    cl_float sF;
  };
  struct {
    cl_float8 lo;
    cl_float8 hi;
  };
  __cl_float2 v2[8];
  __cl_float4 v4[4];
  __cl_float8 v8[2];
};
typedef union cl_double2 cl_double2;
union cl_double2 {
  cl_double s[2] __attribute__((aligned(16)));
  struct {
    cl_double x;
    cl_double y;
  };
  struct {
    cl_double s0;
    cl_double s1;
  };
  struct {
    cl_double lo;
    cl_double hi;
  };
  __cl_double2 v2;
};
typedef union cl_double4 cl_double4;
union cl_double4 {
  cl_double s[4] __attribute__((aligned(32)));
  struct {
    cl_double x;
    cl_double y;
    cl_double z;
    cl_double w;
  };
  struct {
    cl_double s0;
    cl_double s1;
    cl_double s2;
    cl_double s3;
  };
  struct {
    cl_double2 lo;
    cl_double2 hi;
  };
  __cl_double2 v2[2];
  __cl_double4 v4;
};
typedef union cl_double4 cl_double3;
typedef union cl_double8 cl_double8;
union cl_double8 {
  cl_double s[8] __attribute__((aligned(64)));
  struct {
    cl_double x;
    cl_double y;
    cl_double z;
    cl_double w;
  };
  struct {
    cl_double s0;
    cl_double s1;
    cl_double s2;
    cl_double s3;
    cl_double s4;
    cl_double s5;
    cl_double s6;
    cl_double s7;
  };
  struct {
    cl_double4 lo;
    cl_double4 hi;
  };
  __cl_double2 v2[4];
  __cl_double4 v4[2];
};
typedef union cl_double16 cl_double16;
union cl_double16 {
  cl_double s[16] __attribute__((aligned(128)));
  struct {
    cl_double x;
    cl_double y;
    cl_double z;
    cl_double w;
    cl_double __spacer4;
    cl_double __spacer5;
    cl_double __spacer6;
    cl_double __spacer7;
    cl_double __spacer8;
    cl_double __spacer9;
    cl_double sa;
    cl_double sb;
    cl_double sc;
    cl_double sd;
    cl_double se;
    cl_double sf;
  };
  struct {
    cl_double s0;
    cl_double s1;
    cl_double s2;
    cl_double s3;
    cl_double s4;
    cl_double s5;
    cl_double s6;
    cl_double s7;
    cl_double s8;
    cl_double s9;
    cl_double sA;
    cl_double sB;
    cl_double sC;
    cl_double sD;
    cl_double sE;
    cl_double sF;
  };
  struct {
    cl_double8 lo;
    cl_double8 hi;
  };
  __cl_double2 v2[8];
  __cl_double4 v4[4];
};
typedef struct _cl_platform_id *cl_platform_id;
typedef struct _cl_device_id *cl_device_id;
typedef struct _cl_context *cl_context;
typedef struct _cl_command_queue *cl_command_queue;
typedef struct _cl_mem *cl_mem;
typedef struct _cl_program *cl_program;
typedef struct _cl_kernel *cl_kernel;
typedef struct _cl_event *cl_event;
typedef struct _cl_sampler *cl_sampler;
typedef cl_uint cl_bool;
typedef cl_ulong cl_bitfield;
typedef cl_bitfield cl_device_type;
typedef cl_uint cl_platform_info;
typedef cl_uint cl_device_info;
typedef cl_bitfield cl_device_fp_config;
typedef cl_uint cl_device_mem_cache_type;
typedef cl_uint cl_device_local_mem_type;
typedef cl_bitfield cl_device_exec_capabilities;
typedef cl_bitfield cl_command_queue_properties;
typedef intptr_t cl_device_partition_property;
typedef cl_bitfield cl_device_affinity_domain;
typedef intptr_t cl_context_properties;
typedef cl_uint cl_context_info;
typedef cl_uint cl_command_queue_info;
typedef cl_uint cl_channel_order;
typedef cl_uint cl_channel_type;
typedef cl_bitfield cl_mem_flags;
typedef cl_uint cl_mem_object_type;
typedef cl_uint cl_mem_info;
typedef cl_bitfield cl_mem_migration_flags;
typedef cl_uint cl_image_info;
typedef cl_uint cl_buffer_create_type;
typedef cl_uint cl_addressing_mode;
typedef cl_uint cl_filter_mode;
typedef cl_uint cl_sampler_info;
typedef cl_bitfield cl_map_flags;
typedef cl_uint cl_program_info;
typedef cl_uint cl_program_build_info;
typedef cl_uint cl_program_binary_type;
typedef cl_int cl_build_status;
typedef cl_uint cl_kernel_info;
typedef cl_uint cl_kernel_arg_info;
typedef cl_uint cl_kernel_arg_address_qualifier;
typedef cl_uint cl_kernel_arg_access_qualifier;
typedef cl_bitfield cl_kernel_arg_type_qualifier;
typedef cl_uint cl_kernel_work_group_info;
typedef cl_uint cl_event_info;
typedef cl_uint cl_command_type;
typedef cl_uint cl_profiling_info;
typedef struct cl_image_format cl_image_format;
struct cl_image_format {
  cl_channel_order image_channel_order;
  cl_channel_type image_channel_data_type;
};
typedef struct cl_image_desc cl_image_desc;
struct cl_image_desc {
  cl_mem_object_type image_type;
  size_t image_width;
  size_t image_height;
  size_t image_depth;
  size_t image_array_size;
  size_t image_row_pitch;
  size_t image_slice_pitch;
  cl_uint num_mip_levels;
  cl_uint num_samples;
  cl_mem mem_object;
};
typedef struct cl_buffer_region cl_buffer_region;
struct cl_buffer_region {
  size_t origin;
  size_t size;
};
static const int CL_SUCCESS = 0;
static const int CL_DEVICE_NOT_FOUND = -1;
static const int CL_DEVICE_NOT_AVAILABLE = -2;
static const int CL_COMPILER_NOT_AVAILABLE = -3;
static const int CL_MEM_OBJECT_ALLOCATION_FAILURE = -4;
static const int CL_OUT_OF_RESOURCES = -5;
static const int CL_OUT_OF_HOST_MEMORY = -6;
static const int CL_PROFILING_INFO_NOT_AVAILABLE = -7;
static const int CL_MEM_COPY_OVERLAP = -8;
static const int CL_IMAGE_FORMAT_MISMATCH = -9;
static const int CL_IMAGE_FORMAT_NOT_SUPPORTED = -10;
static const int CL_BUILD_PROGRAM_FAILURE = -11;
static const int CL_MAP_FAILURE = -12;
static const int CL_MISALIGNED_SUB_BUFFER_OFFSET = -13;
static const int CL_EXEC_STATUS_ERROR_FOR_EVENTS_IN_WAIT_LIST = -14;
static const int CL_COMPILE_PROGRAM_FAILURE = -15;
static const int CL_LINKER_NOT_AVAILABLE = -16;
static const int CL_LINK_PROGRAM_FAILURE = -17;
static const int CL_DEVICE_PARTITION_FAILED = -18;
static const int CL_KERNEL_ARG_INFO_NOT_AVAILABLE = -19;
static const int CL_INVALID_VALUE = -30;
static const int CL_INVALID_DEVICE_TYPE = -31;
static const int CL_INVALID_PLATFORM = -32;
static const int CL_INVALID_DEVICE = -33;
static const int CL_INVALID_CONTEXT = -34;
static const int CL_INVALID_QUEUE_PROPERTIES = -35;
static const int CL_INVALID_COMMAND_QUEUE = -36;
static const int CL_INVALID_HOST_PTR = -37;
static const int CL_INVALID_MEM_OBJECT = -38;
static const int CL_INVALID_IMAGE_FORMAT_DESCRIPTOR = -39;
static const int CL_INVALID_IMAGE_SIZE = -40;
static const int CL_INVALID_SAMPLER = -41;
static const int CL_INVALID_BINARY = -42;
static const int CL_INVALID_BUILD_OPTIONS = -43;
static const int CL_INVALID_PROGRAM = -44;
static const int CL_INVALID_PROGRAM_EXECUTABLE = -45;
static const int CL_INVALID_KERNEL_NAME = -46;
static const int CL_INVALID_KERNEL_DEFINITION = -47;
static const int CL_INVALID_KERNEL = -48;
static const int CL_INVALID_ARG_INDEX = -49;
static const int CL_INVALID_ARG_VALUE = -50;
static const int CL_INVALID_ARG_SIZE = -51;
static const int CL_INVALID_KERNEL_ARGS = -52;
static const int CL_INVALID_WORK_DIMENSION = -53;
static const int CL_INVALID_WORK_GROUP_SIZE = -54;
static const int CL_INVALID_WORK_ITEM_SIZE = -55;
static const int CL_INVALID_GLOBAL_OFFSET = -56;
static const int CL_INVALID_EVENT_WAIT_LIST = -57;
static const int CL_INVALID_EVENT = -58;
static const int CL_INVALID_OPERATION = -59;
static const int CL_INVALID_GL_OBJECT = -60;
static const int CL_INVALID_BUFFER_SIZE = -61;
static const int CL_INVALID_MIP_LEVEL = -62;
static const int CL_INVALID_GLOBAL_WORK_SIZE = -63;
static const int CL_INVALID_PROPERTY = -64;
static const int CL_INVALID_IMAGE_DESCRIPTOR = -65;
static const int CL_INVALID_COMPILER_OPTIONS = -66;
static const int CL_INVALID_LINKER_OPTIONS = -67;
static const int CL_INVALID_DEVICE_PARTITION_COUNT = -68;
static const int CL_VERSION_1_0 = 1;
static const int CL_VERSION_1_1 = 1;
static const int CL_VERSION_1_2 = 1;
static const int CL_FALSE = 0;
static const int CL_TRUE = 1;
static const int CL_BLOCKING = 1;
static const int CL_NON_BLOCKING = 0;
static const int CL_PLATFORM_PROFILE = 2304;
static const int CL_PLATFORM_VERSION = 2305;
static const int CL_PLATFORM_NAME = 2306;
static const int CL_PLATFORM_VENDOR = 2307;
static const int CL_PLATFORM_EXTENSIONS = 2308;
static const int CL_DEVICE_TYPE_DEFAULT = 1;
static const int CL_DEVICE_TYPE_CPU = 2;
static const int CL_DEVICE_TYPE_GPU = 4;
static const int CL_DEVICE_TYPE_ACCELERATOR = 8;
static const int CL_DEVICE_TYPE_CUSTOM = 16;
static const int CL_DEVICE_TYPE_ALL = 4294967295;
static const int CL_DEVICE_TYPE = 4096;
static const int CL_DEVICE_VENDOR_ID = 4097;
static const int CL_DEVICE_MAX_COMPUTE_UNITS = 4098;
static const int CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS = 4099;
static const int CL_DEVICE_MAX_WORK_GROUP_SIZE = 4100;
static const int CL_DEVICE_MAX_WORK_ITEM_SIZES = 4101;
static const int CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR = 4102;
static const int CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT = 4103;
static const int CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT = 4104;
static const int CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG = 4105;
static const int CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT = 4106;
static const int CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE = 4107;
static const int CL_DEVICE_MAX_CLOCK_FREQUENCY = 4108;
static const int CL_DEVICE_ADDRESS_BITS = 4109;
static const int CL_DEVICE_MAX_READ_IMAGE_ARGS = 4110;
static const int CL_DEVICE_MAX_WRITE_IMAGE_ARGS = 4111;
static const int CL_DEVICE_MAX_MEM_ALLOC_SIZE = 4112;
static const int CL_DEVICE_IMAGE2D_MAX_WIDTH = 4113;
static const int CL_DEVICE_IMAGE2D_MAX_HEIGHT = 4114;
static const int CL_DEVICE_IMAGE3D_MAX_WIDTH = 4115;
static const int CL_DEVICE_IMAGE3D_MAX_HEIGHT = 4116;
static const int CL_DEVICE_IMAGE3D_MAX_DEPTH = 4117;
static const int CL_DEVICE_IMAGE_SUPPORT = 4118;
static const int CL_DEVICE_MAX_PARAMETER_SIZE = 4119;
static const int CL_DEVICE_MAX_SAMPLERS = 4120;
static const int CL_DEVICE_MEM_BASE_ADDR_ALIGN = 4121;
static const int CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE = 4122;
static const int CL_DEVICE_SINGLE_FP_CONFIG = 4123;
static const int CL_DEVICE_GLOBAL_MEM_CACHE_TYPE = 4124;
static const int CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE = 4125;
static const int CL_DEVICE_GLOBAL_MEM_CACHE_SIZE = 4126;
static const int CL_DEVICE_GLOBAL_MEM_SIZE = 4127;
static const int CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE = 4128;
static const int CL_DEVICE_MAX_CONSTANT_ARGS = 4129;
static const int CL_DEVICE_LOCAL_MEM_TYPE = 4130;
static const int CL_DEVICE_LOCAL_MEM_SIZE = 4131;
static const int CL_DEVICE_ERROR_CORRECTION_SUPPORT = 4132;
static const int CL_DEVICE_PROFILING_TIMER_RESOLUTION = 4133;
static const int CL_DEVICE_ENDIAN_LITTLE = 4134;
static const int CL_DEVICE_AVAILABLE = 4135;
static const int CL_DEVICE_COMPILER_AVAILABLE = 4136;
static const int CL_DEVICE_EXECUTION_CAPABILITIES = 4137;
static const int CL_DEVICE_QUEUE_PROPERTIES = 4138;
static const int CL_DEVICE_NAME = 4139;
static const int CL_DEVICE_VENDOR = 4140;
static const int CL_DRIVER_VERSION = 4141;
static const int CL_DEVICE_PROFILE = 4142;
static const int CL_DEVICE_VERSION = 4143;
static const int CL_DEVICE_EXTENSIONS = 4144;
static const int CL_DEVICE_PLATFORM = 4145;
static const int CL_DEVICE_DOUBLE_FP_CONFIG = 4146;
static const int CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF = 4148;
static const int CL_DEVICE_HOST_UNIFIED_MEMORY = 4149;
static const int CL_DEVICE_HALF_FP_CONFIG = 4147;
static const int CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR = 4150;
static const int CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT = 4151;
static const int CL_DEVICE_NATIVE_VECTOR_WIDTH_INT = 4152;
static const int CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG = 4153;
static const int CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT = 4154;
static const int CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE = 4155;
static const int CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF = 4156;
static const int CL_DEVICE_OPENCL_C_VERSION = 4157;
static const int CL_DEVICE_LINKER_AVAILABLE = 4158;
static const int CL_DEVICE_BUILT_IN_KERNELS = 4159;
static const int CL_DEVICE_IMAGE_MAX_BUFFER_SIZE = 4160;
static const int CL_DEVICE_IMAGE_MAX_ARRAY_SIZE = 4161;
static const int CL_DEVICE_PARENT_DEVICE = 4162;
static const int CL_DEVICE_PARTITION_MAX_SUB_DEVICES = 4163;
static const int CL_DEVICE_PARTITION_PROPERTIES = 4164;
static const int CL_DEVICE_PARTITION_AFFINITY_DOMAIN = 4165;
static const int CL_DEVICE_PARTITION_TYPE = 4166;
static const int CL_DEVICE_REFERENCE_COUNT = 4167;
static const int CL_DEVICE_PREFERRED_INTEROP_USER_SYNC = 4168;
static const int CL_DEVICE_PRINTF_BUFFER_SIZE = 4169;
static const int CL_FP_DENORM = 1;
static const int CL_FP_INF_NAN = 2;
static const int CL_FP_ROUND_TO_NEAREST = 4;
static const int CL_FP_ROUND_TO_ZERO = 8;
static const int CL_FP_ROUND_TO_INF = 16;
static const int CL_FP_FMA = 32;
static const int CL_FP_SOFT_FLOAT = 64;
static const int CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT = 128;
static const int CL_NONE = 0;
static const int CL_READ_ONLY_CACHE = 1;
static const int CL_READ_WRITE_CACHE = 2;
static const int CL_LOCAL = 1;
static const int CL_GLOBAL = 2;
static const int CL_EXEC_KERNEL = 1;
static const int CL_EXEC_NATIVE_KERNEL = 2;
static const int CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE = 1;
static const int CL_QUEUE_PROFILING_ENABLE = 2;
static const int CL_CONTEXT_REFERENCE_COUNT = 4224;
static const int CL_CONTEXT_DEVICES = 4225;
static const int CL_CONTEXT_PROPERTIES = 4226;
static const int CL_CONTEXT_NUM_DEVICES = 4227;
static const int CL_CONTEXT_PLATFORM = 4228;
static const int CL_CONTEXT_INTEROP_USER_SYNC = 4229;
static const int CL_DEVICE_PARTITION_EQUALLY = 4230;
static const int CL_DEVICE_PARTITION_BY_COUNTS = 4231;
static const int CL_DEVICE_PARTITION_BY_COUNTS_LIST_END = 0;
static const int CL_DEVICE_PARTITION_BY_AFFINITY_DOMAIN = 4232;
static const int CL_DEVICE_AFFINITY_DOMAIN_NUMA = 1;
static const int CL_DEVICE_AFFINITY_DOMAIN_L4_CACHE = 2;
static const int CL_DEVICE_AFFINITY_DOMAIN_L3_CACHE = 4;
static const int CL_DEVICE_AFFINITY_DOMAIN_L2_CACHE = 8;
static const int CL_DEVICE_AFFINITY_DOMAIN_L1_CACHE = 16;
static const int CL_DEVICE_AFFINITY_DOMAIN_NEXT_PARTITIONABLE = 32;
static const int CL_QUEUE_CONTEXT = 4240;
static const int CL_QUEUE_DEVICE = 4241;
static const int CL_QUEUE_REFERENCE_COUNT = 4242;
static const int CL_QUEUE_PROPERTIES = 4243;
static const int CL_MEM_READ_WRITE = 1;
static const int CL_MEM_WRITE_ONLY = 2;
static const int CL_MEM_READ_ONLY = 4;
static const int CL_MEM_USE_HOST_PTR = 8;
static const int CL_MEM_ALLOC_HOST_PTR = 16;
static const int CL_MEM_COPY_HOST_PTR = 32;
static const int CL_MEM_HOST_WRITE_ONLY = 128;
static const int CL_MEM_HOST_READ_ONLY = 256;
static const int CL_MEM_HOST_NO_ACCESS = 512;
static const int CL_MIGRATE_MEM_OBJECT_HOST = 1;
static const int CL_MIGRATE_MEM_OBJECT_CONTENT_UNDEFINED = 2;
static const int CL_R = 4272;
static const int CL_A = 4273;
static const int CL_RG = 4274;
static const int CL_RA = 4275;
static const int CL_RGB = 4276;
static const int CL_RGBA = 4277;
static const int CL_BGRA = 4278;
static const int CL_ARGB = 4279;
static const int CL_INTENSITY = 4280;
static const int CL_LUMINANCE = 4281;
static const int CL_Rx = 4282;
static const int CL_RGx = 4283;
static const int CL_RGBx = 4284;
static const int CL_SNORM_INT8 = 4304;
static const int CL_SNORM_INT16 = 4305;
static const int CL_UNORM_INT8 = 4306;
static const int CL_UNORM_INT16 = 4307;
static const int CL_UNORM_SHORT_565 = 4308;
static const int CL_UNORM_SHORT_555 = 4309;
static const int CL_UNORM_INT_101010 = 4310;
static const int CL_SIGNED_INT8 = 4311;
static const int CL_SIGNED_INT16 = 4312;
static const int CL_SIGNED_INT32 = 4313;
static const int CL_UNSIGNED_INT8 = 4314;
static const int CL_UNSIGNED_INT16 = 4315;
static const int CL_UNSIGNED_INT32 = 4316;
static const int CL_HALF_FLOAT = 4317;
static const int CL_FLOAT = 4318;
static const int CL_MEM_OBJECT_BUFFER = 4336;
static const int CL_MEM_OBJECT_IMAGE2D = 4337;
static const int CL_MEM_OBJECT_IMAGE3D = 4338;
static const int CL_MEM_OBJECT_IMAGE2D_ARRAY = 4339;
static const int CL_MEM_OBJECT_IMAGE1D = 4340;
static const int CL_MEM_OBJECT_IMAGE1D_ARRAY = 4341;
static const int CL_MEM_OBJECT_IMAGE1D_BUFFER = 4342;
static const int CL_MEM_TYPE = 4352;
static const int CL_MEM_FLAGS = 4353;
static const int CL_MEM_SIZE = 4354;
static const int CL_MEM_HOST_PTR = 4355;
static const int CL_MEM_MAP_COUNT = 4356;
static const int CL_MEM_REFERENCE_COUNT = 4357;
static const int CL_MEM_CONTEXT = 4358;
static const int CL_MEM_ASSOCIATED_MEMOBJECT = 4359;
static const int CL_MEM_OFFSET = 4360;
static const int CL_IMAGE_FORMAT = 4368;
static const int CL_IMAGE_ELEMENT_SIZE = 4369;
static const int CL_IMAGE_ROW_PITCH = 4370;
static const int CL_IMAGE_SLICE_PITCH = 4371;
static const int CL_IMAGE_WIDTH = 4372;
static const int CL_IMAGE_HEIGHT = 4373;
static const int CL_IMAGE_DEPTH = 4374;
static const int CL_IMAGE_ARRAY_SIZE = 4375;
static const int CL_IMAGE_BUFFER = 4376;
static const int CL_IMAGE_NUM_MIP_LEVELS = 4377;
static const int CL_IMAGE_NUM_SAMPLES = 4378;
static const int CL_ADDRESS_NONE = 4400;
static const int CL_ADDRESS_CLAMP_TO_EDGE = 4401;
static const int CL_ADDRESS_CLAMP = 4402;
static const int CL_ADDRESS_REPEAT = 4403;
static const int CL_ADDRESS_MIRRORED_REPEAT = 4404;
static const int CL_FILTER_NEAREST = 4416;
static const int CL_FILTER_LINEAR = 4417;
static const int CL_SAMPLER_REFERENCE_COUNT = 4432;
static const int CL_SAMPLER_CONTEXT = 4433;
static const int CL_SAMPLER_NORMALIZED_COORDS = 4434;
static const int CL_SAMPLER_ADDRESSING_MODE = 4435;
static const int CL_SAMPLER_FILTER_MODE = 4436;
static const int CL_MAP_READ = 1;
static const int CL_MAP_WRITE = 2;
static const int CL_MAP_WRITE_INVALIDATE_REGION = 4;
static const int CL_PROGRAM_REFERENCE_COUNT = 4448;
static const int CL_PROGRAM_CONTEXT = 4449;
static const int CL_PROGRAM_NUM_DEVICES = 4450;
static const int CL_PROGRAM_DEVICES = 4451;
static const int CL_PROGRAM_SOURCE = 4452;
static const int CL_PROGRAM_BINARY_SIZES = 4453;
static const int CL_PROGRAM_BINARIES = 4454;
static const int CL_PROGRAM_NUM_KERNELS = 4455;
static const int CL_PROGRAM_KERNEL_NAMES = 4456;
static const int CL_PROGRAM_BUILD_STATUS = 4481;
static const int CL_PROGRAM_BUILD_OPTIONS = 4482;
static const int CL_PROGRAM_BUILD_LOG = 4483;
static const int CL_PROGRAM_BINARY_TYPE = 4484;
static const int CL_PROGRAM_BINARY_TYPE_NONE = 0;
static const int CL_PROGRAM_BINARY_TYPE_COMPILED_OBJECT = 1;
static const int CL_PROGRAM_BINARY_TYPE_LIBRARY = 2;
static const int CL_PROGRAM_BINARY_TYPE_EXECUTABLE = 4;
static const int CL_BUILD_SUCCESS = 0;
static const int CL_BUILD_NONE = -1;
static const int CL_BUILD_ERROR = -2;
static const int CL_BUILD_IN_PROGRESS = -3;
static const int CL_KERNEL_FUNCTION_NAME = 4496;
static const int CL_KERNEL_NUM_ARGS = 4497;
static const int CL_KERNEL_REFERENCE_COUNT = 4498;
static const int CL_KERNEL_CONTEXT = 4499;
static const int CL_KERNEL_PROGRAM = 4500;
static const int CL_KERNEL_ATTRIBUTES = 4501;
static const int CL_KERNEL_ARG_ADDRESS_QUALIFIER = 4502;
static const int CL_KERNEL_ARG_ACCESS_QUALIFIER = 4503;
static const int CL_KERNEL_ARG_TYPE_NAME = 4504;
static const int CL_KERNEL_ARG_TYPE_QUALIFIER = 4505;
static const int CL_KERNEL_ARG_NAME = 4506;
static const int CL_KERNEL_ARG_ADDRESS_GLOBAL = 4507;
static const int CL_KERNEL_ARG_ADDRESS_LOCAL = 4508;
static const int CL_KERNEL_ARG_ADDRESS_CONSTANT = 4509;
static const int CL_KERNEL_ARG_ADDRESS_PRIVATE = 4510;
static const int CL_KERNEL_ARG_ACCESS_READ_ONLY = 4512;
static const int CL_KERNEL_ARG_ACCESS_WRITE_ONLY = 4513;
static const int CL_KERNEL_ARG_ACCESS_READ_WRITE = 4514;
static const int CL_KERNEL_ARG_ACCESS_NONE = 4515;
static const int CL_KERNEL_ARG_TYPE_NONE = 0;
static const int CL_KERNEL_ARG_TYPE_CONST = 1;
static const int CL_KERNEL_ARG_TYPE_RESTRICT = 2;
static const int CL_KERNEL_ARG_TYPE_VOLATILE = 4;
static const int CL_KERNEL_WORK_GROUP_SIZE = 4528;
static const int CL_KERNEL_COMPILE_WORK_GROUP_SIZE = 4529;
static const int CL_KERNEL_LOCAL_MEM_SIZE = 4530;
static const int CL_KERNEL_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = 4531;
static const int CL_KERNEL_PRIVATE_MEM_SIZE = 4532;
static const int CL_KERNEL_GLOBAL_WORK_SIZE = 4533;
static const int CL_EVENT_COMMAND_QUEUE = 4560;
static const int CL_EVENT_COMMAND_TYPE = 4561;
static const int CL_EVENT_REFERENCE_COUNT = 4562;
static const int CL_EVENT_COMMAND_EXECUTION_STATUS = 4563;
static const int CL_EVENT_CONTEXT = 4564;
static const int CL_COMMAND_NDRANGE_KERNEL = 4592;
static const int CL_COMMAND_TASK = 4593;
static const int CL_COMMAND_NATIVE_KERNEL = 4594;
static const int CL_COMMAND_READ_BUFFER = 4595;
static const int CL_COMMAND_WRITE_BUFFER = 4596;
static const int CL_COMMAND_COPY_BUFFER = 4597;
static const int CL_COMMAND_READ_IMAGE = 4598;
static const int CL_COMMAND_WRITE_IMAGE = 4599;
static const int CL_COMMAND_COPY_IMAGE = 4600;
static const int CL_COMMAND_COPY_IMAGE_TO_BUFFER = 4601;
static const int CL_COMMAND_COPY_BUFFER_TO_IMAGE = 4602;
static const int CL_COMMAND_MAP_BUFFER = 4603;
static const int CL_COMMAND_MAP_IMAGE = 4604;
static const int CL_COMMAND_UNMAP_MEM_OBJECT = 4605;
static const int CL_COMMAND_MARKER = 4606;
static const int CL_COMMAND_ACQUIRE_GL_OBJECTS = 4607;
static const int CL_COMMAND_RELEASE_GL_OBJECTS = 4608;
static const int CL_COMMAND_READ_BUFFER_RECT = 4609;
static const int CL_COMMAND_WRITE_BUFFER_RECT = 4610;
static const int CL_COMMAND_COPY_BUFFER_RECT = 4611;
static const int CL_COMMAND_USER = 4612;
static const int CL_COMMAND_BARRIER = 4613;
static const int CL_COMMAND_MIGRATE_MEM_OBJECTS = 4614;
static const int CL_COMMAND_FILL_BUFFER = 4615;
static const int CL_COMMAND_FILL_IMAGE = 4616;
static const int CL_COMPLETE = 0;
static const int CL_RUNNING = 1;
static const int CL_SUBMITTED = 2;
static const int CL_QUEUED = 3;
static const int CL_BUFFER_CREATE_TYPE_REGION = 4640;
static const int CL_PROFILING_COMMAND_QUEUED = 4736;
static const int CL_PROFILING_COMMAND_SUBMIT = 4737;
static const int CL_PROFILING_COMMAND_START = 4738;
static const int CL_PROFILING_COMMAND_END = 4739;
cl_int clGetPlatformIDs(cl_uint, cl_platform_id *, cl_uint *);
cl_int clGetPlatformInfo(cl_platform_id, cl_platform_info, size_t, void *, size_t *);
cl_int clGetDeviceIDs(cl_platform_id, cl_device_type, cl_uint, cl_device_id *, cl_uint *);
cl_int clGetDeviceInfo(cl_device_id, cl_device_info, size_t, void *, size_t *);
cl_int clCreateSubDevices(cl_device_id, const cl_device_partition_property *, cl_uint, cl_device_id *, cl_uint *);
cl_int clRetainDevice(cl_device_id);
cl_int clReleaseDevice(cl_device_id);
cl_context clCreateContext(const cl_context_properties *, cl_uint, const cl_device_id *, void (*)(const char *, const void *, size_t, void *), void *, cl_int *);
cl_context clCreateContextFromType(const cl_context_properties *, cl_device_type, void (*)(const char *, const void *, size_t, void *), void *, cl_int *);
cl_int clRetainContext(cl_context);
cl_int clReleaseContext(cl_context);
cl_int clGetContextInfo(cl_context, cl_context_info, size_t, void *, size_t *);
cl_command_queue clCreateCommandQueue(cl_context, cl_device_id, cl_command_queue_properties, cl_int *);
cl_int clRetainCommandQueue(cl_command_queue);
cl_int clReleaseCommandQueue(cl_command_queue);
cl_int clGetCommandQueueInfo(cl_command_queue, cl_command_queue_info, size_t, void *, size_t *);
cl_mem clCreateBuffer(cl_context, cl_mem_flags, size_t, void *, cl_int *);
cl_mem clCreateSubBuffer(cl_mem, cl_mem_flags, cl_buffer_create_type, const void *, cl_int *);
cl_mem clCreateImage(cl_context, cl_mem_flags, const cl_image_format *, const cl_image_desc *, void *, cl_int *);
cl_int clRetainMemObject(cl_mem);
cl_int clReleaseMemObject(cl_mem);
cl_int clGetSupportedImageFormats(cl_context, cl_mem_flags, cl_mem_object_type, cl_uint, cl_image_format *, cl_uint *);
cl_int clGetMemObjectInfo(cl_mem, cl_mem_info, size_t, void *, size_t *);
cl_int clGetImageInfo(cl_mem, cl_image_info, size_t, void *, size_t *);
cl_int clSetMemObjectDestructorCallback(cl_mem, void (*)(cl_mem, void *), void *);
cl_sampler clCreateSampler(cl_context, cl_bool, cl_addressing_mode, cl_filter_mode, cl_int *);
cl_int clRetainSampler(cl_sampler);
cl_int clReleaseSampler(cl_sampler);
cl_int clGetSamplerInfo(cl_sampler, cl_sampler_info, size_t, void *, size_t *);
cl_program clCreateProgramWithSource(cl_context, cl_uint, const char **, const size_t *, cl_int *);
cl_program clCreateProgramWithBinary(cl_context, cl_uint, const cl_device_id *, const size_t *, const unsigned char **, cl_int *, cl_int *);
cl_program clCreateProgramWithBuiltInKernels(cl_context, cl_uint, const cl_device_id *, const char *, cl_int *);
cl_int clRetainProgram(cl_program);
cl_int clReleaseProgram(cl_program);
cl_int clBuildProgram(cl_program, cl_uint, const cl_device_id *, const char *, void (*)(cl_program, void *), void *);
cl_int clCompileProgram(cl_program, cl_uint, const cl_device_id *, const char *, cl_uint, const cl_program *, const char **, void (*)(cl_program, void *), void *);
cl_program clLinkProgram(cl_context, cl_uint, const cl_device_id *, const char *, cl_uint, const cl_program *, void (*)(cl_program, void *), void *, cl_int *);
cl_int clUnloadPlatformCompiler(cl_platform_id);
cl_int clGetProgramInfo(cl_program, cl_program_info, size_t, void *, size_t *);
cl_int clGetProgramBuildInfo(cl_program, cl_device_id, cl_program_build_info, size_t, void *, size_t *);
cl_kernel clCreateKernel(cl_program, const char *, cl_int *);
cl_int clCreateKernelsInProgram(cl_program, cl_uint, cl_kernel *, cl_uint *);
cl_int clRetainKernel(cl_kernel);
cl_int clReleaseKernel(cl_kernel);
cl_int clSetKernelArg(cl_kernel, cl_uint, size_t, const void *);
cl_int clGetKernelInfo(cl_kernel, cl_kernel_info, size_t, void *, size_t *);
cl_int clGetKernelArgInfo(cl_kernel, cl_uint, cl_kernel_arg_info, size_t, void *, size_t *);
cl_int clGetKernelWorkGroupInfo(cl_kernel, cl_device_id, cl_kernel_work_group_info, size_t, void *, size_t *);
cl_int clWaitForEvents(cl_uint, const cl_event *);
cl_int clGetEventInfo(cl_event, cl_event_info, size_t, void *, size_t *);
cl_event clCreateUserEvent(cl_context, cl_int *);
cl_int clRetainEvent(cl_event);
cl_int clReleaseEvent(cl_event);
cl_int clSetUserEventStatus(cl_event, cl_int);
cl_int clSetEventCallback(cl_event, cl_int, void (*)(cl_event, cl_int, void *), void *);
cl_int clGetEventProfilingInfo(cl_event, cl_profiling_info, size_t, void *, size_t *);
cl_int clFlush(cl_command_queue);
cl_int clFinish(cl_command_queue);
cl_int clEnqueueReadBuffer(cl_command_queue, cl_mem, cl_bool, size_t, size_t, void *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueReadBufferRect(cl_command_queue, cl_mem, cl_bool, const size_t *, const size_t *, const size_t *, size_t, size_t, size_t, size_t, void *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueWriteBuffer(cl_command_queue, cl_mem, cl_bool, size_t, size_t, const void *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueWriteBufferRect(cl_command_queue, cl_mem, cl_bool, const size_t *, const size_t *, const size_t *, size_t, size_t, size_t, size_t, const void *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueFillBuffer(cl_command_queue, cl_mem, const void *, size_t, size_t, size_t, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueCopyBuffer(cl_command_queue, cl_mem, cl_mem, size_t, size_t, size_t, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueCopyBufferRect(cl_command_queue, cl_mem, cl_mem, const size_t *, const size_t *, const size_t *, size_t, size_t, size_t, size_t, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueReadImage(cl_command_queue, cl_mem, cl_bool, const size_t *, const size_t *, size_t, size_t, void *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueWriteImage(cl_command_queue, cl_mem, cl_bool, const size_t *, const size_t *, size_t, size_t, const void *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueFillImage(cl_command_queue, cl_mem, const void *, const size_t *, const size_t *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueCopyImage(cl_command_queue, cl_mem, cl_mem, const size_t *, const size_t *, const size_t *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueCopyImageToBuffer(cl_command_queue, cl_mem, cl_mem, const size_t *, const size_t *, size_t, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueCopyBufferToImage(cl_command_queue, cl_mem, cl_mem, size_t, const size_t *, const size_t *, cl_uint, const cl_event *, cl_event *);
void *clEnqueueMapBuffer(cl_command_queue, cl_mem, cl_bool, cl_map_flags, size_t, size_t, cl_uint, const cl_event *, cl_event *, cl_int *);
void *clEnqueueMapImage(cl_command_queue, cl_mem, cl_bool, cl_map_flags, const size_t *, const size_t *, size_t *, size_t *, cl_uint, const cl_event *, cl_event *, cl_int *);
cl_int clEnqueueUnmapMemObject(cl_command_queue, cl_mem, void *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueMigrateMemObjects(cl_command_queue, cl_uint, const cl_mem *, cl_mem_migration_flags, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueNDRangeKernel(cl_command_queue, cl_kernel, cl_uint, const size_t *, const size_t *, const size_t *, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueTask(cl_command_queue, cl_kernel, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueNativeKernel(cl_command_queue, void (*)(void *), void *, size_t, cl_uint, const cl_mem *, const void **, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueMarkerWithWaitList(cl_command_queue, cl_uint, const cl_event *, cl_event *);
cl_int clEnqueueBarrierWithWaitList(cl_command_queue, cl_uint, const cl_event *, cl_event *);
void *clGetExtensionFunctionAddressForPlatform(cl_platform_id, const char *);
cl_mem clCreateImage2D(cl_context, cl_mem_flags, const cl_image_format *, size_t, size_t, size_t, void *, cl_int *);
cl_mem clCreateImage3D(cl_context, cl_mem_flags, const cl_image_format *, size_t, size_t, size_t, size_t, size_t, void *, cl_int *);
cl_int clEnqueueMarker(cl_command_queue, cl_event *);
cl_int clEnqueueWaitForEvents(cl_command_queue, cl_uint, const cl_event *);
cl_int clEnqueueBarrier(cl_command_queue);
cl_int clUnloadCompiler(void);
void *clGetExtensionFunctionAddress(const char *);
]]

-- If the OpenCL library has been linked to the application, use OpenCL
-- symbols from default, global namespace. Otherwise, dynamically load
-- the OpenCL library into its own, non-global C library namespace.
local C
if pcall(function() return ffi.C.clGetPlatformIDs end) then
  C = ffi.C
else
  C = ffi.load("OpenCL")
end
return C
