module tb_vga_avalon();

// Your testbench goes here.
  `define NULL 0

  reg xclk, xrst, err;

  reg [3:0] xaddress;
  reg xread, xwrite;

  wire [31:0] xrd, xwd;
  reg [7:0] vga_x;
  reg [6:0] vga_y;
  reg [2:0] vga_colour;
  assign xwd = {16'b0, vga_colour, vga_x, 1'b0, vga_y};

  wire [7:0] vga_r, vga_g, vga_b;
  wire vga_hs, vga_vs, vga_clk;

  // module instantiation
    vga_avalon duta(.clk(xclk), .reset_n(xrst),
                  .address(xaddress),
                  .read(xread), .readdata(xrd),
                  .write(xwrite), .writedata(xwd),
                  .VGA_R(vga_r), .VGA_G(vga_g), .VGA_B(vga_b),
                  .VGA_HS(vga_hs), .VGA_VS(vga_vs), .VGA_CLK(vga_clk));

  // clock forever block
  initial begin
	xclk <= 1'b1; xrst = 1'b1; err = 2'b0;
	forever #2 xclk <= ~xclk;
  end

  // read txt file
  integer data_file; // file handler
  integer scan_file; // file handler
  integer data_counter;
  reg enable_plot;

  initial begin
	data_file = $fopen("../misc/pixels.txt", "r");
	if(data_file == `NULL) begin
	  $error("data_file handle was NULL. Could not read txt");
	  err = 1'b1;
	  $stop;
	end
	data_counter = 0;
	vga_colour = 3'b111;
	xaddress = 4'b0;
	enable_plot = 1'b1;
  end

  always @(posedge xclk) begin
  if(enable_plot) begin
	scan_file = $fscanf(data_file, "%d, %d\n", vga_x, vga_y);
	xwrite = 1'b1;
	if(!$feof(data_file)) begin
	  $display("Read: ", vga_x, ", ", vga_y);
	  data_counter <= data_counter + 1;
	end
	else begin
	  $display("Read: ", vga_x, ", ", vga_y);
	  $display("FINISHED READING TXT DATA FILE at ", $time, "ns");
	  xwrite = 1'b0;
	  enable_plot = 1'b0;
	end
  end
  end

  // asserting testbench
  initial begin
	if(enable_plot == 1'b1) begin #5000 $display("Waiting for plot"); end

	assert(duta.plot == 1'b1) begin end
	  else begin err = err + 2'b01; end

	#10000
	assert(duta.plot == 1'b0) begin end
	  else begin err = err + 2'b10; end
	
	if(err == 2'b00) begin $display("TEST 1 PASSED! Picture plotted!"); end
	else begin
	  if(err == 2'b01 || err == 2'b11) begin $error("vga_avalon did not start plotting"); end
	  if(err == 2'b10 || err == 2'b11) begin $error("vga_avalon dit not complete plotting"); end
	end

	if(err !== 2'b0) $error("** TEST(s) FAILED for 'vga_avalon.sv'");
	else $display("ALL TESTS PASSED! This marks the end of tests for 'vga_avalon.sv'.");

	$stop;
  end

endmodule: tb_vga_avalon
