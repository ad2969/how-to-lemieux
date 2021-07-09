/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define ROTATE_ANGLE 45
#define POW16 65536
#define POW32 4294967296

void initmatrix45(int*);
int hw_mult(int, int);
void pixel_xform(unsigned, unsigned, unsigned*, unsigned*, int*);

int main()
{
    int pixelArray[] = {63, 54, 1, 1, 85, 100, 32, 32};

    // TO REMOVE:
    int* m;
    int pArr[9];
    m = pArr;
    initmatrix45(m);

    int pixel_size = sizeof(pixelArray)/sizeof(pixelArray[0]);
    unsigned colour = 0b111;
    unsigned int x_in, y_in, x_out, y_out;

    for(int i = 0; i < pixel_size; i += 2) {
        x_in = pixelArray[i];                            // initial translation
        y_in = pixelArray[i+1];
        pixel_xform(x_in, y_in, &x_out, &y_out, m);  // transform by matrix
    }
}

void pixel_xform(unsigned x_in, unsigned y_in, unsigned *x_out, unsigned *y_out, int *m) {

    // Matrix is in q16.16 form, can convert x_in and y_in to Q16.16
    // hw_mult accepts signed integers
    int x, y;
    int normalized_x, normalized_y;

    normalized_x = x_in - 80;
    normalized_y = y_in + 60;

    printf("Coordinates: %u, %u, normalized: %i, %i\n", x_in, y_in, normalized_x, normalized_y);
    printf("Matrix recieved (address %p): \n %u %u %u \n %u %u %u \n %u %u %u\n\n", m, m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);

    x = hw_mult(*m, (normalized_x)) +
        hw_mult(*(m + 1), (normalized_y)) +
        *(m + 2);

    y = hw_mult(*(m + 3), (normalized_x)) +
        hw_mult(*(m + 4), (normalized_y)) +
        *(m + 5);

    *x_out = x / POW16 + 80; // convert back to integer
    *y_out = y / POW16 - 60; // consvert back to integer

    printf("calculation result: %u, %u\n\n", *x_out, *y_out);
}

void initmatrix45(int* m) {
  // Initialize transformation matrix
  float c, s;
  unsigned int q_c, q_s, q_s_n;
  c = cos(ROTATE_ANGLE * M_PI / 180.0);
  s = sin(ROTATE_ANGLE * M_PI / 180.0);

  // convert to Q16.16
  q_c = c * POW16;
  q_s = s * POW16;
  q_s_n = -q_s;

  *m = q_c;
  *(m+1) = q_s;
  *(m+2) = 0;
  *(m+3) = q_s_n;
  *(m+4) = q_c;
  *(m+5) = 0;
  *(m+6) = 0;
  *(m+7) = 0;
  *(m+8) = 1;

  printf("Transformation matrix (address %p): \n %u %u %u \n %u %u %u \n %u %u %u\n\n", m, m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
}

int hw_mult(int x, int y) {
    /* your code using the custom instruction here */
    printf("multiplying: %i * %i to get %i\n", x, y, x * y);
    return x * y;
}
