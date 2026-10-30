#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include "dotprod.h"

#define MAXN 1024

static int8_t A[MAXN] __attribute__((aligned(8)));
static int8_t B[MAXN] __attribute__((aligned(8)));

static inline uint64_t rdinstret(void) {
    uint64_t x;
    asm volatile("rdinstret %0" : "=r"(x));
    return x;
}

int main(void) {
    uint32_t seed = 12345;
    for (int i = 0; i < MAXN; i++) {
        seed = seed * 1103515245u + 12345u; A[i] = (int8_t)(seed >> 16);
        seed = seed * 1103515245u + 12345u; B[i] = (int8_t)(seed >> 16);
    }

    int sizes[] = {8, 64, 256, 1024};
    int nsizes = (int)(sizeof sizes / sizeof sizes[0]);

    printf("\n================ INT8 Dot Product: Retired Instructions (Spike) ================\n\n");
    printf("%-5s | %-16s | %8s | %8s | %8s | %6s | %s\n", 
           "N", "Config", "I_base", "I_cust", "IR (%)", "Ratio", "Check");
    printf("------+------------------+----------+----------+----------+--------+------\n");

    for (int k = 0; k < nsizes; k++) {
        int n = sizes[k];

        /* 1. Standard (1x) */
        uint64_t t0 = rdinstret();
        int64_t  rb1 = dot_base(A, B, n);
        uint64_t t1 = rdinstret();
        uint64_t ib1 = t1 - t0;

        uint64_t t2 = rdinstret();
        int64_t  rc1 = dot_custom(A, B, n);
        uint64_t t3 = rdinstret();
        uint64_t ic1 = t3 - t2;

        double ir1 = 100.0 * (double)(ib1 - ic1) / (double)ib1;
        printf("%-5d | Standard (1x)    | %8" PRIu64 " | %8" PRIu64 " | %7.1f%% | %5.2fx | %s\n",
               n, ib1, ic1, ir1, (double)ib1 / (double)ic1, rb1 == rc1 ? "PASS" : "FAIL");

        /* 2. Unrolled (Base 8x / Cust 4x) */
        uint64_t t4 = rdinstret();
        int64_t  rbu = dot_base_unroll(A, B, n);
        uint64_t t5 = rdinstret();
        uint64_t ibu = t5 - t4;

        uint64_t t6 = rdinstret();
        int64_t  rcu = dot_custom_unroll(A, B, n);
        uint64_t t7 = rdinstret();
        uint64_t icu = t7 - t6;

        double iru = 100.0 * (double)(ibu - icu) / (double)ibu;
        printf("%-5d | Unrolled (8x/4x) | %8" PRIu64 " | %8" PRIu64 " | %7.1f%% | %5.2fx | %s\n",
               n, ibu, icu, iru, (double)ibu / (double)icu, (rbu == rcu && rbu == rb1) ? "PASS" : "FAIL");
        printf("------+------------------+----------+----------+----------+--------+------\n");
    }

    /* Tail check (N=1021) */
    int64_t t_b = dot_base(A, B, 1021);
    int64_t t_c = dot_custom(A, B, 1021);
    int64_t t_bu = dot_base_unroll(A, B, 1021);
    int64_t t_cu = dot_custom_unroll(A, B, 1021);
    printf("\nTail Check (N=1021): %s\n",
           (t_b == t_c && t_c == t_bu && t_bu == t_cu) ? "ALL PASS" : "FAIL");

    return 0;
}