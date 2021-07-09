`define ACE 7'b0001000
`define TWO 7'b0100100
`define THREE 7'b0110000
`define FOUR 7'b0011001
`define FIVE 7'b0010010
`define SIX 7'b0000010
`define SEVEN 7'b1111000
`define EIGHT 7'b0000000
`define NINE 7'b0010000
`define TEN 7'b1000000
`define JACK 7'b1100001
`define QUEEN 7'b0011000
`define KING 7'b0001001
`define BLANK 7'b1111111

module tb_lab1();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 100,000 ticks (equivalent to "initial #100000 $finish();").

  // Parameters
  parameter fc_delay1 = 1;
  parameter fc_delay2 = 2;
  parameter fc_repetitions = 500;
  parameter clock_repetitions = 10;
  parameter delay = 8;
  
  // Declaring wires
  reg fast_clock;
  reg [3:0] buttons;
  wire [9:0] lights;
  wire [6:0] pcard1, pcard2, pcard3;
  wire [6:0] dcard1, dcard2, dcard3;

  reg [3:0] pc1, pc2, pc3;
  reg [3:0] dc1, dc2, dc3;

  reg err;

  // Module instantiation
  lab1 lab1_dut(.CLOCK_50(fast_clock), .KEY(buttons), .LEDR(lights),
                .HEX5(pcard3), .HEX4(pcard2), .HEX3(pcard1),
                .HEX2(dcard3), .HEX1(dcard2), .HEX0(dcard1));

  initial begin
	fast_clock = 1'b0;
	repeat (fc_repetitions) begin
	  #fc_delay1 fast_clock = 1'b1;
	  #fc_delay2 fast_clock = 1'b0;
	end
  end

  initial begin
	buttons = 4'b1000;
	err = 1'b0;
	
	// Start game by resetting
	#5 buttons = 4'b0000;
	#5 buttons = 4'b1000;
	
	// Now the fun stuff
	#100
	
	// Complete game
 	repeat(clock_repetitions) begin
	  #5 buttons = 4'b1001;
	  #5 buttons = 4'b1000;
	  #delay
	  case(pcard1)
		`ACE: pc1 = 4'b0001;
		`TWO: pc1 = 4'b0010;
		`THREE: pc1 = 4'b0011;
		`FOUR: pc1 = 4'b0100;
		`FIVE: pc1 = 4'b0101;
		`SIX: pc1 = 4'b0110;
		`SEVEN: pc1 = 4'b0111;
		`EIGHT: pc1 = 4'b1000;
		`NINE: pc1 = 4'b1001;
		default: pc1 = 4'b0000;
	  endcase
	  case(pcard2)
		`ACE: pc2 = 4'b0001;
		`TWO: pc2 = 4'b0010;
		`THREE: pc2 = 4'b0011;
		`FOUR: pc2 = 4'b0100;
		`FIVE: pc2 = 4'b0101;
		`SIX: pc2 = 4'b0110;
		`SEVEN: pc2 = 4'b0111;
		`EIGHT: pc2 = 4'b1000;
		`NINE: pc2 = 4'b1001;
		default: pc2 = 4'b0000;
	  endcase
	  case(pcard3)
		`ACE: pc3 = 4'b0001;
		`TWO: pc3 = 4'b0010;
		`THREE: pc3 = 4'b0011;
		`FOUR: pc3 = 4'b0100;
		`FIVE: pc3 = 4'b0101;
		`SIX: pc3 = 4'b0110;
		`SEVEN: pc3 = 4'b0111;
		`EIGHT: pc3 = 4'b1000;
		`NINE: pc3 = 4'b1001;
		default: pc3 = 4'b0000;
	  endcase
	  case(dcard1)
		`ACE: dc1 = 4'b0001;
		`TWO: dc1 = 4'b0010;
		`THREE: dc1 = 4'b0011;
		`FOUR: dc1 = 4'b0100;
		`FIVE: dc1 = 4'b0101;
		`SIX: dc1 = 4'b0110;
		`SEVEN: dc1 = 4'b0111;
		`EIGHT: dc1 = 4'b1000;
		`NINE: dc1 = 4'b1001;
		default: dc1 = 4'b0000;
	  endcase
	  case(dcard2)
		`ACE: dc2 = 4'b0001;
		`TWO: dc2 = 4'b0010;
		`THREE: dc2 = 4'b0011;
		`FOUR: dc2 = 4'b0100;
		`FIVE: dc2 = 4'b0101;
		`SIX: dc2 = 4'b0110;
		`SEVEN: dc2 = 4'b0111;
		`EIGHT: dc2 = 4'b1000;
		`NINE: dc2 = 4'b1001;
		default: dc2 = 4'b0000;
	  endcase
	  case(dcard3)
		`ACE: dc3 = 4'b0001;
		`TWO: dc3 = 4'b0010;
		`THREE: dc3 = 4'b0011;
		`FOUR: dc3 = 4'b0100;
		`FIVE: dc3 = 4'b0101;
		`SIX: dc3 = 4'b0110;
		`SEVEN: dc3 = 4'b0111;
		`EIGHT: dc3 = 4'b1000;
		`NINE: dc3 = 4'b1001;
		default: dc3 = 4'b0000;
	  endcase
	  $display("Player's cards: %d, %d, %d", pc1, pc2, pc3);
	  $display("P Score: %d", lab1_dut.pscore);

	  $display("Dealer's cards: %d, %d, %d", dc1, dc2, dc3);
	  $display("D Score: %d", lab1_dut.dscore);

	end

	assert(lights[3:0] == lab1_dut.pscore) $display("OK. Correct LED Output for Player");
	  else begin $error("Error: player score LED"); err = 1'b1; end
	assert(lights[7:4] == lab1_dut.dscore) $display("OK. Correct LED Output for Dealer");
	  else begin $error("Error: dealer score LED"); err = 1'b1; end

	if(lights[8] == 1'b1 && lights[9] == 1'b1) begin
	assert(lab1_dut.pscore == lab1_dut.dscore) $display("OK. Game Tied!");
	  else begin $error("Error: player and dealer LEDs"); err = 1'b1; end

	end
	else if(lights[8] == 1'b1) begin
	assert(lab1_dut.pscore > lab1_dut.dscore) $display("OK. Player Won!");
	  else begin $error("Error: player score LED"); err = 1'b1; end

	end
	else if(lights[9] == 1'b1) begin
	assert(lab1_dut.dscore > lab1_dut.pscore) $display("OK. Dealer Won!");
	  else begin $error("Error: dealer score LED"); err = 1'b1; end

	end

	#100
	if(err == 1'b1) $error("** TEST(s) FAILED for 'lab1.sv'");
	else $display("ALL TESTS PASSED! This marks the end of tests for 'lab1.sv'.");

  end		
endmodule

