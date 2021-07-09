`timescale 1ps / 1ps

module tb_flash_reader();

  parameter repetitions = 2000;
  parameter clk_delay = 1;
  integer i;
  reg err;

  reg xclk, xrst;
// Your testbench goes here.

  flash_reader dut(.CLOCK_50(xclk), .KEY({xrst, 3'b000}), .SW(),
                   .HEX0(), .HEX1(), .HEX2(),
                   .HEX3(), .HEX4(), .HEX5(),
                   .LEDR());

  initial begin
	#20 xclk = 1'b0; err = 1'b0; xrst = 1'b1;
	repeat (repetitions) begin
	  #clk_delay xclk = 1'b1;
	  #clk_delay xclk = 1'b0;
	end
  end

  initial begin
  // CHECK MEMORY INITALIZATION
	$display("flashdata:");
	for (i = 0; i < 256; i = i+1)
	  $display("%d: %h", i, dut.flash_inst.memory[i]);

  // WRITE
	//#5 xrst = 1'b0;
	//#5 xrst = 1'b1;

  // CHECK
	#3500 assert(dut.samples.altsyncram_component.m_default.altsyncram_inst.mem_data[0] == 16'hE364) begin end
	  else begin $error("Data at address 0 incorrect!"); err = 1'b1; end

	assert(dut.samples.altsyncram_component.m_default.altsyncram_inst.mem_data[1] == 16'hC6C8) begin end
	  else begin $error("Data at address 1 incorrect!"); err = 1'b1; end

	assert(dut.samples.altsyncram_component.m_default.altsyncram_inst.mem_data[254] == 16'h18D8) begin end
	  else begin $error("Data at address 254 incorrect!"); err = 1'b1; end

	assert(dut.samples.altsyncram_component.m_default.altsyncram_inst.mem_data[255] == 16'h1919) begin end
	  else begin $error("Data at address 255 incorrect!"); err = 1'b1; end

	if(err == 1'b1) $error("** TEST(s) FAILED for 'flash_reader.sv'");
	else $display("ALL TESTS PASSED! This marks the end of tests for 'flash_reader.sv'.");

  end

endmodule: tb_flash_reader

// ----------------------------------------------------------------------------------------

module flash(input logic clk_clk, input logic reset_reset_n,
             input logic flash_mem_write, input logic [6:0] flash_mem_burstcount,
             output logic flash_mem_waitrequest, input logic flash_mem_read,
             input logic [22:0] flash_mem_address, output logic [31:0] flash_mem_readdata,
             output logic flash_mem_readdatavalid, input logic [3:0] flash_mem_byteenable,
             input logic [31:0] flash_mem_writedata);

// Your simulation-only flash module goes here.

  reg [2:0] readstate;

  reg [15:0] memory [0:255]; // declare 256-word memory, 16-bits each
  reg fm_waitrequest, fm_readdatavalid;
  reg [31:0] fm_readdata;

  assign flash_mem_waitrequest = fm_waitrequest;
  assign flash_mem_readdatavalid = fm_readdatavalid;
  assign flash_mem_readdata = fm_readdata;

  initial $readmemh("samples2.txt", memory);

  always @(posedge clk_clk) begin
	if(flash_mem_write == 1'b1) begin
	  memory[flash_mem_address] = flash_mem_writedata;
	end
	else begin
	case(readstate)
	  3'b000: begin  // waitrequest = 1
		fm_waitrequest = 1'b1;
		readstate = 3'b001;
	  end

	  3'b001: begin // waitrequest = 0
		fm_waitrequest = 1'b0;
		fm_readdatavalid = 1'b0;
		readstate = 3'b010;
	  end

	  3'b010: begin // wait for read signal
		readstate = 3'b011;
	  end

	  3'b011: begin  // readdatavalid = 1
		fm_readdatavalid = 1'b1;
		fm_readdata = {memory[flash_mem_address * 2 + 1], memory[flash_mem_address * 2]};
		readstate = 3'b100;
	  end

	  3'b100: begin
		fm_readdatavalid = 1'b0;
		readstate = 3'b111;
	  end

	  default: begin // resets
		fm_readdatavalid = 1'b0;
		if(flash_mem_read == 1'b1) begin
		  readstate = 3'b000;
		  fm_waitrequest = 1'b1;
		end
		else begin readstate = 3'b111;
		  fm_waitrequest = 1'b0;
		end
	  end
	endcase
	end
  end

endmodule: flash
