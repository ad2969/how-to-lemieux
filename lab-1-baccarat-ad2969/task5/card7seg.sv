// declare binary codes for all the possible LED HEX outputs
// seg7 are active-low, thus the inverting

`define ACE 7'b0001000
`define TWO 7'b0100100
`define THREE 7'b0110000
`define FOUR 7'b0011001
`define FIVE 7'b0010010
`define SIX 7'b0000010
`define SEVEN 7'b1111000
`define EIGHT 7'b0000000
`define NINE 7'b0010000
`define TEN 7'b1000000
`define JACK 7'b1100001
`define QUEEN 7'b0011000
`define KING 7'b0001001
`define BLANK 7'b1111111

// Combinational block, no memory
module card7seg(input [3:0] card, output[6:0] seg7);

    reg [6:0] state;
    assign seg7 = state;

	// always block to re-evaluate output on every change
	always_comb begin
	case(card)
	  4'b0001: state = `ACE;
	  4'b0010: state = `TWO;
	  4'b0011: state = `THREE;
	  4'b0100: state = `FOUR;
	  4'b0101: state = `FIVE;
	  4'b0110: state = `SIX;
	  4'b0111: state = `SEVEN;
	  4'b1000: state = `EIGHT;
	  4'b1001: state = `NINE;
	  4'b1010: state = `TEN;
	  4'b1011: state = `JACK;
	  4'b1100: state = `QUEEN;
	  4'b1101: state = `KING;
	  default: state = `BLANK;
	endcase
	end

endmodule: card7seg
