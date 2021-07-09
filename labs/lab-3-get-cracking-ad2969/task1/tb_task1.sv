`timescale 1ps / 1ps

module tb_task1();

  parameter repetitions = 300;
  parameter clk_delay = 1;
  reg err;
  integer i;

// Your testbench goes here.
  reg xclk, xrst;
  reg [9:0] xswitch;
  
  wire [6:0] xHEX0, xHEX1, xHEX2, xHEX3, xHEX4, xHEX5;
  wire [9:0] xLEDR;

  task1 dut(.CLOCK_50(xclk), .KEY({xrst, 3'b0}), .SW(xswitch),
            .HEX0(xHEX0), .HEX1(xHEX1), .HEX2(xHEX2),
            .HEX3(xHEX3), .HEX4(xHEX4), .HEX5(xHEX5),
            .LEDR(xLEDR));

  initial begin
	xclk = 1'b0;
	repeat (repetitions) begin
	  #clk_delay xclk = 1'b1;
	  #clk_delay xclk = 1'b0;
	end
  end

  initial begin
	xrst = 1'b1; err = 1'b0; #9

	assert(dut.init_ready == 1'b1) begin end
	  else begin $error("Init ready not high at the start"); err = 1'b1; end
	assert(dut.init_enable == 1'b0) begin end
	  else begin $error("Init enable not low at the start"); err = 1'b1; end
	assert(dut.write_enable == 1'b0) begin end
	  else begin $error("Write signal not low at the start"); err = 1'b1; end
	assert(dut.write_address == 8'b0) begin end
	  else begin $error("Write address not zero at the start"); err = 1'b1; end
	assert(dut.write_data == 8'b0) begin end
	  else begin $error("Write data not zero at the start"); err = 1'b1; end
	if(err == 1'b0) begin $display("TEST 1 PASSED! Initial wires are correct!"); end

	xrst = 1'b0; #2 xrst = 1'b1;	// knowing ready == 1, trigger init by executing xrst;

	assert(dut.init_ready == 1'b1) begin end
	  else begin $error("Init ready not high during reset"); err = 1'b1; end
	assert(dut.init_enable == 1'b1) begin end
	  else begin $error("Init enable not high during reset"); err = 1'b1; end
	assert(dut.write_enable == 1'b0) begin end
	  else begin $error("Write signal not low during reset"); err = 1'b1; end
	assert(dut.write_address == 8'b0) begin end
	  else begin $error("Write address not zero during reset"); err = 1'b1; end
	if(err == 1'b0) begin $display("TEST 2 PASSED! Reset response correct!"); end

	#256 xrst = 1'b0; #1	 // wait halfway through writing, check reset

	assert(dut.init_ready == 1'b0) begin end
	  else begin $error("Init ready not low at mid-reset"); err = 1'b1; end
	assert(dut.init_enable == 1'b0) begin end
	  else begin $error("Init enable not low at mid-reset"); err = 1'b1; end
	assert(dut.write_enable == 1'b1) begin end
	  else begin $error("Write signal not high at mid-reset"); err = 1'b1; end
	assert(dut.write_address == 8'b10000000) begin end
	  else begin $error("Write address not 128 at mid-reset"); err = 1'b1; end
	if(err == 1'b0) begin $display("TEST 4 PASSED! Mid-reset no effect!"); end

	#1 xrst = 1'b1; #256	// wait until finished writing

	assert(dut.init_ready == 1'b1) begin end
	  else begin $error("Init ready not high at end"); err = 1'b1; end
	assert(dut.init_enable == 1'b0) begin end
	  else begin $error("Init enable not low at end"); err = 1'b1; end
	assert(dut.write_enable == 1'b0) begin end
	  else begin $error("Write signal not low at end"); err = 1'b1; end
	assert(dut.write_address == 8'b11111111) begin end
	  else begin $error("Write address not 255 at reset"); err = 1'b1; end

	for(i = 0; i < 256; i++) begin
	  assert(dut.s.altsyncram_component.m_default.altsyncram_inst.mem_data[i] == i) begin end
	    else begin $error("Memory not initialized properly: Error at mem_data[",i,        "]!"); err = 1'b1; end
	end
	
	if(err == 1'b0) begin $display("TEST 5 PASSED! Memory completely written!"); end

	if(err == 1'b1) $error("** TEST(s) FAILED for 'task1.sv'");
	else $display("ALL TESTS PASSED! This marks the end of tests for 'task1.sv'.");
  end

endmodule: tb_task1
