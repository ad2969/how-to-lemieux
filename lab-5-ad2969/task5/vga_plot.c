/* NOTE: this file must be self-contained */
#define ADDR_AVALON (volatile unsigned long *) 0xa200
#include "vga_plot.h"

inline void vga_plot(unsigned x, unsigned y, unsigned colour) {
    /* your code here */
    *ADDR_AVALON = (colour << 16) + (x << 8) + y;
}
