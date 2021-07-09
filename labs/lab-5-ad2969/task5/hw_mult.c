/* NOTE: this file must be self-contained */
#define MULT_N 0x00
#include "hw_mult.h"

#define multiply(x,y) __builtin_custom_inii(MULT_N, (x), (y));
int __builtint_custom_inii(int, int, int);

inline int hw_mult(int x, int y) {
    /* your code using the custom instruction here */
  return multiply(x,y);
}
