#include "dotprod.h"

// may_alias: allows safely reading int8_t buffers as 64-bit doublewords at -O2
typedef uint64_t __attribute__((may_alias)) u64a;

// dot8 rd, rs1, rs2 (custom-0: opcode 0x0b, funct3=0, funct7=0)
static inline int64_t dot8(uint64_t a, uint64_t b) {
    int64_t r;
    asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
    return r;
}

/* -------------------------------------------------------------
 * 1. Standard (Non-unrolled) Kernels
 * ------------------------------------------------------------- */
__attribute__((noinline))
int64_t dot_base(const int8_t *a, const int8_t *b, int n) {
    int64_t sum = 0;
    #pragma GCC unroll 1
    for (int i = 0; i < n; i++) {
        sum += (int64_t)a[i] * b[i];
    }
    return sum;
}

__attribute__((noinline))
int64_t dot_custom(const int8_t *a, const int8_t *b, int n) {
    int64_t sum = 0;
    const u64a *ptr_a = (const u64a *)a;
    const u64a *ptr_b = (const u64a *)b;
    int n_vec = n / 8;

    #pragma GCC unroll 1
    for (int i = 0; i < n_vec; i++) {
        sum += dot8(ptr_a[i], ptr_b[i]);
    }

    /* Scalar tail for remainder elements */
    for (int i = n_vec * 8; i < n; i++) {
        sum += (int64_t)a[i] * b[i];
    }
    return sum;
}

/* -------------------------------------------------------------
 * 2. Unrolled Kernels (8x scalar baseline, 4x custom dot8)
 * ------------------------------------------------------------- */
__attribute__((noinline))
int64_t dot_base_unroll(const int8_t *a, const int8_t *b, int n) {
    int64_t sum = 0;
    #pragma GCC unroll 8
    for (int i = 0; i < n; i++) {
        sum += (int64_t)a[i] * b[i];
    }
    return sum;
}

__attribute__((noinline))
int64_t dot_custom_unroll(const int8_t *a, const int8_t *b, int n) {
    int64_t sum = 0;
    const u64a *ptr_a = (const u64a *)a;
    const u64a *ptr_b = (const u64a *)b;
    int n_vec = n / 8;

    #pragma GCC unroll 4
    for (int i = 0; i < n_vec; i++) {
        sum += dot8(ptr_a[i], ptr_b[i]);
    }

    /* Scalar tail for remainder elements */
    for (int i = n_vec * 8; i < n; i++) {
        sum += (int64_t)a[i] * b[i];
    }
    return sum;
}