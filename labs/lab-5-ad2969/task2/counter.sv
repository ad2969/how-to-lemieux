module counter(input logic clk, input logic reset_n,
               input logic [3:0] address, input logic read, output logic [31:0] readdata);

// your code here
  reg [63:0] counter;
  reg [31:0] data;

  assign readdata = data;

  always @(posedge clk) begin
	if(reset_n == 1'b0) begin
	  counter <= 64'b0;
	end
	else begin
	  counter <= counter + 64'b1;
	end
  end

  always @(posedge clk) begin
	if(read == 1'b1) begin
	  // check address offset
	  if(address == 4'bxxx1) data <= counter[63:32];
	  else data <= counter[31:0];
	end
  end

endmodule: counter