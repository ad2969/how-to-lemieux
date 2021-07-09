module prga(input logic clk, input logic rst_n,
            input logic en, output logic rdy,
            input logic [23:0] key,
            output logic [7:0] s_addr, input logic [7:0] s_rddata, output logic [7:0] s_wrdata, output logic s_wren,
            output logic [7:0] ct_addr, input logic [7:0] ct_rddata,
            output logic [7:0] pt_addr, input logic [7:0] pt_rddata, output logic [7:0] pt_wrdata, output logic pt_wren);

    // your code here

  // output variables
  reg ready;
  reg s_write_enable, p_write_enable;
  reg [7:0] s_address, address;
  reg [7:0] s_write_data, p_write_data;

  // compute variables
  reg [3:0] state;
  reg [7:0] i, j, k;
  reg [7:0] message_length;

  reg [7:0] s_idata, s_jdata, pad;

  // output assignments
  assign rdy = ready;

  assign s_addr = s_address;
  assign ct_addr = address;
  assign pt_addr = address;

  assign s_wren = s_write_enable;
  assign s_wrdata = s_write_data;
  assign pt_wren = p_write_enable;
  assign pt_wrdata = p_write_data;

  // your code here
  always @(posedge clk) begin
	if (en) begin
	  i = 8'b0; j = 8'b0; k = 8'b0;
	  ready = 1'b0;
	  s_idata = 8'b0; s_jdata = 8'b0; pad = 8'b0;
	  message_length = 8'b0;

	  address = 8'b0; s_address = 8'b0;
	  s_write_data = 8'b0; p_write_data = 8'b0;
	  s_write_enable = 1'b0; p_write_enable = 1'b0;

	  state <= 4'b1101;
	end
	else begin
	case(state)
	  4'b0000: begin	// wait state
	  	i = 8'b0; j = 8'b0; k = 8'b0;
	  	ready = 1'b1;
	  	s_idata = 8'b0; s_jdata = 8'b0; pad = 8'b0;
	  	message_length = 8'b0;

	  	address = 8'b0; s_address = 8'b0;
	  	s_write_data = 8'b0; p_write_data = 8'b0;
	  	s_write_enable = 1'b0; p_write_enable = 1'b0;

		state <= 4'b0000;
	  end
	
	// BEGIN PSEUDO-RANDOM GENERATION ALGORITHM
	  4'b0001: begin	// increment i (i++), read s[i]
		i = i + 8'b1;
		s_write_enable = 1'b0; p_write_enable = 1'b0;
	  	s_address <= i; address <= k;

		state <= 4'b0010;
	  end
	  4'b0010: begin	// wait to read s[i]
		state <= 4'b0011;
	  end
	  4'b0011: begin	// compute j, read s[j]
		s_idata = s_rddata;
		j = j + s_idata;

	  	s_address <= j;
		s_write_enable = 1'b0;

		state <= 4'b0100;
	  end
	  4'b0100: begin	// wait to read s[j]
		state <= 4'b0101;
	  end
	  4'b0101: begin	// swap s[i] and s[j], write s[j] first
		s_jdata = s_rddata;

		s_address <= j;
		s_write_enable <= 1'b1;
		s_write_data <= s_idata;

		state <= 4'b0110;
	  end
	  4'b0110: begin	// swap s[i] and s[j], write s[i]
		s_address <= i;
		s_write_enable <= 1'b1;
		s_write_data <= s_jdata;

		state <= 4'b0111;
	  end
	  4'b0111: begin	// read s[s[i] + s[j]]
	  	s_address <= s_idata + s_jdata;
		s_write_enable <= 1'b0;

		state <= 4'b1000;
	  end
	  4'b1000: begin	// wait to read s[j]
		state <= 4'b1001;
	  end
	  4'b1001: begin	// assign pad, XOR, write to plaintext
		pad = s_rddata;
		p_write_data = ct_rddata ^ pad;
		p_write_enable <= 1'b1;

		state <= 4'b1010;
	  end
	  4'b1010: begin	// k++
		p_write_enable <= 1'b0;
		if(k < message_length) begin
		  state = 4'b0001; // loop if k <= length
		  k = k + 8'b1;
		end
		else state = 4'b0000; // end if i > 255
	  end

	// READ INITIAL MESSAGE_LENGTH

	  4'b1100: begin	// read length at c[0]
		s_address <= 8'b0; address <= 8'b0;
		s_write_enable <= 1'b0;
		
		state <= 4'b1101;
	  end
	  4'b1101: begin	// wait to read c[0]
		state <= 4'b1110;
	  end
	  4'b1110: begin	// save message_length into plaintext
		message_length = ct_rddata;

		p_write_data <= message_length;
		p_write_enable <= 1'b1;

		state <= 4'b1111;
	  end
	  4'b1111: begin
		p_write_enable <= 1'b0; k <= 8'b1;
		state <= 4'b0001;
	  end

	// DEFAULT (WAIT STATE)
	  default: begin
	  	i = 8'b0; j = 8'b0; k = 8'b0;
	  	ready = 1'b1;
	  	s_idata = 8'b0; s_jdata = 8'b0; pad = 8'b0;
	  	message_length = 8'b0;

	  	address = 8'b0; s_address = 8'b0;
	  	s_write_data = 8'b0; p_write_data = 8'b0;
	  	s_write_enable = 1'b0; p_write_enable = 1'b0;

		state <= 4'b0000;
	  end
	endcase
	end
  end

endmodule: prga
