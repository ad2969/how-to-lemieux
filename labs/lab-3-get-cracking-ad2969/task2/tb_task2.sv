`timescale 1ps / 1ps

module tb_task2();

  parameter repetitions = 2500;
  parameter clk_delay = 1;
  reg err;

// Your testbench goes here.
  reg xclk, xrst;
  reg [9:0] xswitch;
  
  wire [6:0] xHEX0, xHEX1, xHEX2, xHEX3, xHEX4, xHEX5;
  wire [9:0] xLEDR;

  task2 dut(.CLOCK_50(xclk), .KEY({xrst, 3'b0}), .SW(xswitch),
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
	xswitch = 10'h33C;
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

	xrst = 1'b0; #2 xrst = 1'b1; #512 #2	// wait until finished writing

	assert(dut.init_ready == 1'b1) begin end
	  else begin $error("Init ready not high at end"); err = 1'b1; end
	assert(dut.init_enable == 1'b0) begin end
	  else begin $error("Init enable not low at end"); err = 1'b1; end
	assert(dut.write_enable == 1'b0) begin end
	  else begin $error("Write signal not low at end"); err = 1'b1; end

	assert(dut.s.altsyncram_component.m_default.altsyncram_inst.mem_data[0] == 0) begin end
	  else begin $error("Memory not initialized properly: Error at mem_data[0]!"); err = 1'b1; end
	assert(dut.s.altsyncram_component.m_default.altsyncram_inst.mem_data[255] == 255) begin end
	  else begin $error("Memory not initialized properly: Error at mem_data[255]!"); err = 1'b1; end
	
	if(err == 1'b0) begin $display("TEST 2 PASSED! Memory completely initialized!"); end

	#3600

	assert(dut.s.altsyncram_component.m_default.altsyncram_inst.mem_data[0] == 8'hb4) begin end
	  else begin $error("Memory not initialized properly: Error at mem_data[0]!"); err = 1'b1; end
	assert(dut.s.altsyncram_component.m_default.altsyncram_inst.mem_data[255] == 8'h1b) begin end
	  else begin $error("Memory not initialized properly: Error at mem_data[255]!"); err = 1'b1; end
	
	if(err == 1'b0) begin $display("TEST 3 PASSED! Memory decrypted!"); end



	if(err == 1'b1) $error("** TEST(s) FAILED for 'task2.sv'");
	else $display("ALL TESTS PASSED! This marks the end of tests for 'task2.sv'.");
  end

endmodule: tb_task2
