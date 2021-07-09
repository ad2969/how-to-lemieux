module circle(input logic clk, input logic rst_n, input logic [2:0] colour,
              input logic [7:0] centre_x, input logic [6:0] centre_y, input logic [7:0] radius,
              input logic start, output logic done,
              output logic [7:0] vga_x, output logic [6:0] vga_y,
              output logic [2:0] vga_colour, output logic vga_plot);
    // draw the circle

  integer i;
  reg [6:0] offset_y;
  reg [7:0] offset_x;
  reg signed [7:0] crit;
  reg [2:0] counter;
  reg counter_done;

  reg [7:0] xaxis;
  reg [6:0] yaxis;
  reg plot, plot_done;

  assign vga_x = xaxis;
  assign vga_y = yaxis;
  assign vga_colour = colour;
  assign vga_plot = plot;
  assign done = plot_done;

  // sequential block that prints everything on every clock cycle
  always @(posedge clk) begin
	if(!rst_n) begin
	  xaxis = centre_x;
	  yaxis = centre_y;
	  plot = 1'b0;
	  plot_done = 1'b0;
	  offset_y = 7'b0;
	  offset_x = radius;
	  crit = 8'b1 - radius;
	
	  counter = 3'b0;
	  counter_done = 1'b0;
	end
	else if(start) begin
	casex({counter, counter_done})
	  // End
	  4'b1111: begin
		counter = 3'b0;
		offset_y += 7'b1;

		if(crit <= 0) begin
		  crit = crit + {offset_y, 1'b0} + 8'b1;
		end
		else begin
		  offset_x -= 8'b1;
		  crit = crit + (({1'b0, offset_y} - offset_x) << 1) + 8'b1;
		end
		if(offset_y <= offset_x) counter_done = 1'b0; //resets
	  end
	  4'b0001: begin
		plot = 1'b0;
		plot_done = 1'b1;
	  end
	  4'b0000: begin // octant 1
		xaxis = centre_x + offset_x;
		yaxis = centre_y + offset_y;
		counter += 3'b1;
		if(xaxis <= 8'b10011111 && xaxis >= 8'b0 && yaxis <= 7'b1110111 && yaxis >= 7'b0) plot = 1'b1;
		else plot = 1'b0;
	  end
	  4'b0010: begin // octant 2
		xaxis = centre_x + {1'b0, offset_y};
		yaxis = centre_y + offset_x[6:0];
		counter += 3'b1;
		if(xaxis <= 8'b10011111 && xaxis >= 8'b0 && yaxis <= 7'b1110111 && yaxis >= 7'b0) plot = 1'b1;
		else plot = 1'b0;
	  end
	  4'b0100: begin // octant 4
		xaxis = centre_x - offset_x;
		yaxis = centre_y + offset_y;
		counter += 3'b1;
		if(xaxis <= 8'b10011111 && xaxis >= 8'b0 && yaxis <= 7'b1110111 && yaxis >= 7'b0) plot = 1'b1;
		else plot = 1'b0;
	  end
	  4'b0110: begin // octant 3
		xaxis = centre_x - {1'b0, offset_y};
		yaxis = centre_y + offset_x[6:0];
		counter += 3'b1;
		if(xaxis <= 8'b10011111 && xaxis >= 8'b0 && yaxis <= 7'b1110111 && yaxis >= 7'b0) plot = 1'b1;
		else plot = 1'b0;
	  end
	  4'b1000: begin // octant 5
		xaxis = centre_x - offset_x;
		yaxis = centre_y - offset_y;
		counter += 3'b1;
		if(xaxis <= 8'b10011111 && xaxis >= 8'b0 && yaxis <= 7'b1110111 && yaxis >= 7'b0) plot = 1'b1;
		else plot = 1'b0;
	  end
	  4'b1010: begin // octant 6
		xaxis = centre_x - {1'b0, offset_y};
		yaxis = centre_y - offset_x[6:0];
		counter += 3'b1;
		if(xaxis <= 8'b10011111 && xaxis >= 8'b0 && yaxis <= 7'b1110111 && yaxis >= 7'b0) plot = 1'b1;
		else plot = 1'b0;
	  end
	  4'b1100: begin // octant 7
		xaxis = centre_x + offset_x;
		yaxis = centre_y - offset_y;
		counter += 3'b1;
		if(xaxis <= 8'b10011111 && xaxis >= 8'b0 && yaxis <= 7'b1110111 && yaxis >= 7'b0) plot = 1'b1;
		else plot = 1'b0;
	  end
	  4'b1110: begin // octant 8
		xaxis = centre_x + {1'b0, offset_y};
		yaxis = centre_y - offset_x[6:0];
		counter_done = 1'b1;
		if(xaxis <= 8'b10011111 && xaxis >= 8'b0 && yaxis <= 7'b1110111 && yaxis >= 7'b0) plot = 1'b1;
		else plot = 1'b0;
	  end
	  default: begin plot = 1'b0; plot_done = 1'b0; end
	endcase
	end
  end

endmodule

