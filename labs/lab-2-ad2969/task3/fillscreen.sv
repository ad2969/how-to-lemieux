module fillscreen(input logic clk, input logic rst_n, input logic [2:0] colour,
                  input logic start, output logic done,
                  output logic [7:0] vga_x, output logic [6:0] vga_y,
                  output logic [2:0] vga_colour, output logic vga_plot);
   // fill the screen

  integer i;
  reg [7:0] xaxis;
  reg [6:0] yaxis;
  reg plot, plot_done;

  reg begin_plot;

  assign vga_x = xaxis;
  assign vga_y = yaxis;
  assign vga_colour = colour;
  assign vga_plot = plot;
  assign done = plot_done;

  // sequential block that prints everything on every clock cycle
  always @(posedge clk) begin
	if(!rst_n) begin
	  xaxis = 8'b0;
	  yaxis = 7'b0;
	  plot = 1'b0;
	  plot_done = 1'b0;

	  begin_plot = 1'b0;
	end
	else if(start) begin
	casex({begin_plot, xaxis, yaxis})
	  // End
	  16'b1100111111110111: begin
		plot_done = 1'b1;
		plot = 1'b0;
	  end
	  16'b1xxxxxxxx1110111: begin
		xaxis += 8'b1;
		yaxis = 7'b0;
	  end
	  16'b0xxxxxxxxxxxxxxx: begin
		begin_plot = 1'b1;
		plot = 1'b1;	// allow plot of x = 0, y = 0
	  end
	  default: begin
		yaxis += 8'b1;
	  end
	endcase
	end
  end
    
endmodule

