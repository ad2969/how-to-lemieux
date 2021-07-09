module tb_init();

  parameter repetitions = 300;
  parameter clk_delay = 1;
  reg err;

// Your testbench goes here.
  reg xclk, xrst, xen;
  wire xrdy, xwrite_enable;
  wire [7:0] xwrite_addr, xwrite_data; 

  init dutinit(.clk(xclk), .rst_n(xrst),
               .en(xen), .rdy(xrdy),
               .addr(xwrite_addr), .wrdata(xwrite_data), .wren(xwrite_enable));

  initial begin
	xclk = 1'b0;
	repeat (repetitions) begin
	  #clk_delay xclk = 1'b1;
	  #clk_delay xclk = 1'b0;
	end
  end

  initial begin
	xrst = 1'b1; xen = 1'b0; err = 1'b0; #10

	assert(xrdy == 1'b1) begin end
	  else begin $error("Ready signal not high at the start"); err = 1'b1; end
	assert(xwrite_enable == 1'b0) begin end
	  else begin $error("Write signal not low at the start"); err = 1'b1; end
	assert(xwrite_addr == 8'b0) begin end
	  else begin $error("Write address not zero at the start"); err = 1'b1; end
	assert(xwrite_data == 8'b0) begin end
	  else begin $error("Write data not zero at the start"); err = 1'b1; end
	if(err == 1'b0) begin $display("TEST 1 PASSED! Initial wires are correct!"); end

	xen = 1'b1; #2 xen = 1'b0;	// knowing ready == 1, trigger xen;

	assert(xrdy == 1'b0) begin end
	  else begin $error("Ready signal not low after enable"); err = 1'b0; end
	assert(xwrite_enable == 1'b1) begin end
	  else begin $error("Write signal not high after enable"); err = 1'b1; end
	assert(xwrite_addr == 8'b0) begin end
	  else begin $error("Write address not zero after enable"); err = 1'b1; end
	assert(xwrite_data == 8'b0) begin end
	  else begin $error("Write data not zero"); err = 1'b1; end
	if(err == 1'b0) begin $display("TEST 2 PASSED! wires during enable correct!"); end

	#2 // wait for first negedge

	assert(xrdy == 1'b0) begin end
	  else begin $error("Ready signal not low during writing"); err = 1'b0; end
	assert(xwrite_enable == 1'b1) begin end
	  else begin $error("Write signal not high during writing"); err = 1'b1; end
	assert(xwrite_addr == 8'b1) begin end
	  else begin $error("Write address not 1"); err = 1'b1; end
	assert(xwrite_data == 8'b0) begin end
	  else begin $error("Write data not zero during writing"); err = 1'b1; end
	if(err == 1'b0) begin $display("TEST 3 PASSED! Wires during writing correct!"); end

	#252 xrst = 1'b0; #2 xrst = 1'b1;	 // wait halfway through writing, check reset

	assert(xrdy == 1'b0) begin end
	  else begin $error("Ready signal not low halfway through writing"); err = 1'b0; end
	assert(xwrite_enable == 1'b1) begin end
	  else begin $error("Write signal not high halfway through writing"); err = 1'b1; end
	assert(xwrite_addr == 8'b10000000) begin end
	  else begin $error("Write address not 128"); err = 1'b1; end
	assert(xwrite_data == 8'b0) begin end
	  else begin $error("Write data not zero halfway through writing"); err = 1'b1; end
	if(err == 1'b0) begin $display("TEST 4 PASSED! Reset no effect! Wires halfway through writing correct!"); end

	#256	// wait until finished writing

	assert(xrdy == 1'b1) begin end
	  else begin $error("Ready signal not high after writing"); err = 1'b0; end
	assert(xwrite_enable == 1'b0) begin end
	  else begin $error("Write signal not low after writing"); err = 1'b1; end
	assert(xwrite_addr == 8'b11111111) begin end
	  else begin $error("Write address not 255"); err = 1'b1; end
	assert(xwrite_data == 8'b0) begin end
	  else begin $error("Write data not zero after writing"); err = 1'b1; end
	if(err == 1'b0) begin $display("TEST 5 PASSED! Memory completely written!"); end

	if(err == 1'b1) $error("** TEST(s) FAILED for 'init.sv'");
	else $display("ALL TESTS PASSED! This marks the end of tests for 'init.sv'.");

  end

endmodule: tb_init
