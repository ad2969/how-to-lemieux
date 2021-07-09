`timescale 1ps / 1ps

module tb_sound();

  parameter repetitions1 = 3000;
  parameter repetitions2 = 3000;
  parameter clk_delay1 = 1;
  parameter clk_delay2 = 1;
  integer i;
  reg err;

  reg xclk, xclk2, xrst;
// Your testbench goes here.

  sound dut( .CLOCK_50(xclk), .CLOCK2_50(xclk2), .KEY({xrst, 3'b000}), .SW(),
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

endmodule: tb_sound