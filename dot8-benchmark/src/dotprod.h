#ifndef DOTPROD_H
#define DOTPROD_H

#include <stdint.h>

// Standard Non-unrolled (1x)
int64_t dot_base(const int8_t *a, const int8_t *b, int n);
int64_t dot_custom(const int8_t *a, const int8_t *b, int n);

// Unrolled (8x baseline, 4x custom)
int64_t dot_base_unroll(const int8_t *a, const int8_t *b, int n);
int64_t dot_custom_unroll(const int8_t *a, const int8_t *b, int n);

#endif