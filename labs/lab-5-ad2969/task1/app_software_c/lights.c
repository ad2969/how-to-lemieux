#define switches (volatile char *) 0xa000
#define leds (char *) 0xa040

void main() {
  while(1) { *leds = *switches; }
}
