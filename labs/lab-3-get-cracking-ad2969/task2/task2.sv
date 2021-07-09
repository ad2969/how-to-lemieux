module task2(input logic CLOCK_50, input logic [3:0] KEY, input logic [9:0] SW,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [9:0] LEDR);

    // your code here

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

  // circuit description

  wire [7:0] write_address, write_data, read_data;
  wire write_enable;
  wire [7:0] mem_output;

  reg assert_init, assert_ksa;
  wire init_ready, init_enable, ksa_ready, ksa_enable;

  // states for init and ksa
  reg [2:0] state;
  wire [7:0] i_address, k_address;
  wire [7:0] i_wrdata, k_wrdata;

  s_mem s(.address(write_address),
	  .clock(CLOCK_50),
	  .data(write_data),
	  .wren(write_enable),
	  .q(mem_output));

  init i(.clk(CLOCK_50), .rst_n(KEY[3]),
         .en(init_enable), .rdy(init_ready),
         .addr(i_address), .wrdata(i_wrdata), .wren(i_wren));

  ksa k(.clk(CLOCK_50), .rst_n(KEY[3]),
         .en(ksa_enable), .rdy(ksa_ready),
         .key({14'b0, SW}),
         .addr(k_address), .rddata(read_data), .wrdata(k_wrdata), .wren(k_wren));

  assign read_data = mem_output;

  assign init_enable = assert_init && init_ready;
  assign ksa_enable = assert_ksa && ksa_ready;

  // prevent ddress and data from being driven by two modules init and ksa
  assign write_address = state >= 3'b100 ? k_address : i_address;
  assign write_data = state >= 3'b100 ? k_wrdata : i_wrdata;
  assign write_enable = state >= 3'b100 ? k_wren : i_wren;

  always @(posedge CLOCK_50) begin
	// if reset is asserted (init has to be ready)
	if(!KEY[3] && init_ready) begin
	  hex5 = `R; hex4 = `E; hex3 = `S; hex2 = `E; hex1 = `T; hex0 = 7'b1111111;
	  assert_init = 1'b1; state = 2'b01;
	end
	else begin
	  hex5 = `I; hex4 = `D; hex3 = `L; hex2 = `E; hex1 = 7'b1111111; hex0 = 7'b1111111;
	  case (state)
		3'b001: begin
		  assert_init = 1'b0; assert_ksa = 1'b0; state = 3'b010;
		end
		3'b010: begin
		  if(init_ready) state = 3'b100;
		end
		3'b100: begin
		  assert_ksa = 1'b1; state = 3'b101;
		end
		3'b101: begin
		  assert_ksa = 1'b0; state = 3'b110;		
		end
		3'b110: begin
		  if(ksa_ready == 1'b1) state = 3'b000;
		end
	 	default: begin
		  assert_init = 1'b0; assert_ksa = 1'b0; state = 2'b00;
		end
	  endcase
	end
  end

endmodule: task2
