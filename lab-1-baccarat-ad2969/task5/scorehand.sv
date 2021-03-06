module scorehand(input [3:0] card1, input [3:0] card2, input [3:0] card3, output [3:0] total);

// The code describing scorehand will go here.  Remember this is a combinational
// block. The function is described in the handout.  Be sure to review the section
// on representing numbers in the lecture notes.

  reg [3:0] computed;
	
	assign total = computed;
	// combinational always block
	always_comb begin
	  computed = (card1 + card2 + card3) % 10;
	end

endmodule

