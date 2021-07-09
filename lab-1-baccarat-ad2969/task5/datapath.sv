module datapath(input slow_clock, input fast_clock, input resetb,
                input load_pcard1, input load_pcard2, input load_pcard3,
                input load_dcard1, input load_dcard2, input load_dcard3,
                output [3:0] pcard3_out,
                output [3:0] pscore_out, output [3:0] dscore_out,
                output[6:0] HEX5, output[6:0] HEX4, output[6:0] HEX3,
                output[6:0] HEX2, output[6:0] HEX1, output[6:0] HEX0);
						
// The code describing your datapath will go here.  Your datapath 
// will hierarchically instantiate six card7seg blocks, two scorehand
// blocks, and a dealcard block.  The registers may either be instatiated
// or included as sequential always blocks directly in this file.
//
// Follow the block diagram in the Lab 1 handout closely as you write this code.

  // Declare wires
  wire [3:0] new_card;
  wire [3:0] pcard1_w, pcard2_w, pcard3_w;
  wire [3:0] dcard1_w, dcard2_w, dcard3_w;

  // Assignment statements
  assign pcard3_out = pcard3_w;

  // Instantiate Modules
  dealcard dc(fast_clock, resetb, new_card);

  reg4 #(4) pcard1(resetb, slow_clock, load_pcard1, new_card, pcard1_w);
  reg4 #(4) pcard2(resetb, slow_clock, load_pcard2, new_card, pcard2_w);
  reg4 #(4) pcard3(resetb, slow_clock, load_pcard3, new_card, pcard3_w);

  card7seg p7seg1(pcard1_w, HEX0);
  card7seg p7seg2(pcard2_w, HEX1);
  card7seg p7seg3(pcard3_w, HEX2);

  scorehand psh(pcard1_w, pcard2_w, pcard3_w, pscore_out);

  reg4 #(4) dcard1(resetb, slow_clock, load_dcard1, new_card, dcard1_w);
  reg4 #(4) dcard2(resetb, slow_clock, load_dcard2, new_card, dcard2_w);
  reg4 #(4) dcard3(resetb, slow_clock, load_dcard3, new_card, dcard3_w);

  card7seg d7seg1(dcard1_w, HEX3);
  card7seg d7seg2(dcard2_w, HEX4);
  card7seg d7seg3(dcard3_w, HEX5);

  scorehand dsh(dcard1_w, dcard2_w, dcard3_w, dscore_out);

endmodule

