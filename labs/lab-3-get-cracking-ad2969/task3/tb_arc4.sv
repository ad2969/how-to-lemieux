`timescale 1ps / 1ps
module tb_arc4();

// Your testbench goes here.
  parameter repetitions = 3000;
  parameter clk_delay = 1;
  reg err;

// Your testbench goes here.
  reg xclk, xrst, xen;
  reg [23:0] xkey;
  
  wire xready;
  wire [7:0] xct_addr, xct_rddata;
  wire [7:0] xpt_addr, xpt_rddata, xpt_wrdata;
  wire xpt_wren;

  arc4 dut(.clk(xclk), .rst_n(xrst),
           .en(xen), .rdy(xready),
	   .key(xkey),
           .ct_addr(xct_addr), .ct_rddata(xct_rddata),
	   .pt_addr(xpt_addr), .pt_rddata(xpt_rddata), .pt_wrdata(xpt_wrdata), .pt_wren(xpt_wren));

  xpt_mem dutpt(.clk(xclk), .address(xpt_addr),
	        .wren(xpt_wren), .wrdata(xpt_wrdata),
	        .rddata(xpt_rddata));

  xct_mem dutct(.clk(xclk), .address(xct_addr),
	        .rddata(xct_rddata));

  initial begin
	xclk = 1'b0;
	repeat (repetitions) begin
	  #clk_delay xclk = 1'b1;
	  #clk_delay xclk = 1'b0;
	end
  end

  initial begin
	xkey = 24'h1E4600;
	xrst = 1'b1; xen = 1'b0; err = 1'b0; #9
	$readmemh("test1.memh", dutct.memory);

	$display("ct_mem is", dutct.memory[0], dutct.memory[1], dutct.memory[2], dutct.memory[3]);

	assert(dut.init_ready == 1'b1) begin end
	  else begin $error("Init ready not high at the start"); err = 1'b1; end
	assert(dut.init_enable == 1'b0) begin end
	  else begin $error("Init enable not low at the start"); err = 1'b1; end
	assert(dut.s_wren == 1'b0) begin end
	  else begin $error("S Write signal not low at the start"); err = 1'b1; end
	assert(dut.s_addr == 8'b0) begin end
	  else begin $error("S Write address not zero at the start"); err = 1'b1; end
	assert(dut.s_wrdata == 8'b0) begin end
	  else begin $error("S Write data not zero at the start"); err = 1'b1; end
	if(err == 1'b0) begin $display("TEST 1 PASSED! Initial wires are correct!"); end

	xen = 1'b1; #2 xen = 1'b0; #512 #2	// wait until finished writing

	assert(dut.init_ready == 1'b1) begin end
	  else begin $error("Init ready not high at end"); err = 1'b1; end
	assert(dut.init_enable == 1'b0) begin end
	  else begin $error("Init enable not low at end"); err = 1'b1; end
	assert(dut.s_wren == 1'b0) begin end
	  else begin $error("Write signal not low at end"); err = 1'b1; end

	assert(dut.s.altsyncram_component.m_default.altsyncram_inst.mem_data[0] == 0) begin end
	  else begin $error("Memory not initialized properly: Error at mem_data[0]!"); err = 1'b1; end
	assert(dut.s.altsyncram_component.m_default.altsyncram_inst.mem_data[255] == 255) begin end
	  else begin $error("Memory not initialized properly: Error at mem_data[255]!"); err = 1'b1; end
	
	if(err == 1'b0) begin $display("TEST 2 PASSED! Memory completely initialized!"); end

	#3593

	if(err == 1'b1) $error("** TEST(s) FAILED for 'task2.sv'");
	else $display("ALL TESTS PASSED! This marks the end of tests for 'task2.sv'.");
  end

endmodule: tb_arc4

module xpt_mem(input clk, input [7:0] address,
	      input wren, input [7:0] wrdata,
	      output [7:0] rddata);

  reg [7:0] data_out;
  reg [7:0] memory [0:255];
  assign rddata = data_out;

  always @(posedge clk) begin
	if(wren == 1'b1) begin
	  memory[address] <= wrdata;
	end
	else begin
	  data_out <= memory[address];
	end
  end

endmodule: xpt_mem

module xct_mem(input clk, input [7:0] address,
	      output [7:0] rddata);

  reg [7:0] data_out;
  reg [7:0] memory [0:255];
  assign rddata = data_out;

  always @(posedge clk) begin
	data_out <= memory[address];
  end

endmodule: xct_mem