#include <stdio.h>
#include <inttypes.h>
#include "dot.h"

int main(void) {
    int8_t a[8] = {2, 1, 4, 5, 6, 2, 8, 4};
    int8_t b[8] = {1, 3, 3, 2, 4, 2, 1, 2};
    printf("%" PRIi64 "\n", dot_product(a, b, 8));
    return 0;
}