module task4(input logic CLOCK_50, input logic [3:0] KEY, // KEY[3] is async active-low reset
             input logic [9:0] SW, output logic [9:0] LEDR,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [7:0] VGA_R, output logic [7:0] VGA_G, output logic [7:0] VGA_B,
             output logic VGA_HS, output logic VGA_VS, output logic VGA_CLK);

    // instantiate and connect the VGA adapter and your module
  // instantiate and connect the VGA adapter and your module
  logic [9:0] VGA_R_10;
  logic [9:0] VGA_G_10;
  logic [9:0] VGA_B_10;
  logic VGA_BLANK, VGA_SYNC;

  assign VGA_R = VGA_R_10[9:2];
  assign VGA_G = VGA_G_10[9:2];
  assign VGA_B = VGA_B_10[9:2];

  reg w_start;
  reg w_blackstart;
  reg beginstates;

  wire w_done, w_blackdone;
  wire w_plot, wb_plot, wc_plot;
  wire [7:0] w_vgax, wb_vgax, wc_vgax;
  wire [6:0] w_vgay, wb_vgay, wc_vgay;
  wire [2:0] w_colour, black, green;

  reg selector;

  assign w_vgax = (selector) ? wc_vgax : wb_vgax;
  assign w_vgay = (selector) ? wc_vgay : wb_vgay;
  assign w_colour = (selector) ? green : black;
  assign w_plot = (selector) ? wc_plot : wb_plot;

  vga_adapter#(.RESOLUTION("160x120")) vga_u0(.resetn(KEY[3]), .clock(CLOCK_50), .colour(w_colour),
                                              .x(w_vgax), .y(w_vgay), .plot(w_plot),
                                              .VGA_R(VGA_R_10), .VGA_G(VGA_G_10), .VGA_B(VGA_B_10),
                                              .*);

  reuleaux r(.clk(CLOCK_50), .rst_n(KEY[3]), .colour(3'b010), // green
	     .centre_x(8'b01010000), .centre_y(7'b0111100), .diameter(8'b00101000),
             .start(w_start), .done(w_done),
             .vga_x(wc_vgax), .vga_y(wc_vgay),
             .vga_colour(green), .vga_plot(wc_plot));

  fillscreen fs(.clk(CLOCK_50), .rst_n(KEY[3]), .colour(3'b000), // black
                .start(w_blackstart), .done(w_blackdone),
                .vga_x(wb_vgax), .vga_y(wb_vgay),
                .vga_colour(black), .vga_plot(wb_plot));

  always @(posedge CLOCK_50) begin
	if(!KEY[3]) begin
	  beginstates = 1'b1;
	  w_start = 1'b0;
	  w_blackstart = 1'b0;
	  selector = 1'b0;
	end
	case({w_blackdone, w_done})
	  2'b00: begin // clear black
		if(beginstates == 1'b1) begin
		w_blackstart = 1'b1;
		end
		selector = 1'b0;
	  end
	  2'b10: begin // done black
		if(beginstates == 1'b1) begin
		w_blackstart = 1'b0;
		w_start = 1'b1;
		selector = 1'b1;
		end
	  end
	  2'b11: begin // done all
		if(beginstates == 1'b1) begin
		w_start = 1'b0;
		beginstates = 1'b0;
		selector = 1'b1;
		end
	  end
	  default: begin end
	endcase

  end
endmodule: task4
