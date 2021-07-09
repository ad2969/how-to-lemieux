module task3(input logic CLOCK_50, input logic [3:0] KEY, input logic [9:0] SW,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [9:0] LEDR);

  // HEX PARAMETERS
  `define A 7'b0001000
  `define B 7'b0000000
  `define C 7'b1000110
  `define D 7'b0100001
  `define E 7'b0000110
  `define F 7'b0001110
  `define G 7'b0100010
  `define H 7'b0001011
  `define I 7'b1001111
  `define J 7'b1100001
  `define K 7'b0001001
  `define L 7'b1000111
  `define M 7'b0101010
  `define N 7'b1001000
  `define O 7'b1000000
  `define P 7'b0001100
  `define Q 7'b0110000
  `define R 7'b0001000
  `define S 7'b0010010
  `define T 7'b0000111
  `define U 7'b1100011
  `define V 7'b1000001
  `define W 7'b1100010
  `define X 7'b1011010
  `define Y 7'b0010001
  `define Z 7'b0100100

  reg [6:0] hex0, hex1, hex2, hex3, hex4, hex5;
  assign HEX0 = hex0; assign HEX1 = hex1; assign HEX2 = hex2;
  assign HEX3 = hex3; assign HEX4 = hex4; assign HEX5 = hex5;

  reg state;
  reg ar_enable;

  wire reset = ~KEY[3];

  wire ar_ready;

  wire [7:0] pt_wrdata, pt_rddata, pt_address;
  wire [7:0] ct_rddata, ct_address;
  wire pt_wren;

  assign LEDR = 10'b0;

    // module instantiations
    pt_mem pt(.address(pt_address),
	      .clock(CLOCK_50),
	      .data(pt_wrdata),
	      .wren(pt_wren),
	      .q(pt_rddata));

    ct_mem ct(.address(ct_address),
	      .clock(CLOCK_50),
	      .q(ct_rddata));

    arc4 a4(.clk(CLOCK_50), .rst_n(KEY[3]),
	    .en(ar_enable), .rdy(ar_ready),
	    .key({14'b0, SW}),
	    .ct_addr(ct_address), .ct_rddata(ct_rddata),
	    .pt_addr(pt_address), .pt_rddata(pt_rddata), .pt_wrdata(pt_wrdata), .pt_wren(pt_wren));

    // your code here
  always @(posedge CLOCK_50) begin
	if(reset && ar_ready) begin
		ar_enable = 1'b1; state = 1'b1;
		hex5 = `R; hex4 = `E; hex3 = `S; hex2 = `E; hex1 = `T; hex0 = 7'b1111111;
	end
	else begin
	case(state)
	  1'b1: begin
		ar_enable = 1'b0;
		if(ar_ready) state = 1'b0;
		hex5 = `R; hex4 = `E; hex3 = `S; hex2 = `E; hex1 = `T; hex0 = 7'b1111111;
	  end
	  default: begin
		ar_enable <= 1'b0; state <= 1'b0;
		hex5 = `R; hex4 = `E; hex3 = `A; hex2 = `D; hex1 = `Y; hex0 = 7'b1111111;
	  end
	endcase
	end
  end

endmodule: task3
