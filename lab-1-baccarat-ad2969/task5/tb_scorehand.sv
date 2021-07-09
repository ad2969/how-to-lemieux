module tb_scorehand();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").
  reg [3:0] xcard1;
  reg [3:0] xcard2;
  reg [3:0] xcard3;
  wire [3:0] xcomputed;
  
  reg err;

  // module instantiation
  scorehand scoredut(.card1(xcard1), .card2(xcard2), .card3(xcard3), .total(xcomputed));
	
  initial begin
	// initial conditions
	xcard1 = 4'b0000; xcard2 = 4'b0000; xcard3 = 4'b0000;
	#10
	assert(xcomputed === 4'b0000) $display("OK. Correct Output (No Inputs).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b0001; xcard2 = 4'b0000; xcard3 = 4'b0000;
	#10
	assert(xcomputed === 4'b0001) $display("OK. Correct Output (First Input).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b0000; xcard2 = 4'b0001; xcard3 = 4'b0000;
	#10
	assert(xcomputed === 4'b0001) $display("OK. Correct Output (Second Input).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b0000; xcard2 = 4'b0000; xcard3 = 4'b0001;
	#10
	assert(xcomputed === 4'b0001) $display("OK. Correct Output (Third Input).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b0001; xcard2 = 4'b0001; xcard3 = 4'b0000;
	#10
	assert(xcomputed === 4'b0010) $display("OK. Correct Output (Two Inputs).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b0001; xcard2 = 4'b0000; xcard3 = 4'b0001;
	#10
	assert(xcomputed === 4'b0010) $display("OK. Correct Output (Two Inputs).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b0000; xcard2 = 4'b0001; xcard3 = 4'b0001;
	#10
	assert(xcomputed === 4'b0010) $display("OK. Correct Output (Two Inputs).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b0001; xcard2 = 4'b0001; xcard3 = 4'b0001;
	#10
	assert(xcomputed === 4'b0011) $display("OK. Correct Output (Three Inputs).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b1000; xcard2 = 4'b0100; xcard3 = 4'b0010; // 2 + 4 + 8 = 14 --> outputs 4
	#10
	assert(xcomputed === 4'b0100) $display("OK. Correct Output (Three Inputs, Overflow).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b0111; xcard2 = 4'b0111; xcard3 = 4'b0111; // 7 + 7 + 7 = 21 --> outputs 1
	#10
	assert(xcomputed === 4'b0001) $display("OK. Correct Output (Three Inputs, Overflow).");
	  else begin $error("Error computing!"); err = 1'b1; end

	xcard1 = 4'b0111; xcard2 = 4'b0111; xcard3 = 4'b0110; // 7 + 7 + 6 = 20 --> outputs 0
	#10
	assert(xcomputed === 4'b0000) $display("OK. Correct Output (Three Inputs, Overflow).");
	  else begin $error("Error computing!"); err = 1'b1; end

	#100
	if(err == 1'b1) $error("** TEST(s) FAILED for 'scorehand.sv'");
	else $display("ALL TESTS PASSED! This marks the end of arithmetic tests for 'scorehand.sv'.");

  end
						
endmodule