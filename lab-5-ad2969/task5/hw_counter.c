/* NOTE: this file must be self-contained */
#define lower_bits (volatile unsigned long *) 0x000a100
#define upper_bits (volatile unsigned long *) 0x000a104
#define initial_count (volatile unsigned long *) 0x000a110
#define count (volatile unsigned long *) 0x000a120
#include "hw_counter.h"

inline unsigned long long hw_counter() {
    /* your code here */

    // Overcoming corner case
    if(*upper_bits == 0x00000002 || *upper_bits == 0x00000001) {
      if(*lower_bits == 0x00000008) {
        (*count) = 0x00000001ffffffff;
      }
    }
    else {
      (*count) = (*upper_bits);
      (*count) = ((*count) << 32) | (*lower_bits);
    }

    return (*count);
}
