module tb_fillscreen();
    // Your testbench goes here. Our toplevel will give up after 1,000,000 ticks.

  // PARAMETERS
  parameter repetitions = 29300;
  parameter clk_delay1 = 2;
  parameter clk_delay2 = 2;

  reg clk, rst;
  reg [2:0] xcolour;
  reg xstart, xdone;

  reg [7:0] xvga_x;
  reg [6:0] xvga_y;
  reg [2:0] xvga_colour;
  reg xvga_plot;

  reg [15:0] counter;
  reg err;

  fillscreen dutf(.clk(clk), .rst_n(rst), .colour(xcolour),
                  .start(xstart), .done(xdone),
                  .vga_x(xvga_x), .vga_y(xvga_y),
                  .vga_colour(xvga_colour), .vga_plot(xvga_plot));

  initial begin
	clk = 1'b0;
        counter = 16'b0;
	repeat (repetitions) begin
	  #clk_delay1 clk = 1'b1;
	  #clk_delay2 clk = 1'b0;
	  if(xvga_plot == 1'b1) counter = counter + 16'b1;
	end
  end

  initial begin
	rst = 1'b1; xstart = 1'b0; err = 1'b0;
	// RESET
	#10 rst = 1'b0;
	#90 rst = 1'b1;
	$display("Reset button depressed! Counter reset to:", counter);

	// START
	xstart = 1'b1;
	#76800
	$display("Counter is now at ", counter, " (should be 19200)");
	assert(xdone == 1'b1) begin $display("Fillscreen completed at/before 19,200 cycles"); end
	  else begin $error("Fillscreen not completed after 19,200 cycles"); end
	#40
	assert(xdone == 1'b1) begin $display("Fillscreen completed at/before 19,210 cycles"); end
	  else begin $error("Fillscreen not completed after 19,210 cycles"); end
	#40
	assert(xdone == 1'b1) begin $display("Fillscreen completed at/before 19,220 cycles"); end
	  else begin $error("Fillscreen not completed after 19,220 cycles"); err = 1'b1; end

	if(err == 1'b0) $display("TEST 1 PASSED! Fillscreen works.");

	// RESET
	#10 rst = 1'b0;
	#90 rst = 1'b1;
	$display("Reset button depressed! Counter reset to:", counter);

	// START
	xstart = 1'b1;
	#38400
	$display("Counter is now at ", counter, " (should be ~9600)");
	#5 rst = 1'b0;
	#5 rst = 1'b1;
	xstart = 1'b0;
	#10
	assert(xvga_x == 8'b0) begin $display("X axis reset successful!"); end
	  else begin $error("Reset incomplete"); end
	assert(xvga_y == 7'b0) begin $display("Y axis reset successful!"); end
	  else begin $error("Reset incomplete"); end

	if(err == 1'b0) $display("TEST 2 PASSED! Reset Midway works.");

	
	if(err == 1'b1) $error("** TEST(s) FAILED for 'fillscreen.sv'");
	else $display("ALL TESTS PASSED! This marks the end of game tests for 'fillscreen.sv'.");

  end

endmodule: tb_fillscreen
