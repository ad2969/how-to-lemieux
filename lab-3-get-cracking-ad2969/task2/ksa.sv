module ksa(input logic clk, input logic rst_n,
           input logic en, output logic rdy,
           input logic [23:0] key,
           output logic [7:0] addr, input logic [7:0] rddata, output logic [7:0] wrdata, output logic wren);

  reg ready;
  reg [7:0] write_data;
  reg write_enable;

  reg [3:0] state;
  reg [7:0] i, j;

  reg [7:0] read_data, temp_data;
  reg [7:0] address;

  assign rdy = ready;
  assign wrdata = write_data;
  assign wren = write_enable;

  // address mux
  assign addr = address;

  // your code here
  always @(posedge clk) begin
	if (en) begin
	  state <= 4'b0001;
	  i = 8'b0; j = 8'b0;
	  ready = 1'b0;

	  write_data = 8'b0;
	  write_enable = 1'b0;

	  temp_data = 8'b0;
	  read_data = 8'b0;
	end
	else begin
	case(state)
	  4'b0000: begin	// wait state
	  	i = 8'b0; j = 8'b0;
		ready = 1'b1;

	  	write_data = 8'b0;
	  	write_enable = 1'b0;

	  	temp_data = 8'b0;
  	  	address = 8'b0;

		state <= 4'b0000;
	  end
	  4'b0001: begin	// read s[i] into read_data
	  	write_enable <= 1'b0;
		address <= i;

		state <= 4'b0010;
	  end
	  4'b0010: begin	// end reading s[i]
		state <= 4'b0011;
	  end
	  4'b0011: begin	// begin calculation
		read_data = rddata;
		case(i % 2'd3)
		8'b0: begin j = (j + read_data + key[23:16]); end
		8'b1: begin j = (j + read_data + key[15:8]);  end
		8'b10: begin j = (j + read_data + key[7:0]); end
		endcase
		temp_data = read_data;	// temp_data = s[i] in read_data
		address <= j;
		state <= 4'b0100;
	  end
	  4'b0100: begin	// read s[j] into read_data
		state <= 4'b0101;
	  end
	  4'b0101: begin	// s[i] = s[j] in read_data
		read_data = rddata;
		write_enable <= 1'b1;
		write_data <= read_data;
		address <= i;

		state <= 4'b0110;
	  end
	  4'b0110: begin	// s[j] = temp_data
		write_enable <= 1'b1;
		write_data <= temp_data;
		address <= j;

		state <= 4'b1010;
	  end
	  4'b1010: begin	// i++
		write_enable <= 1'b0;
		if(i < 8'b11111111) begin
		  state = 4'b0001; // loop if i <= 255
		  i = i + 8'b1;
		end
		else state = 4'b0000; // end if i > 255
	  end
	  default: begin
		state = 4'b0000;
	  	i = 8'b0; j = 8'b0;
		ready = 1'b1;

	  	write_data = 8'b0;
	  	write_enable = 1'b0;

	  	temp_data = 8'b0;
	  end
	endcase
	end
  end

endmodule: ksa
