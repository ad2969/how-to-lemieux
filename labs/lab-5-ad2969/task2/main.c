#include <stdlib.h>
#include <stdio.h>
#include "hw_counter.h"

#define lower_bits (volatile unsigned long *) 0x000a100
#define upper_bits (volatile unsigned long *) 0x000a104
#define initial_count (volatile unsigned long *) 0x000a110
#define count (volatile unsigned long *) 0x000a120

int measure(int, int);

void main() {
  measure(1000, 2000);
}

int __attribute__((noinline)) measure(int min_i, int max_i) {
    register int i, j;
    j = 0;

    /* begin timing */

    // Take initial count value
    (*initial_count) = hw_counter();

    /* begin timing */

    for (i = min_i; i < max_i; ++i) {
      j += i * i;
    }

    /* end timing */

    // Compute final count value
    (*count) = hw_counter();
    (*count) = (*count) - (*initial_count);
    (*count) = (*count)/(max_i - min_i);

    /* end timing */

    return j;
}
