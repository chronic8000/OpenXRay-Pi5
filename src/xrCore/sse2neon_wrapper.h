#ifndef SSE2NEON_WRAPPER_H
#define SSE2NEON_WRAPPER_H

#if defined(__aarch64__) || defined(__arm64__) || defined(_M_ARM64)
    #define SSE2NEON_PRECISE_MINMAX 1
    #define SSE2NEON_ARCH_AARCH64 1
    #include <sse2neon.h>

    // Manual mappings for "Ultimate" performance tier
    #undef _mm_pause
    #define _mm_pause() __asm__ __volatile__("yield" ::: "memory")

    #undef _mm_set_ps
    #define _mm_set_ps(f3, f2, f1, f0) \
        ((f0 == f1 && f1 == f2 && f2 == f3) ? \
        (float32x4_t)vdupq_n_f32(f0) : \
        (float32x4_t){f0, f1, f2, f3})

    // L3 Cache Hinting for Pi 5 (2MB L3)
    #define XRAY_PREFETCH_L3(addr) __builtin_prefetch((const void*)(addr), 0, 3)
#else
    #include <xmmintrin.h>
    #include <emmintrin.h>
    #define XRAY_PREFETCH_L3(addr)
#endif

#endif // SSE2NEON_WRAPPER_H
