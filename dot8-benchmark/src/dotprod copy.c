#include "dotprod.h"

// may_alias: lets us read int8_t storage through a 64-bit pointer
typedef uint64_t __attribute__((may_alias)) u64a;

__attribute__((noinline))
int64_t dot_base(const int8_t *a, const int8_t *b, int n) {
    int64_t s = 0;
    for (int i = 0; i < n; i++)
        s += (int64_t)a[i] * b[i];
    return s;
}

/* dot8 rd, rs1, rs2  (custom-0: opcode 0x0b, funct3=0, funct7=0)
 * rd = sum_{k=0..7} int8(rs1 byte k) * int8(rs2 byte k)   (no accumulate) */
static inline int64_t dot8(uint64_t a, uint64_t b) {
    int64_t r;
    asm volatile(".insn r 0x0b, 0, 0, %0, %1, %2" : "=r"(r) : "r"(a), "r"(b));
    return r;
}

__attribute__((noinline))
int64_t dot_custom(const int8_t *a, const int8_t *b, int n) {
    const u64a *pa = __builtin_assume_aligned(a, 8);
    const u64a *pb = __builtin_assume_aligned(b, 8);
    int64_t s = 0;
    int nw = n >> 3;                       /* number of full 8-byte words */

    for (int j = 0; j < nw; j++) {
        s += dot8(pa[j], pb[j]);           /* ld, ld, dot8, add */
    }
        
    for (int i = nw << 3; i < n; i++) {
        s += (int64_t)a[i] * b[i];          /* scalar tail */
    }
    
    return s;
}