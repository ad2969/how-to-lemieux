module tb_datapath();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
  // PARAMETERS
  parameter repetitions = 500;
  parameter fclk_delay1 = 1;
  parameter fclk_delay2 = 2;

  // Wire declarations
  reg clk, fclk, xreset;
  reg xpload1, xpload2, xpload3;
  reg xdload1, xdload2, xdload3;

  wire [3:0] xpcard3, xpscore, xdscore;
  wire [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

  reg xddraw3;
  reg err;
  reg [1:0] xstate;

  // Module instantiation
  datapath dpdut(.slow_clock(clk), .fast_clock(fclk), .resetb(xreset),
                 .load_pcard1(xpload1), .load_pcard2(xpload2), .load_pcard3(xpload3),
                 .load_dcard1(xdload1), .load_dcard2(xdload2), .load_dcard3(xdload3),
                 .pcard3_out(xpcard3),
                 .dscore_out(xdscore), .pscore_out(xpscore),
                 .HEX5, .HEX4, .HEX3, .HEX2, .HEX1, .HEX0);

  initial begin
	fclk = 1'b0;
	repeat (repetitions) begin
	  #fclk_delay1 fclk = 1'b1;
	  #fclk_delay2 fclk = 1'b0;
	end
  end

  parameter delay1 = 10;
  parameter delay2 = 20;

  initial begin

	// Initialize everything
	clk = 1'b0; xreset = 1'b1;
	xpload1 = 1'b0; xpload2 = 1'b0; xpload3 = 1'b0;
	xdload1 = 1'b0; xdload2 = 1'b0; xdload3 = 1'b0;
	xddraw3 = 1'b0;

	// Start game by resetting
	xreset = 1'b0; #5
	xreset = 1'b1; #5

	#100

	// Load Cards
	xpload1 = 1'b1;
	clk = 1'b1; #5
	clk = 1'b0; #5
	xpload1 = 1'b0;

	#delay1;

	xdload1 = 1'b1;
	clk = 1'b1; #5
	clk = 1'b0; #5
	xdload1 = 1'b0;

	#delay2;

	xpload2 = 1'b1;
	clk = 1'b1; #5
	clk = 1'b0; #5
	xpload2 = 1'b0;

	#delay1;

	xdload2 = 1'b1;
	clk = 1'b1; #5
	clk = 1'b0; #5
	xdload2 = 1'b0;

	#delay2;

	clk = 1'b1; #5
	clk = 1'b0; #5

	$display("Player's hand has score of: %d", xpscore);
 	$display("Dealer's hand has score of: %d", xdscore);

	// Depending on what inputs are, something happens
	casex({xpscore,xdscore})
	  8'b1000xxxx: xstate = 2'b11;
	  8'bxxxx1000: xstate = 2'b11;a
	  8'b011x010x: xstate = 2'b10;
	  8'b011x00xx: xstate = 2'b10;
	  8'b010xxxxx: xstate = 2'b00;
	  8'b00xxxxxx: xstate = 2'b00;
	  default: xstate = 2'b11;
	endcase

	case(xstate)
	  // decide2
	  2'b00: begin
		$display("Player picks up card3");
		xpload3 = 1'b1;
		clk = 1'b1; #5
		clk = 1'b0; #5
		xpload3 = 1'b0;
		xstate = 2'b01;
	  end
	  2'b10: xddraw3 = 1'b1;
	  default: begin end
	endcase

	if(xstate == 2'b01) begin
	casex({xdscore, xpcard3})
	  8'b0110011x: xddraw3 = 1'b1;
	  8'b010101xx: xddraw3 = 1'b1;
	  8'b010001xx: xddraw3 = 1'b1;
	  8'b0100001x: xddraw3 = 1'b1;
	  8'b00110xxx: xddraw3 = 1'b1;
	  8'b0010xxxx: xddraw3 = 1'b1;
	  8'b000xxxxx: xddraw3 = 1'b1;
	  default: begin end
	endcase
	end

	if(xddraw3 == 1'b1) begin
	  $display("Dealer picks up card3");
	  xdload3 = 1'b1;
	  clk = 1'b1; #5
	  clk = 1'b0; #5
	  xdload3 = 1'b0;
	end

	clk = 1'b1; #5	// Evaluate results (compute)
	clk = 1'b0; #5

	$display("Player's final score: %d", xpscore);
 	$display("Dealer's final score: %d", xdscore);

	clk = 1'b1; #5	// Get into wait
	clk = 1'b0;

	$display("Player's final cards (hex): %b, %b, %b", HEX0, HEX1, HEX2);
 	$display("Dealer's final cards (hex): %b, %b, %b", HEX3, HEX4, HEX5);

	#100
	if(err == 1'b1) $error("** TEST(s) FAILED for 'datapath.sv'");
	else $display("ALL TESTS PASSED! This marks the end of game tests for 'datapath.sv'.");
  end

endmodule
