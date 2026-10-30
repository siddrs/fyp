#include "dot.h"

int64_t dot_product(const int8_t *a, const int8_t *b, int n) {
    int64_t sum = 0;
    for (int i = 0; i < n; i++)
        sum += (int64_t)a[i] * b[i];
    return sum;
}
