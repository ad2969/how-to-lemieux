module music(input CLOCK_50, input CLOCK2_50, input [3:0] KEY, input [9:0] SW,
             input AUD_DACLRCK, input AUD_ADCLRCK, input AUD_BCLK, input AUD_ADCDAT,
             inout FPGA_I2C_SDAT, output FPGA_I2C_SCLK, output AUD_DACDAT, output AUD_XCK,
             output [6:0] HEX0, output [6:0] HEX1, output [6:0] HEX2,
             output [6:0] HEX3, output [6:0] HEX4, output [6:0] HEX5,
             output [9:0] LEDR);

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

  assign HEX0 = hex0;
  assign HEX1 = hex1;
  assign HEX2 = hex2;
  assign HEX3 = hex3;
  assign HEX4 = hex4;
  assign HEX5 = hex5;

  // SM STATE DECLARATIONS

  typedef enum { state_start,
		 wait_data_request,
		 wait_data_validate,
		 wait_codec1_ready,
		 wait_codec1_send,
		 wait_codec1_accept,
		 wait_codec2_ready,
		 wait_codec2_send,
		 wait_codec2_accept,
		 compute_count,
		 state_done } state_type;

  state_type state;
  reg [31:0] sample;
  reg [15:0] computed;

// signals that are used to communicate with the audio core
// DO NOT alter these -- we will use them to test your design

reg read_ready, write_ready, write_s;
reg [15:0] writedata_left, writedata_right;
reg [15:0] readdata_left, readdata_right;
wire reset, read_s;

// signals that are used to communicate with the flash core
// DO NOT alter these -- we will use them to test your design

reg flash_mem_read;
reg flash_mem_waitrequest;
reg [22:0] flash_mem_address;
reg [31:0] flash_mem_readdata;
reg flash_mem_readdatavalid;
reg [3:0] flash_mem_byteenable;
reg rst_n, clk;

// DO NOT alter the instance names or port names below -- we will use them to test your design

clock_generator my_clock_gen(CLOCK2_50, reset, AUD_XCK);
audio_and_video_config cfg(CLOCK_50, reset, FPGA_I2C_SDAT, FPGA_I2C_SCLK);
audio_codec codec(CLOCK_50,reset,read_s,write_s,writedata_left, writedata_right,AUD_ADCDAT,AUD_BCLK,AUD_ADCLRCK,AUD_DACLRCK,read_ready, write_ready,readdata_left, readdata_right,AUD_DACDAT);
flash flash_inst(.clk_clk(clk), .reset_reset_n(rst_n), .flash_mem_write(1'b0), .flash_mem_burstcount(1'b1),
                 .flash_mem_waitrequest(flash_mem_waitrequest), .flash_mem_read(flash_mem_read), .flash_mem_address(flash_mem_address),
                 .flash_mem_readdata(flash_mem_readdata), .flash_mem_readdatavalid(flash_mem_readdatavalid), .flash_mem_byteenable(flash_mem_byteenable), .flash_mem_writedata());

// your code for the rest of this task here
  assign reset = ~KEY[3];
  assign rst_n = KEY[2];
  assign clk = CLOCK_50;
  assign read_s = 1'b0;
  assign flash_mem_byteenable = 4'b111;

  // STATE MACHINE
  always_ff @(posedge CLOCK_50, posedge reset) begin
	if (reset == 1'b1) begin
	  // flash memory
	  flash_mem_address <= 23'b0;
	  flash_mem_read <= 1'b0;
	  
	  // codex
          write_s <= 1'b0;

          state <= state_start;
	  hex5 = `R; hex4 = `E; hex3 = `S; hex2 = `E; hex1 = `T; hex0 = 7'b1111111;
	end

	else begin case(state)
	  state_start: begin  // start reading from flash memory
		flash_mem_read <= 1'b1;

		state <= wait_data_request;
	  end

	  wait_data_request: begin  // wait until waitrequest deasserted
		if(flash_mem_waitrequest == 1'b0) state <= wait_data_validate;
	  end

	  wait_data_validate: begin  // wait until datavalid asserted
		if(flash_mem_readdatavalid == 1'b1) begin
		  flash_mem_read <= 1'b0;
		  sample <= flash_mem_readdata;
		  state <= wait_codec1_ready;
		end
	  end


	  wait_codec1_ready: begin
		write_s <= 1'b0;

		if(write_ready == 1'b1) state <= wait_codec1_send;
	  end
		
	  wait_codec1_send: begin
		if(sample[15] == 1'b1) computed <= ~sample[15:0] + 16'b1;
		writedata_right <= { 6'b0, computed[15:6] };
		writedata_left <= { 6'b0, computed[15:6] };
		write_s <= 1'b1;

		state <= wait_codec1_accept;
	  end

	  wait_codec1_accept: begin
		if(write_ready == 1'b0) state <= wait_codec2_ready;
	  end

	  wait_codec2_ready: begin
		write_s <= 1'b0;

		if(write_ready == 1'b1) state <= wait_codec2_send;
	  end
		
	  wait_codec2_send: begin
		if(sample[31] == 1'b1) computed <= ~sample[31:16] + 16'b1;
		writedata_right <= { 6'b0, computed[15:6] } ;
		writedata_left <= { 6'b0, computed[15:6] };
		write_s <= 1'b1;
		
		state <= wait_codec2_accept;
	  end

	  wait_codec2_accept: begin
		if(write_ready == 1'b0) state <= compute_count;
	  end

	  compute_count: begin // 23'b1000000000000000000000
		if(flash_mem_address >= 23'b100000000000000000000) state <= state_done;
		else begin
		  flash_mem_address <= flash_mem_address + 23'b1;
		  state <= state_start;
		  hex5 = `A; hex4 = `U; hex3 = `D; hex2 = `I; hex1 = `O; hex0 = 7'b1111111;
		end
	  end

	  state_done: begin
		flash_mem_read <= 1'b0;
		flash_mem_address <= 23'b0;
		state <= state_start;
	  end

	  default: begin
	  end
	
	endcase
	end

  end

endmodule: music
