module init(input logic clk, input logic rst_n,
            input logic en, output logic rdy,
            output logic [7:0] addr, output logic [7:0] wrdata, output logic wren);

  reg ready;
  reg [7:0] write_address;
  reg [7:0] write_data;
  reg write_enable;

  assign rdy = ready;
  assign addr = write_address;
  assign wrdata = write_data;
  assign wren = write_enable;

// your code here
  always @(posedge clk) begin
	if (en) begin
	  ready = 1'b0;
	  write_address = 8'b0;
	  write_data = 8'b0;
	  write_enable = 1'b1;
	end
	else if (!ready) begin
	  if (write_address == 8'b11111111) begin
		ready = 1'b1;
		write_enable = 1'b0;
	  end
	  else begin
		write_address = write_address + 8'b1;
		write_data = write_address;
	  end
	end
	else begin
	  ready = 1'b1;
	  write_address = 8'b0;
	  write_data = 8'b0;
	  write_enable = 1'b0;
	end
  end

endmodule: init