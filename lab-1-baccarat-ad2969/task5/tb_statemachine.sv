module tb_statemachine();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

  // Wire input & output declaration
  reg clk;
  reg xreset;
  reg [3:0] xdscore;
  reg [3:0] xpscore;
  reg [3:0] xpcard3;

  wire xpload1, xpload2, xpload3;
  wire xdload1, xdload2, xdload3;
  wire xpwin, xdwin;

  reg err;

  // Module instantiation
  statemachine fsmdut(.slow_clock(clk), .resetb(xreset),
                      .dscore(xdscore), .pscore(xpscore), .pcard3(xpcard3),
                      .load_pcard1(xpload1), .load_pcard2(xpload2), .load_pcard3(xpload3),
                      .load_dcard1(xdload1), .load_dcard2(xdload2), .load_dcard3(xdload3),
                      .player_win_light(xpwin), .dealer_win_light(xdwin));
  initial begin
	// initial conditions
	clk = 1'b0; xreset = 1'b1;  err = 1'b0;
	xpscore = 4'b0000; xdscore = 4'b0000; xpcard3 = 4'b0000;
	#10

	// Start game by resetting
	xreset = 1'b0; #5
	xreset = 1'b1; #5
	// Check if reset works
	assert(xpwin == 1'b0)
	  else begin $error("Error Resetting: Win Status"); err = 1'b1; end
	assert(xdwin == 1'b0)
	  else begin $error("Error Resetting: Dealer Win Status"); err = 1'b1; end
	assert(xpload1 == 1'b0)
	  else begin $error("Error Resetting: pCard load1"); err = 1'b1; end
	assert(xpload2 == 1'b0)
	  else begin $error("Error Resetting: pCard load2"); err = 1'b1; end
	assert(xpload3 == 1'b0)
	  else begin $error("Error Resetting: pCard load3"); err = 1'b1; end
	assert(xdload1 == 1'b0)
	  else begin $error("Error Resetting: dCard load1"); err = 1'b1; end
	assert(xdload2 == 1'b0)
	  else begin $error("Error Resetting: dCard load2"); err = 1'b1; end
	assert(xdload3 == 1'b0)
	  else begin $error("Error Resetting: dCard load3"); err = 1'b1; end
	if(err == 1'b0) $display("RESET OK.");

	// Check card dealing
	clk = 1'b1; #5
	clk = 1'b0; #5
	assert(xpload1 == 1'b1 && xpload2 == 1'b0 && xpload3 == 1'b0
		&& xdload1 == 1'b0 && xdload2 == 1'b0 && xdload3 == 1'b0)
	   else begin $error("Error: Player Card Deal 1"); err = 1'b1; end

	clk = 1'b1; #5
	clk = 1'b0; #5
	assert(xpload1 == 1'b0 && xpload2 == 1'b0 && xpload3 == 1'b0
		&& xdload1 == 1'b1 && xdload2 == 1'b0 && xdload3 == 1'b0)
	   else begin $error("Error: Dealer Card Deal 1"); err = 1'b1; end

	clk = 1'b1; #5
	clk = 1'b0; #5
	assert(xpload1 == 1'b0 && xpload2 == 1'b1 && xpload3 == 1'b0
		&& xdload1 == 1'b0 && xdload2 == 1'b0 && xdload3 == 1'b0)
	   else begin $error("Error: Player Card Deal 2"); err = 1'b1; end

	clk = 1'b1; #5
	clk = 1'b0; #5
	assert(xpload1 == 1'b0 && xpload2 == 1'b0 && xpload3 == 1'b0
		&& xdload1 == 1'b0 && xdload2 == 1'b1 && xdload3 == 1'b0)
	   else begin $error("Error: Dealer Card Deal 2"); err = 1'b1; end

	clk = 1'b1; #5
	clk = 1'b0; #5

	assert(xpload1 == 1'b0 && xpload2 == 1'b0 && xpload3 == 1'b1
		&& xdload1 == 1'b0 && xdload2 == 1'b0 && xdload3 == 1'b0)
	   else begin $error("Error: Player Card Deal 3"); err = 1'b1; end

	clk = 1'b1; #5
	clk = 1'b0; #5
	assert(xpload1 == 1'b0 && xpload2 == 1'b0 && xpload3 == 1'b0
		&& xdload1 == 1'b0 && xdload2 == 1'b0 && xdload3 == 1'b1)
	   else begin $error("Error: Dealer Card Deal 3"); err = 1'b1; end

	clk = 1'b1; #5	// Evaluate results with both total points = 0 (TIED)
	clk = 1'b0; #5
	clk = 1'b1; #5	// Get into wait
	clk = 1'b0; #5

	assert(xpwin == 1'b1 && xdwin == 1'b1) $display("TEST COMPLETE: GAME TIED!");
	   else begin $error("Error: 0-0 Game"); err = 1'b1; end

	  // reset game
	  xreset = 1'b0; #5
	  xreset = 1'b1;  #5
	  xpscore = 4'b0000; xdscore = 4'b0000; xpcard3 = 4'b0000;

	// Test game mechanics
	// Test 1: Natural
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 1
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 2
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 3
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 4

	xpscore = 4'b1001; xdscore = 4'b1000;  // Player wins (9-8)
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 5 (decide)
	
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 8 (compute)

	clk = 1'b1; #5
	clk = 1'b0; #5	// wait

	assert(xpwin == 1'b1 && xdwin == 1'b0) $display("TEST 1 COMPLETE: PLAYER WON!");
	   else begin $error("Error: 9-8 game"); err = 1'b1; end

	  // reset game
	  xreset = 1'b0; #5
	  xreset = 1'b1;  #5
	  xpscore = 4'b0000; xdscore = 4'b0000; xpcard3 = 4'b0000;

	// Test 2: High Draw
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 1
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 2
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 3
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 4

	xpscore = 4'b1001; xdscore = 4'b1001;  // Player draws (9-9)
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 5 (decide)
	
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 8 (compute)

	clk = 1'b1; #5
	clk = 1'b0; #5	// wait

	assert(xpwin == 1'b1 && xdwin == 1'b1) $display("TEST 2 COMPLETE: NATURAL DRAW!");
	   else begin $error("Error: 9-9 game"); err = 1'b1; end

	  // reset game
	  xreset = 1'b0; #5
	  xreset = 1'b1;  #5
	  xpscore = 4'b0000; xdscore = 4'b0000; xpcard3 = 4'b0000;

	// Test 3: Medium Lose
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 1
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 2
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 3
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 4

	xpscore = 4'b0110; xdscore = 4'b1000;  // Player loses (6-8)
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 5 (decide)
	
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 8 (compute)

	clk = 1'b1; #5
	clk = 1'b0; #5	// wait

	assert(xpwin == 1'b0 && xdwin == 1'b1) $display("TEST 3 COMPLETE: PLAYER LOST!");
	   else begin $error("Error: 6-8 game"); err = 1'b1; end

	  // reset game
	  xreset = 1'b0; #5
	  xreset = 1'b1;  #5
	  xpscore = 4'b0000; xdscore = 4'b0000; xpcard3 = 4'b0000;

	// Test 4: Medium Win
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 1
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 2
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 3
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 4

	xpscore = 4'b0110; xdscore = 4'b0001;  // Player wins (6-1)
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 5 (decide)

	clk = 1'b1; #5
	clk = 1'b0; #5	// state 7 (ddraw3)
	xdscore = 4'b0011;
	
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 8 (compute)

	clk = 1'b1; #5
	clk = 1'b0; #5	// wait

	assert(xpwin == 1'b1 && xdwin == 1'b0) $display("TEST 4 COMPLETE: PLAYER WON!");
	   else begin $error("Error: 6-3 game"); err = 1'b1; end

	  // reset game
	  xreset = 1'b0; #5
	  xreset = 1'b1;  #5
	  xpscore = 4'b0000; xdscore = 4'b0000; xpcard3 = 4'b0000;

	// Test 5: Low Draw
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 1
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 2
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 3
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 4

	xpscore = 4'b0011; xdscore = 4'b0011;  // Player draw (3-3)
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 5 (decide)

	clk = 1'b1; #5
	clk = 1'b0; #5	// state 6 (pdraw3)

	xpscore = 4'b0111; xpcard3 = 4'b0100;
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 7 (ddraw3)

	xdscore = 4'b0111;
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 8 (compute)

	clk = 1'b1; #5
	clk = 1'b0; #5	// wait

	assert(xpwin == 1'b1 && xdwin == 1'b1) $display("TEST 5 COMPLETE: DRAW!");
	   else begin $error("Error: 7-7 game"); err = 1'b1; end

	  // reset game
	  xreset = 1'b0; #5
	  xreset = 1'b1;  #5
	  xpscore = 4'b0000; xdscore = 4'b0000; xpcard3 = 4'b0000;

	// Test 6: Low Lose
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 1
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 2
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 3
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 4

	xpscore = 4'b0001; xdscore = 4'b0000;  // Player lose (1-0)
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 5 (decide)

	clk = 1'b1; #5
	clk = 1'b0; #5	// state 6 (pdraw3)

	xpscore = 4'b0110; xpcard3 = 4'b0101;
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 7 (ddraw3)

	xdscore = 4'b0111;
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 8 (compute)

	clk = 1'b1; #5
	clk = 1'b0; #5	// wait

	assert(xpwin == 1'b0 && xdwin == 1'b1) $display("TEST 6 COMPLETE: PLAYER LOST!");
	   else begin $error("Error: 6-7 game"); err = 1'b1; end

	  // reset game
	  xreset = 1'b0; #5
	  xreset = 1'b1;  #5
	  xpscore = 4'b0000; xdscore = 4'b0000; xpcard3 = 4'b0000;

	// Test 7: Low Lose 2
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 1
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 2
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 3
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 4

	xpscore = 4'b0001; xdscore = 4'b1000;  // Player win (1-8)
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 5 (decide)

	clk = 1'b1; #5
	clk = 1'b0; #5	// state 6 (pdraw3)

	xpscore = 4'b0111; xpcard3 = 4'b0110;
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 8 (compute)

	clk = 1'b1; #5
	clk = 1'b0; #5	// wait

	assert(xpwin == 1'b0 && xdwin == 1'b1) $display("TEST 7 COMPLETE: PLAYER LOST!");
	   else begin $error("Error: 7-8 game"); err = 1'b1; end

	  // reset game
	  xreset = 1'b0; #5
	  xreset = 1'b1;  #5
	  xpscore = 4'b0000; xdscore = 4'b0000; xpcard3 = 4'b0000;

	// Test 7: Low Win
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 1
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 2
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 3
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 4

	xpscore = 4'b0001; xdscore = 4'b0110;  // Player win (1-6)
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 5 (decide)

	clk = 1'b1; #5
	clk = 1'b0; #5	// state 6 (pdraw3)

	xpscore = 4'b0111; xpcard3 = 4'b0110;
	clk = 1'b1; #5
	clk = 1'b0; #5	// state 7 (ddraw3)

	clk = 1'b1; #5
	clk = 1'b0; #5	// state 8 (compute)

	clk = 1'b1; #5
	clk = 1'b0; #5	// wait
	
	assert(xpwin == 1'b1 && xdwin == 1'b0) $display("TEST 8 COMPLETE: PLAYER WON!");
	   else begin $error("Error: 7-6 game"); err = 1'b1; end

	#100
	if(err == 1'b1) $error("** TEST(s) FAILED for 'statemachine.sv'");
	else $display("ALL TESTS PASSED! This marks the end of output tests for 'statemachine.sv'.");

  end
						
endmodule
