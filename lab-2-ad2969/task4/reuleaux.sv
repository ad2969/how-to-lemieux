module reuleaux(input logic clk, input logic rst_n, input logic [2:0] colour,
                input logic [7:0] centre_x, input logic [6:0] centre_y, input logic [7:0] diameter,
                input logic start, output logic done,
                output logic [7:0] vga_x, output logic [6:0] vga_y,
                output logic [2:0] vga_colour, output logic vga_plot);
     // draw the Reuleaux triangle

   integer i;
   reg [7:0] bounds;

   reg [7:0] centre1_x, centre2_x, centre3_x;
   reg [6:0] centre1_y, centre2_y, centre3_y;

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
    	  centre1_x = centre_x;
    	  centre1_y = centre_y - {1'b0, diameter[6:1]};
    	  centre2_x = centre_x - {1'b0, diameter[7:1]};
    	  centre2_y = centre_y + {1'b0, diameter[6:1]};
    	  centre3_x = centre_x + {1'b0, diameter[7:1]};
    	  centre3_y = centre_y + {1'b0, diameter[6:1]};

 	  xaxis = centre_x;
 	  yaxis = centre_y;
 	  plot = 1'b0;
 	  plot_done = 1'b0;
 	  offset_y = 7'b0;
 	  offset_x = diameter;
 	  crit = 8'b1 - diameter;
	  bounds = diameter >> 3;

 	  counter = 3'b0;
 	  counter_done = 1'b0;
 	end
 	else if(start) begin
 	casex({counter, counter_done})
 	  // End
 	  4'b1011: begin
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
 	  4'b0000: begin // octant 2 bottom
 		xaxis = centre1_x + {1'b0, offset_y};
 		yaxis = centre1_y + offset_x[6:0];
 		counter += 3'b1;
 		if(xaxis <= centre3_x && xaxis >= centre2_x && yaxis <= centre2_y && yaxis >= centre1_y) plot = 1'b1;
 		else plot = 1'b0;
 	  end
 	  4'b0010: begin // octant 3 bottom
 		xaxis = centre1_x - {1'b0, offset_y};
 		yaxis = centre1_y + offset_x[6:0];
 		counter += 3'b1;
 		if(xaxis <= centre3_x && xaxis >= centre2_x && yaxis <= centre2_y && yaxis >= centre1_y) plot = 1'b1;
 		else plot = 1'b0;
 	  end
 	  4'b0100: begin // octant 5 right
 		xaxis = centre3_x - offset_x;
 		yaxis = centre3_y - offset_y;
 		counter += 3'b1;
 		if(xaxis <= centre3_x && xaxis >= centre2_x && yaxis <= (centre2_y - bounds[6:0]) && yaxis >= (centre1_y + bounds[6:0])) plot = 1'b1;
 		else plot = 1'b0;
 	  end
 	  4'b0110: begin // octant 6 right
 		xaxis = centre3_x - {1'b0, offset_y};
 		yaxis = centre3_y - offset_x[6:0];
 		counter += 3'b1;
 		if(xaxis <= centre3_x && xaxis >= centre2_x && yaxis <= (centre2_y - bounds[6:0]) && yaxis >= (centre1_y + bounds[6:0])) plot = 1'b1;
 		else plot = 1'b0;
 	  end
 	  4'b1000: begin // octant 7 left
 		xaxis = centre2_x + offset_x;
 		yaxis = centre2_y - offset_y;
 		counter += 3'b1;
 		if(xaxis <= centre3_x && xaxis >= centre2_x && yaxis <= (centre2_y - bounds[6:0]) && yaxis >= (centre1_y + bounds[6:0])) plot = 1'b1;
 		else plot = 1'b0;
 	  end
 	  4'b1010: begin // octant 8 left
 		xaxis = centre2_x + {1'b0, offset_y};
 		yaxis = centre2_y - offset_x[6:0];
 		counter_done = 1'b1;
 		if(xaxis <= centre3_x && xaxis >= centre2_x && yaxis <= (centre2_y - bounds[6:0]) && yaxis >= (centre1_y + bounds[6:0])) plot = 1'b1;
 		else plot = 1'b0;
 	  end
 	  default: begin plot = 1'b0; plot_done = 1'b0; end
 	endcase
 	end
   end

endmodule
