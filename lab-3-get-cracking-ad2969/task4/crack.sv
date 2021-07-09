module crack(input logic clk, input logic rst_n,
             input logic en, output logic rdy,
             output logic [23:0] key, output logic key_valid,
             output logic [7:0] ct_addr, input logic [7:0] ct_rddata);

    // your code here

  // wires and regs
  wire [7:0] pt_address, pt_wrdata, pt_rddata;
  wire pt_wren;

  reg [23:0] ar_key, key_output;
  reg ar_enable;
  reg key_output_valid, ready;

  assign key = key_output;
  assign key_valid = key_output_valid;
  assign rdy = ready;

  reg [2:0] state;

    // this memory must have the length-prefixed plaintext if key_valid
    pt_mem pt(.address(pt_address),
	      .clock(clk),
	      .data(pt_wrdata),
	      .wren(pt_wren),
	      .q(pt_rddata));

    arc4 a4(.clk(clk), .rst_n(rst_n),
	    .en(ar_enable), .rdy(ar_ready),
	    .key(ar_key),
	    .ct_addr(ct_addr), .ct_rddata(ct_rddata),
	    .pt_addr(pt_address), .pt_rddata(pt_rddata), .pt_wrdata(pt_wrdata), .pt_wren(pt_wren));

    // your code here

  always @(posedge clk) begin
    if(en) begin
	ready = 1'b0;
	ar_key = 24'b0; ar_enable = 1'b1;
	key_output = 24'b0; key_output_valid = 1'b0;

	state <= 3'b001;
    end
    else begin case(state)

	3'b001: begin	// delay
	  ar_enable <= 1'b0;
	  state <= 3'b010;
	end

	3'b010: begin	// wait for pt stage in arc4
	  if(a4.prga_ready == 1'b0) state <= 3'b011;
	end

	3'b011: begin
	  if(ar_ready) begin state <= 3'b101; end	// means that this is the key// means its not the key
	end

	3'b100: begin	// iterate next key
	  ar_enable <= 1'b1;
	  if(ar_key <= 24'hFFFFFF) begin
		ar_key = ar_key + 24'b1;
		state <= 3'b001;
	  end
	  else begin	// if run out of iterations
		state <= 3'b000;
	  end
	end


	3'b101: begin	// key found
	  key_output = ar_key;
	  key_output_valid = 1'b1;

	  state <= 3'b000;
	end

	default: begin	// wait state
	  ready = 1'b1;
	  ar_key = 24'b0; ar_enable = 1'b0;

	  state <= 3'b000;
	end

    endcase end
  end

endmodule: crack