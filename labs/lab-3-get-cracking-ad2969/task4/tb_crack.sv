`timescale 1ps / 1ps
module tb_crack();

  parameter repetitions = 3000;
  parameter clk_delay = 1;
  reg err;

  reg xclk, xrst, xen;
  wire xrdy, xkey_valid;
  wire [23:0] xkey;

// Your testbench goes here.

  wire [7:0] ct_address, ct_rddata;

  // Module Instantiation

  crack dut(.clk(xclk), .rst_n(xrst),
            .en(xen), .rdy(xrdy),
            .key(xkey), .key_valid(xkey_valid),
            .ct_addr(ct_address), .ct_rddata(ct_rddata));

  xct_mem dutct(.clk(clk), .address(ct_address),
		.rddata(ct_rddata));

  // testbench
  initial begin
	xclk = 1'b0;
	repeat (repetitions) begin
	  #clk_delay xclk = 1'b1;
	  #clk_delay xclk = 1'b0;
	end
  end

  initial begin
	xrst = 1'b1; xen = 1'b0; err = 1'b0; #9
	$readmemh("test1.memh", dutct.memory);
	$display("ct_mem is", 	dutct.memory[0], dutct.memory[1], dutct.memory[2],
				dutct.memory[3], dutct.memory[4], dutct.memory[5],
				dutct.memory[6], dutct.memory[7], dutct.memory[8],
				dutct.memory[9], dutct.memory[10], dutct.memory[11] );

	xen = 1'b1; #2 xen = 1'b0;
  end

endmodule: tb_crack

module xct_mem(input clk, input [7:0] address,
	       output [7:0] rddata);

  reg [7:0] data_out;
  reg [7:0] memory [0:255];
  assign rddata = data_out;

  always @(posedge clk) begin
	data_out <= memory[address];
  end

endmodule: xct_mem