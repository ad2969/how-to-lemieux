module flash_reader(input logic CLOCK_50, input logic [3:0] KEY, input logic [9:0] SW,
                    output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
                    output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
                    output logic [9:0] LEDR);

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

// You may use the SW/HEX/LEDR ports for debugging. DO NOT delete or rename any ports or signals.

reg [3:0] state;

logic clk, rst_n;

assign clk = CLOCK_50;
assign rst_n = KEY[3];


logic flash_mem_read, flash_mem_waitrequest, flash_mem_readdatavalid;
logic [22:0] flash_mem_address;
logic [31:0] flash_mem_readdata;
logic [3:0] flash_mem_byteenable;

flash flash_inst(.clk_clk(clk), .reset_reset_n(rst_n), .flash_mem_write(1'b0), .flash_mem_burstcount(1'b1),
                 .flash_mem_waitrequest(flash_mem_waitrequest), .flash_mem_read(flash_mem_read), .flash_mem_address(flash_mem_address),
                 .flash_mem_readdata(flash_mem_readdata), .flash_mem_readdatavalid(flash_mem_readdatavalid), .flash_mem_byteenable(flash_mem_byteenable), .flash_mem_writedata());

logic [15:0] mem_writedata, mem_output;
logic [7:0] mem_address;
logic mem_wren;

logic [15:0] flash_mem_readdata1, flash_mem_readdata2;

s_mem samples(.address(mem_address),
	      .clock(clk),
	      .data(mem_writedata),
	      .wren(mem_wren),
	      .q(mem_output));

assign flash_mem_byteenable = 4'b1111;
assign flash_mem_readdata1 = flash_mem_readdata[15:0];
assign flash_mem_readdata2 = flash_mem_readdata[31:16];

// the rest of your code goes here.  don't forget to instantiate the on-chip memory
  always @(posedge clk) begin
	if(!rst_n) begin
	  mem_address = 8'b0;
	  flash_mem_address = 23'b0;

	  mem_writedata = 16'b0;
	  mem_wren = 1'b0;
	  flash_mem_read = 1'b0;

	  state = 4'b0000;
	  hex5 = `R; hex4 = `E; hex3 = `S; hex2 = `E; hex1 = `T; hex0 = 7'b1111111;
	end

	else begin
	case(state)

	4'b0000: begin  // start reading memory from address on request
	  flash_mem_read = 1'b1;
	  state = 4'b0001;
	  hex5 = `R; hex4 = `E; hex3 = `A; hex2 = `D; hex1 =7'b1111111; hex0 = 7'b1111111;
	end

	4'b0001: begin // wait until waitrequest deasserted
	  if(flash_mem_waitrequest == 1'b0) state = 4'b0010;
	  else state = 4'b0001;
	end
 
	4'b0010: begin  // wait until read data is valid
	  if(flash_mem_readdatavalid == 1'b1) begin
		flash_mem_read = 1'b0;
		mem_writedata = flash_mem_readdata1;
		state = 4'b0011;
	  end
	  else state = 4'b0010;
	end

	4'b0011: begin  // save read data 1
	  mem_wren = 1'b1;
	  state = 4'b0100;
	end

	4'b0100: begin
	  mem_wren = 1'b1;
	  state = 4'b0101;
	end

	4'b0101: begin  // save read data 2
	  mem_wren = 1'b1;
	  mem_address = mem_address + 8'b1;
	  mem_writedata = flash_mem_readdata2;
	  state = 4'b0110;
	end

	4'b0110: begin
	  mem_wren = 1'b1;
	  state = 4'b0111;
	end

	4'b0111: begin  // stop writing
	  mem_wren = 1'b0;
	  state = 4'b1000;
	end

	4'b1000: begin  // read next data or stop reading
	  if(mem_address == 8'b11111111 || flash_mem_address == 23'b11111111) begin
		state = 4'b1111;
	  end
	  else begin
		mem_address = mem_address + 8'b1;
		flash_mem_address = flash_mem_address + 23'b1;
		state = 4'b0000;
	  end
	end

	4'b1111: begin // WAIT LOOP
	  mem_writedata = 16'b0;
	  mem_wren = 1'b0;

	  flash_mem_read = 1'b0;

	  state = 4'b1111;
	  hex5 = `D; hex4 = `O; hex3 = `N; hex2 = `E; hex1 = 7'b1111111; hex0 = 7'b1111111;
	end

	default: begin // at the start
	  mem_address = 8'b0;
	  flash_mem_address = 23'b0;

	  mem_writedata = 16'b0;
	  mem_wren = 1'b0;

	  state = 4'b0000;
	end
	endcase
	end
  end

endmodule: flash_reader