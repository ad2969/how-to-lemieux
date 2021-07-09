`timescale 1ps / 1ps

module tb_music();

  parameter repetitions1 = 3000;
  parameter repetitions2 = 3000;
  parameter clk_delay1 = 1;
  parameter clk_delay2 = 1;
  integer i;
  reg err;

  reg xclk, xclk2, xrst;
// Your testbench goes here.

  music dut( .CLOCK_50(xclk), .CLOCK2_50(xclk2), .KEY({xrst, 3'b000}), .SW(),
	     .AUD_DACLRCK(), .AUD_ADCLRCK(), .AUD_BCLK(), .AUD_ADCDAT(),
	     .FPGA_I2C_SDAT(), .FPGA_I2C_SCLK(), .AUD_DACDAT(), .AUD_XCK(),
             .HEX0(), .HEX1(), .HEX2(), .HEX3(), .HEX4(), .HEX5(), .LEDR()	);

  initial begin
	#20 xclk = 1'b0;
	repeat (repetitions1) begin
	  #clk_delay1 xclk = 1'b1;
	  #clk_delay1 xclk = 1'b0;
	end
  end

  initial begin
	#20 xclk2 = 1'b0;
	repeat (repetitions2) begin
	  #clk_delay2 xclk2 = 1'b1;
	  #clk_delay2 xclk2 = 1'b0;
	end
  end

  initial begin
	err = 1'b0; xrst = 1'b1;
	#5 xrst = 1'b0;
	#5 xrst = 1'b1;

	#6000 $display("done");
  end

endmodule: tb_music

// Any other simulation-only modules you need
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

