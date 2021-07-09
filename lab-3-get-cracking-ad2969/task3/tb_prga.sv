module tb_prga();

  parameter repetitions = 3000;
  parameter clk_delay = 1;
  reg err;

// Your testbench goes here.
  reg [9:0] switch;

  reg xclk, xrst, xen;
  wire xrdy;

  // inputs
  reg [7:0] xs_rddata, xct_rddata, xpt_rddata;
  // outputs
  wire [7:0] xs_addr, xct_addr, xpt_addr;
  wire [7:0] xs_wrdata, xpt_wrdata;
  wire xs_wren, xpt_wren;

  prga dutp(.clk(xclk), .rst_n(xrst),
            .en(xen), .rdy(xrdy),
	    .key({14'b0, switch}),
            .s_addr(xs_addr), .s_rddata(xs_rddata), .s_wrdata(xs_wrdata), .s_wren(xs_wren),
            .ct_addr(xct_addr), .ct_rddata(xct_rddata),
            .pt_addr(xpt_addr), .pt_rddata(xpt_rddata), .pt_wrdata(xpt_wrdata), .pt_wren(xpt_wren));

  xpt_mem dutpt(.clk(xclk), .address(xpt_addr),
	        .wren(xpt_wren), .wrdata(xpt_wrdata),
	        .rddata(xpt_rddata));

  xct_mem dutct(.clk(xclk), .address(xct_addr),
	        .rddata(xct_rddata));

  initial begin
	xclk = 1'b0;
	repeat (repetitions) begin
	  #clk_delay xclk = 1'b1;
	  #clk_delay xclk = 1'b0;
	end
  end

  initial begin
	switch = 10'h1E4600;
	xrst = 1'b1; xen = 1'b0; err = 1'b0; #5
  	xs_rddata = 8'b0;
	$readmemh("test1.memh", dutct.memory);

	$display("ct_mem is", dutct.memory[0], dutct.memory[1], dutct.memory[2], dutct.memory[3]);
	
	assert(xrdy == 1'b1) begin end
	  else begin $error("Ready signals not high at the start"); err = 1'b1; end
	assert(xs_wren == 1'b0 && xpt_wren == 1'b0) begin end
	  else begin $error("Write signals not low at the start"); err = 1'b1; end
	assert(xs_wrdata == 8'b0 && xpt_wrdata == 8'b0) begin end
	  else begin $error("Write datas not zero at the start"); err = 1'b1; end
	
	assert(dutp.j == 8'b0 && dutp.i == 8'b0) begin end
	  else begin $error("i and j are not zero at the start"); err = 1'b1; end

	if(err == 1'b0) begin $display("TEST 1 PASSED! Initial wires are correct!"); end

	xen = 1'b1; #2 xen = 1'b0; #2

	$display("k is currently ", dutp.k);
	#40 $display("k is currently ", dutp.k);
	#960 $display("k is currently ", dutp.k);
	#4500 assert(xrdy == 1'b1) begin end
		else begin $error("Ready signal not raised at the end!"); err = 1'b1; end

	if(err == 1'b0) begin $display("TEST 2 PASSED! PRGA Completed and ready!"); end

	if(err == 1'b1) $error("** TEST(s) FAILED for 'prga.sv'");
	  else $display("ALL TESTS PASSED! This marks the end of tests for 'prga.sv'.");

  end

endmodule: tb_prga

module xpt_mem(input clk, input [7:0] address,
	      input wren, input [7:0] wrdata,
	      output [7:0] rddata);

  reg [7:0] data_out;
  reg [7:0] memory [0:255];
  assign rddata = data_out;

  always @(posedge clk) begin
	if(wren == 1'b1) begin
	  memory[address] <= wrdata;
	end
	else begin
	  data_out <= memory[address];
	end
  end

endmodule: xpt_mem

module xct_mem(input clk, input [7:0] address,
	      output [7:0] rddata);

  reg [7:0] data_out;
  reg [7:0] memory [0:255];
  assign rddata = data_out;

  always @(posedge clk) begin
	data_out <= memory[address];
  end

endmodule: xct_mem