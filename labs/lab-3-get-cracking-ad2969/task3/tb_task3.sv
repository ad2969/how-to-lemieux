`timescale 1ps / 1ps
module tb_task3();

  parameter repetitions = 3000;
  parameter clk_delay = 1;
  reg err;

  reg xclk, xrst, xen;
  wire [3:0] xkey;
  assign xkey = {xrst, xen, 2'b0};

  wire [9:0] xled;
  wire [6:0] xhex0, xhex1, xhex2, xhex3, xhex4, xhex5;
  reg [9:0] switch;

  // Module Instantiation

  task3 dut(.CLOCK_50(xclk), .KEY(xkey), .SW(switch),
	    .HEX0(xhex0), .HEX1(xhex1), .HEX2(xhex3),
	    .HEX3(xhex3), .HEX4(xhex4), .HEX5(xhex5),
	    .LEDR(xled));

  // Testbench

  initial begin
	xclk = 1'b0;
	repeat (repetitions) begin
	  #clk_delay xclk = 1'b1;
	  #clk_delay xclk = 1'b0;
	end
  end

  initial begin
	switch = 10'h18;
	xrst = 1'b1; xen = 1'b0; err = 1'b0; #9
	$readmemh("test2.memh", dut.ct.altsyncram_component.m_default.altsyncram_inst.mem_data);
	$display("ct_mem is",	dut.ct.altsyncram_component.m_default.altsyncram_inst.mem_data[0],
				dut.ct.altsyncram_component.m_default.altsyncram_inst.mem_data[1],
				dut.ct.altsyncram_component.m_default.altsyncram_inst.mem_data[2],
				dut.ct.altsyncram_component.m_default.altsyncram_inst.mem_data[3]);

	xrst = 1'b0; #2 xrst = 1'b1;

	if(err == 1'b1) $error("** TEST(s) FAILED for 'task2.sv'");
	else $display("ALL TESTS PASSED! This marks the end of tests for 'task2.sv'.");
  end

endmodule: tb_task3
