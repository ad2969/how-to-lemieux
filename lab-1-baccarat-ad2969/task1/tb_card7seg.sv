module tb_card7seg();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

  // wire & bus instantiation
  reg [3:0] xin;
  reg [6:0] xout;

  reg err;

  // module instantiation
  card7seg segdut(.SW(xin), .HEX0(xout));

  initial begin
	// initial conditions
	xin = 4'b0000; err = 1'b0;
	#10
	assert(xout === 7'b1111111) $display("OK. Zero Exists");
	  else begin $error("Error comparing: Zero"); err = 1'b1; end

	xin = 4'b0001;
	#10
	assert(xout === 7'b0001000) $display("OK. Ace Exists");
	  else begin $error("Error comparing: Ace"); err = 1'b1; end

	xin = 4'b0010;
	#10
	assert(xout === 7'b0100100) $display("OK. Two Exists");
	  else begin $error("Error comparing: Two"); err = 1'b1; end

	xin = 4'b0011;
	#10
	assert(xout === 7'b0110000) $display("OK. Three Exists");
	  else begin $error("Error comparing: Three"); err = 1'b1; end

	xin = 4'b0100;
	#10
	assert(xout === 7'b0011001) $display("OK. Four Exists");
	  else begin $error("Error comparing: Four"); err = 1'b1; end

	xin = 4'b0101;
	#10
	assert(xout === 7'b0010010) $display("OK. Five Exists");
	  else begin $error("Error comparing: Five"); err = 1'b1; end

	xin = 4'b0110;
	#10
	assert(xout === 7'b0000010) $display("OK. Six Exists");
	  else begin $error("Error comparing: Six"); err = 1'b1; end

	xin = 4'b0111;
	#10
	assert(xout === 7'b1111000) $display("OK. Seven Exists");
	  else begin $error("Error comparing: Seven"); err = 1'b1; end

	xin = 4'b1000;
	#10
	assert(xout === 7'b0000000) $display("OK. Eight Exists");
	  else begin $error("Error comparing: Eight"); err = 1'b1; end

	xin = 4'b1001;
	#10
	assert(xout === 7'b0010000) $display("OK. Nine Exists");
	  else begin $error("Error comparing: Nine"); err = 1'b1; end

	xin = 4'b1010;
	#10
	assert(xout === 7'b1000000) $display("OK. Ten Exists");
	  else begin $error("Error comparing: Ten"); err = 1'b1; end

	xin = 4'b1011;
	#10
	assert(xout === 7'b1100001) $display("OK. Jack Exists");
	  else begin $error("Error comparing: Jack"); err = 1'b1; end

	xin = 4'b1100;
	#10
	assert(xout === 7'b0011000) $display("OK. Queen Exists");
	  else begin $error("Error comparing: Queen"); err = 1'b1; end

	xin = 4'b1101;
	#10
	assert(xout === 7'b0001001) $display("OK. King Exists");
	  else begin $error("Error comparing: King"); err = 1'b1; end

	xin = 4'b1110;
	#10
	assert(xout === 7'b1111111) $display("OK. BIT14 Produces Correct Output");
	  else begin $error("Error comparing: BIT14"); err = 1'b1; end

	xin = 4'b1111;
	#10
	assert(xout === 7'b1111111) $display("OK. BIT15 Produces Correct Output");
	  else begin $error("Error comparing: BIT15"); err = 1'b1; end

	#10
	if(err == 1'b1) $display("Tests failed");
	else $display("End of Test. ALL TESTS PASSED!");

  end

endmodule: tb_card7seg
