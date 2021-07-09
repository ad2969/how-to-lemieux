module arc4(input logic clk, input logic rst_n,
            input logic en, output logic rdy,
            input logic [23:0] key,
            output logic [7:0] ct_addr, input logic [7:0] ct_rddata,
            output logic [7:0] pt_addr, input logic [7:0] pt_rddata, output logic [7:0] pt_wrdata, output logic pt_wren);

    // your code here
  reg ready;
  assign rdy = ready;
  
  wire [7:0] s_addr, s_wrdata, s_output;
  wire s_wren, i_wren, k_wren;

  reg assert_init, assert_ksa, assert_prga;
  wire init_ready, init_enable, ksa_ready, ksa_enable, prga_ready, prga_enable;

  // states for init and ksa
  reg [3:0] state;
  wire [7:0] i_address, k_address, p_address;
  wire [7:0] i_wrdata, k_wrdata, p_wrdata;

  // module instantiations

    s_mem s(.address(s_addr),
	    .clock(clk),
	    .data(s_wrdata),
	    .wren(s_wren),
	    .q(s_output));

    init i(.clk(clk), .rst_n(rst_n),
           .en(init_enable), .rdy(init_ready),
           .addr(i_address), .wrdata(i_wrdata), .wren(i_wren));

    ksa k(.clk(clk), .rst_n(rst_n),
          .en(ksa_enable), .rdy(ksa_ready),
          .key(key),
          .addr(k_address), .rddata(s_output), .wrdata(k_wrdata), .wren(k_wren));

    prga p(.clk(clk), .rst_n(rst_n),
	   .en(prga_enable), .rdy(prga_ready),
	   .key(key),
	   .s_addr(p_address), .s_rddata(s_output), .s_wrdata(p_wrdata), .s_wren(p_wren),
	   .ct_addr(ct_addr), .ct_rddata(ct_rddata),
	   .pt_addr(pt_addr), .pt_rddata(pt_rddata), .pt_wrdata(pt_wrdata), .pt_wren(pt_wren));

  assign init_enable = assert_init && init_ready;
  assign ksa_enable = assert_ksa && ksa_ready;
  assign prga_enable = assert_prga && prga_ready;

  // prevent ddress and data from being driven by two modules init and ksa
  assign s_addr = state >= 4'b0110 ? p_address : (state >= 4'b0011 ? k_address : i_address);
  assign s_wrdata = state >= 4'b0110 ? p_wrdata : (state >= 4'b0011 ? k_wrdata : i_wrdata);
  assign s_wren = state >= 4'b0110 ? p_wren : (state >= 4'b0011 ? k_wren : i_wren);

  always @(posedge clk) begin
	// if reset is asserted (init has to be ready)
	if(en) begin
	  assert_init = 1'b1; state = 4'b0001; ready = 1'b0;
	end
	else begin
	  case (state)
		4'b0001: begin
		  ready = 1'b0;
		  assert_init = 1'b0; assert_ksa = 1'b0; state = 4'b0010;
		end
		4'b0010: begin
		  if(init_ready) state = 4'b0011;
		end
		4'b0011: begin
		  assert_ksa = 1'b1; state = 4'b0100;
		end
		4'b0100: begin
		  assert_ksa = 1'b0; state = 4'b0101;		
		end
		4'b0101: begin
		  if(ksa_ready == 1'b1) state = 4'b0110;
		end
		4'b0110: begin
		  assert_prga = 1'b1; state = 4'b0111;
		end
		4'b0111: begin
		  assert_prga = 1'b0; state = 4'b1000;
		end
		4'b1000: begin
		  if(prga_ready == 1'b1) state = 4'b0000;
		end
	 	default: begin
		  assert_init = 1'b0; assert_ksa = 1'b0; assert_prga = 1'b0;
		  ready = 1'b1; state = 3'b000;
		end
	  endcase
	end
  end


endmodule: arc4
