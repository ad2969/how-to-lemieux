module task2(input logic CLOCK_50, input logic [3:0] KEY, // KEY[3] is async active-low reset
             input logic [9:0] SW, output logic [9:0] LEDR,
             output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
             output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5,
             output logic [7:0] VGA_R, output logic [7:0] VGA_G, output logic [7:0] VGA_B,
             output logic VGA_HS, output logic VGA_VS, output logic VGA_CLK);
  
  // instantiate and connect the VGA adapter and your module
  logic [9:0] VGA_R_10;
  logic [9:0] VGA_G_10;
  logic [9:0] VGA_B_10;
  logic VGA_BLANK, VGA_SYNC;

  assign VGA_R = VGA_R_10[9:2];
  assign VGA_G = VGA_G_10[9:2];
  assign VGA_B = VGA_B_10[9:2];

  reg w_start;
  wire w_done, w_plot;
  wire [7:0] w_vgax;
  wire [6:0] w_vgay;
  wire [2:0] w_colour;

  vga_adapter#(.RESOLUTION("160x120")) vga_u0(.resetn(KEY[3]), .clock(CLOCK_50), .colour(w_colour),
                                              .x(w_vgax), .y(w_vgay), .plot(w_plot),
                                              .VGA_R(VGA_R_10), .VGA_G(VGA_G_10), .VGA_B(VGA_B_10),
                                              .*);

  fillscreen fs(.clk(CLOCK_50), .rst_n(KEY[3]), .colour(SW[5:3]), // Ignore colour for task2
                .start(w_start), .done(w_done),
                .vga_x(w_vgax), .vga_y(w_vgay),
                .vga_colour(w_colour), .vga_plot(w_plot));

  // Combinational block for "start"
  always @(posedge w_done, posedge KEY[3]) begin
	w_start = !w_done && KEY[3];
  end

endmodule: task2

