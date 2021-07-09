module tb_circle();
    // Your testbench goes here. Our toplevel will give up after 1,000,000 ticks.
  // PARAMETERS
  parameter repetitions = 1900;	// budget is ??
  parameter clk_delay1 = 1;
  parameter clk_delay2 = 1;

  integer i;

  reg clk, rst;
  reg [2:0] xcolour;
  reg [7:0] xcentre_x;
  reg [6:0] xcentre_y;
  reg [7:0] xradius;
  reg xstart, xdone;

  reg [7:0] xvga_x;
  reg [6:0] xvga_y;
  reg [2:0] xvga_colour;
  reg xvga_plot;

  reg [15:0] counter;
  reg err;

  circle dutc(.clk(clk), .rst_n(rst), .colour(xcolour),
	      .centre_x(xcentre_x), .centre_y(xcentre_y), .radius(xradius),
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
	xcentre_x = 8'b01010000; xcentre_y = 7'b0111100; xradius = 8'b00011110; 
	#90 rst = 1'b1;
	$display("Reset button depressed! Counter reset to:", counter);

	// START (159 x 119)
	xcolour = 3'b111;
	// Test 1: middle of screen (80, 60, r30)
	xstart = 1'b1;
	#300
	$display("Counter is now at ", counter, " (should be 144)");
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 150 cycles"); end
	  else begin $error("Drawcircle not completed after 150 cycles"); end
	#100
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 200 cycles"); end
	  else begin $error("Drawcircle not completed after 200 cycles"); end
	#100
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 250 cycles"); end
	  else begin $error("Drawcircle not completed after 250 cycles"); err = 1'b1; end

	if(err == 1'b0) $display("TEST 1 PASSED! Small Circle Timing is Correct.");

	#200

	// RESET
	#10 rst = 1'b0;
	xcentre_x = 8'b01111000; xcentre_y = 7'b0111100; xradius = 8'b00110010; counter = 16'b0;
	#90 rst = 1'b1;
	$display("Reset button depressed! Counter reset to:", counter);

	// START
	// Test 2: middle right (120, 60, r50)
	xstart = 1'b1;
	for(i = 0; i < 400; i++) begin
	  #1
	  assert(xvga_x <= 8'b10011111) begin end
	    else if(xvga_plot == 1'b1) begin $error("Writing to x out of bounds!"); err = 1'b1; end
	  assert(xvga_y <= 7'b1110111) begin end
	    else if(xvga_plot == 1'b1) begin $error("Writing to y out of bounds!"); err = 1'b1; end
	end
	$display("Counter is now at ", counter, " (should be 200)");
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 200 cycles"); end
	  else begin $error("Drawcircle not completed after 200 cycles"); end
	#100
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 250 cycles"); end
	  else begin $error("Drawcircle not completed after 250 cycles"); end
	#100
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 300 cycles"); end
	  else begin $error("Drawcircle not completed after 300 cycles"); err = 1'b1; end

	if(err == 1'b0) $display("TEST 2 PASSED! Circle X-bounds checked.");
	
	#200

	// RESET
	#10 rst = 1'b0;
	xcentre_x = 8'b00000000; xcentre_y = 7'b1011010; xradius = 8'b00110010; counter = 16'b0;
	#90 rst = 1'b1;
	$display("Reset button depressed! Counter reset to:", counter);

	// START
	// Test 3: bottom left (0, 90, r50)
	xstart = 1'b1;
	for(i = 0; i < 400; i++) begin
	  #1
	  assert(xvga_x <= 8'b10011111) begin end
	    else if(xvga_plot == 1'b1) begin $error("Writing to x out of bounds!"); err = 1'b1; end
	  assert(xvga_y <= 7'b1110111) begin end
	    else if(xvga_plot == 1'b1) begin $error("Writing to y out of bounds!"); err = 1'b1; end
	end
	$display("Counter is now at ", counter, " (should be 200)");
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 200 cycles"); end
	  else begin $error("Drawcircle not completed after 200 cycles"); end
	#100
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 250 cycles"); end
	  else begin $error("Drawcircle not completed after 250 cycles"); end
	#100
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 300 cycles"); end
	  else begin $error("Drawcircle not completed after 300 cycles"); err = 1'b1; end

	if(err == 1'b0) $display("TEST 3 PASSED! Circle negative X and positive Y-bounds checked.");
	
	#200

	// RESET
	#10 rst = 1'b0;
	xcentre_x = 8'b00000000; xcentre_y = 7'b0000000; xradius = 8'b01100100; counter = 16'b0;
	#90 rst = 1'b1;
	$display("Reset button depressed! Counter reset to:", counter);

	// START
	// Test 4: origin (0, 0, r100)
	xstart = 1'b1;
	for(i = 0; i < 920; i++) begin
	  #1
	  assert(xvga_x <= 8'b10011111) begin end
	    else if(xvga_plot == 1'b1) begin $error("Writing to x out of bounds!"); err = 1'b1; end
	  assert(xvga_y <= 7'b1110111) begin end
	    else if(xvga_plot == 1'b1) begin $error("Writing to y out of bounds!"); err = 1'b1; end
	end
	$display("Counter is now at ", counter, " (should be 460)");
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 460 cycles"); end
	  else begin $error("Drawcircle not completed after 460 cycles"); end
	#100
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 510 cycles"); end
	  else begin $error("Drawcircle not completed after 510 cycles"); end
	#100
	assert(xdone == 1'b1) begin $display("Drawcircle completed at/before 560 cycles"); end
	  else begin $error("Drawcircle not completed after 560 cycles"); err = 1'b1; end

	if(err == 1'b0) $display("TEST 4 PASSED! Circle negative X and positive Y-bounds checked.");

	if(err == 1'b1) $error("** TEST(s) FAILED for 'circle.sv'");
	else $display("ALL TESTS PASSED! This marks the end of game tests for 'circle.sv'.");

  end
endmodule: tb_circle
