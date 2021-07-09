module tb_counter();

// Your testbench goes here.

  parameter repetitions = 2000;
  parameter clk_delay = 1;
  integer i;
  reg err;

  reg xclk, xrst, xread;
  reg [3:0] xaddress;
  wire [31:0] xreaddata;

  counter dutc(.clk(xclk), .reset_n(xrst),
               .address(xaddress), .read(xread), .readdata(xreaddata));

  initial begin
	xclk = 1'b0; err = 1'b0; xrst = 1'b1; xread = 1'b0; xaddress = 4'b0000;
	repeat (repetitions) begin
	  #clk_delay xclk = 1'b0;
	  #clk_delay xclk = 1'b1;
	end
  end

  initial begin
	xrst = 1'b0;
	#4 xread = 1'b1; #2 xread = 1'b0;
	assert(xreaddata == 32'b0) begin end
	  else begin $error("Data not initially 0"); err = 1'b1; end
	#2 xrst = 1'b1;
	
	#1000 xread = 1'b1; #2 xread = 1'b0;
	assert(xreaddata == 32'd500) begin end
	  else begin $error("Counter not operating, supposed to be 500, is ", xreaddata); err = 1'b1; end

	#998 xread = 1'b1; #2 xread = 1'b0;
	assert(xreaddata == 32'd1000) begin end
	  else begin $error("Counter not operating, supposed to be 500, is ", xreaddata); err = 1'b1; end

	if(err == 1'b1) $error("** TEST(s) FAILED for 'counter.sv'");
	else $display("ALL TESTS PASSED! This marks the end of tests for 'counter.sv'.");
  end

endmodule: tb_counter
