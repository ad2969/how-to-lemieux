module vga_avalon(input logic clk, input logic reset_n,
                  input logic [3:0] address,
                  input logic read, output logic [31:0] readdata,
                  input logic write, input logic [31:0] writedata,
                  output logic [7:0] VGA_R, output logic [7:0] VGA_G, output logic [7:0] VGA_B,
                  output logic VGA_HS, output logic VGA_VS, output logic VGA_CLK);
    
    // your Avalon slave implementation goes here

  wire [9:0] vga_red, vga_green, vga_blue;
  wire [7:0] wd_x;
  wire [6:0] wd_y;
  wire [2:0] wd_colour;
  reg plot;

  assign wd_colour = writedata[18:16];
  assign wd_x = writedata[15:8];
  assign wd_y = writedata[7:0];

  assign VGA_R = vga_red[7:0];
  assign VGA_G = vga_green[7:0];
  assign VGA_B = vga_blue[7:0];

  // adapter instantiation
    vga_adapter #(.RESOLUTION("160x120")) vga( .resetn(reset_n), .clock(clk), .colour(wd_colour),
					       .x(wd_x), .y(wd_y), .plot(plot),
					       .VGA_R(vga_red), .VGA_G(vga_green), .VGA_B(vga_blue),
					       .VGA_HS(VGA_HS), .VGA_VS(VGA_VS),
					       .VGA_CLK(VGA_CLK) );

    // NOTE: We will ignore the SYNC and BLANK signals.
    //       Either don't connect them or connect them to dangling wires.
    //       In addition, the VGA_{R,G,B} should be the low 8 bits of the VGA module outputs.

  always @(posedge clk) begin
	if(address == 4'b0 && write) begin
	  if(wd_x < 8'd160 && wd_y < 7'd120) begin plot = 1'b1; end
	  else begin plot = 1'b0; end
	end
	else begin plot = 1'b0; end
  end

endmodule: vga_avalon