// Combinational block, no memory
module card7seg(input [3:0] SW, output [6:0] HEX0);

    reg [6:0] state;
    assign HEX0 = state;

    // declare binary codes for all the possible LED HEX outputs
    // HEX0 are active-low, thus the inverting
    parameter ACE   = 7'b0001000;
    parameter TWO   = 7'b0100100;
    parameter THREE = 7'b0110000;
    parameter FOUR  = 7'b0011001;
    parameter FIVE  = 7'b0010010;
    parameter SIX   = 7'b0000010;
    parameter SEVEN = 7'b1111000;
    parameter EIGHT = 7'b0000000;
    parameter NINE  = 7'b0010000;
    parameter TEN   = 7'b1000000;
    parameter JACK  = 7'b1100001;
    parameter QUEEN = 7'b0011000;
    parameter KING  = 7'b0001001;
    parameter BLANK = 7'b1111111;

	// always block to re-evaluate output on every change
	always_comb begin
	case(SW)
	  4'b0001: state = ACE;
	  4'b0010: state = TWO;
	  4'b0011: state = THREE;
	  4'b0100: state = FOUR;
	  4'b0101: state = FIVE;
	  4'b0110: state = SIX;
	  4'b0111: state = SEVEN;
	  4'b1000: state = EIGHT;
	  4'b1001: state = NINE;
	  4'b1010: state = TEN;
	  4'b1011: state = JACK;
	  4'b1100: state = QUEEN;
	  4'b1101: state = KING;
	  default: state = BLANK;
	endcase
	end

endmodule: card7seg
