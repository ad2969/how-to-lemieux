// Load-enabled D Flip-flop with parameter-set bits
module reg4(reset, clk, load, in, out);
  // Set parameter
  parameter n = 1;

  input reset;
  input clk;
  input load;
  input [n-1:0] in;
  output reg [n-1:0] out;
	
	// Sequential block that reevaluates on every posedge (with async reset)
	// "reset button" resets the entirety of the game, so it can be async
	always_ff @(posedge clk, negedge reset) begin
	  // check reset
	  if(reset == 1'b0) out <= 0;
	  // check load signal
	  else if(load == 1'b1) begin
		if(in >= 1011) out <= 4'b0000;
		else out <= in;
	  end
	end

endmodule: reg4