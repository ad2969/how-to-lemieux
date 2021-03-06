/* NOTE: this file must be self-contained */

/*
 *  Transforms the pixel (x_in,y_in) using the matrix specified by m.
 *
 *  Pixel coordinates are integers, but the entries of m are Q16 fixed-point numbers.
 *
 *  If the matrix M is defined like this:
 *
 *      M00 M01 M02
 *      M10 M11 M12
 *      M20 M21 M22
 *
 *  then m[0] is M00, m[1] is M01, m[3] is M10, and so on. The computation is
 *
 *      x_out       M00 M01 M02       x_in
 *      y_out   =   M10 M11 M12   x   y_in
 *      ?           M20 M21 M22       1
 *
 *  and the output pixel will be (*x_out,*y_out).
 */


 // RESOLUTION = 160 x 120
 // Initial Translation: (-80, +60)
 // Restore Translation: (+80, -60)

#include "hw_mult.h"
#include "pixel_xform.h"
#define FRAC_POINTS 16
#define POW16 65536

inline void pixel_xform(unsigned x_in, unsigned y_in,
                        unsigned *x_out, unsigned *y_out,
                        int *m) {
    /* your code here */
    int x, y;
    int normalized_x, normalized_y;

    normalized_x = x_in - 80;
    normalized_y = y_in + 60;

    // Matrix is in q16.16 form, can convert y_in to the same
    // hw_mult accepts signed
    x = hw_mult(*m, normalized_x) +
        hw_mult(*(m + 1*sizeof(int)), normalized_y) +
        *(m + 2*sizeof(int));

    y = hw_mult(*(m + 3*sizeof(int)), normalized_x) +
        hw_mult(*(m + 4*sizeof(int)), normalized_y) +
        *(m + 5*sizeof(int));

    *x_out = x / POW16 + 80; // convert back to integer
    *y_out = y / POW16 - 60; // consvert back to integer
}
