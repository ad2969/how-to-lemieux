.equ    switches, 0xa000
.equ    leds, 0xa040
.global _start
_start: movia r2, switches
        movia r3, leds
LOOP:   ldbio r4, 0(r2)
        stbio r4, 0(r3)
        br LOOP
.end
