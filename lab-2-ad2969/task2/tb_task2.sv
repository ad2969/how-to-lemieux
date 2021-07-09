module tb_task2();

// Your testbench goes here. Our toplevel will give up after 1,000,000 ticks.
  // PARAMETERS
  parameter repetitions = 19500;
  parameter clk_delay1 = 0.5;
  parameter clk_delay2 = 0.5;

  reg clk, rst;
  reg err;

  // unused
  reg [9:0] xSW;
  reg [9:0] xLEDR;
  // unused outputs
  wire [6:0] xHEX0, xHEX1, xHEX2, xHEX3, xHEX4, xHEX5;
  wire [7:0] xVGAR, xVGAG, xVGAB;
  wire xVGAHS, xVGAVS, xVGACLK;

  task2 dut2(.CLOCK_50(clk), .KEY({rst, 3'b000}), // KEY[3] is async active-low reset
             .SW(xSW), .LEDR(xLEDR),
             .HEX0(xHEX0), .HEX1(xHEX1), .HEX2(xHEX2), .HEX3(xHEX3), .HEX4(xHEX4), .HEX5(xHEX5),
             .VGA_R(xVGAR), .VGA_G(xVGAG), .VGA_B(xVGAB),
             .VGA_HS(xVGAHS), .VGA_VS(xVGAVS), .VGA_CLK(xVGACLK));

  initial begin
	clk = 1'b0;
	repeat (repetitions) begin
	  #clk_delay1 clk = 1'b1;
	  #clk_delay2 clk = 1'b0;
	end
  end

  initial begin
	rst = 1'b1; err = 1'b0;
	#50 rst = 1'b0;
	#50 rst = 1'b1;

	assert(dut2.w_done == 1'b0) begin $display("Reset: 'done' confirmed!"); end
	  else begin $error("Resret timing error!"); err = 1'b1; end

	#100

	assert(dut2.w_start == 1'b1) begin $display("Reset: 'start' confirmed!"); end
	  else begin $error("Reset timing error!"); err = 1'b1; end

	assert(dut2.w_plot == 1'b1) begin $display("Plotting confirmed!"); end
	  else begin $error("VGA Not Plotting"); err = 1'b1; end

	#38600 // wait until done

	assert(dut2.w_done == 1'b1) begin $display("Display complete!"); end
	  else begin $error("Display error!"); err = 1'b1; end

	if(err == 1'b1) $error("** TEST(s) FAILED for 'task2.sv'");
	else $display("ALL TESTS PASSED! This marks the end of game tests for 'task2.sv'.");
  end

endmodule: tb_task2
