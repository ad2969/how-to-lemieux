module tb_ksa();

  parameter repetitions = 3000;
  parameter clk_delay = 1;
  reg err;

// Your testbench goes here.
  reg [9:0] switch;

  reg xclk, xrst, xen;
  wire xrdy, xwrite_enable;

  reg [7:0] xread_data; 
  wire [7:0] xwrite_addr, xwrite_data;

  ksa dutksa(.clk(xclk), .rst_n(xrst),
             .en(xen), .rdy(xrdy),
	     .key({14'b0, switch}),
             .addr(xwrite_addr), .rddata(xread_data), .wrdata(xwrite_data), .wren(xwrite_enable));

  initial begin
	xclk = 1'b0;
	repeat (repetitions) begin
	  #clk_delay xclk = 1'b1;
	  #clk_delay xclk = 1'b0;
	end
  end

  initial begin
	switch = 10'b1101101100;
	xrst = 1'b1; xen = 1'b0; xread_data = 8'b0; err = 1'b0; #5
	
	assert(xrdy == 1'b1) begin end
	  else begin $error("Ready signal not high at the start"); err = 1'b1; end
	assert(xwrite_enable == 1'b0) begin end
	  else begin $error("Write signal not low at the start"); err = 1'b1; end
	assert(xwrite_addr == 8'b0) begin end
	  else begin $error("Write address not zero at the start"); err = 1'b1; end
	assert(xwrite_data == 8'b0) begin end
	  else begin $error("Write data not zero at the start"); err = 1'b1; end
	
	assert(dutksa.j == 8'b0 && dutksa.i == 8'b0) begin end
	  else begin $error("i and j are not zero at the start"); err = 1'b1; end
	assert(xread_data == 8'b0) begin end
	  else begin $error("Read data is incorrect value"); err = 1'b1; end

	if(err == 1'b0) begin $display("TEST 1 PASSED! Initial wires are correct!"); end

	xen = 1'b1; #2 xen = 1'b0; #2

	$display("reading from address ", xwrite_addr);
	#40 $display("reading from address ", xwrite_addr);
	#960 $display("reading from address ", xwrite_addr);
	#4500 assert(xrdy == 1'b1) begin end
		else begin $error("Ready signal not raised at the end!"); err = 1'b1; end

	if(err == 1'b0) begin $display("TEST 2 PASSED! KSA Completed and ready!"); end

	if(err == 1'b1) $error("** TEST(s) FAILED for 'ksa.sv'");
	  else $display("ALL TESTS PASSED! This marks the end of tests for 'ksa.sv'.");

  end

endmodule: tb_ksa
