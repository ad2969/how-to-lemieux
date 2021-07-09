module tb_mult();

// Your testbench goes here.
  reg [31:0] xdataa, xdatab;
  wire [31:0] xresult;
  reg err;

  mult dutc(.dataa(xdataa), .datab(xdatab), .result(xresult));

  initial begin
    err = 1'b0; xdataa = 32'd0; xdatab = 32'd1;
    #20 assert(xresult == 32'd0) begin end
      else begin $error(" 0 x 1 is not equal 0"); err = 1'b1; end

    #5 xdataa = 32'd1; xdatab = 32'd1;
    #20 assert(xresult == 32'd1) begin end
      else begin $error(" 1 x 1 is not equal 1"); err = 1'b1; end

    #5 xdataa = 32'd2; xdatab = 32'd2;
    #20 assert(xresult == 32'd4) begin end
      else begin $error(" 2 x 2 is not equal 4"); err = 1'b1; end

    #5 xdataa = 32'd100; xdatab = 32'd5;
    #20 assert(xresult == 32'd500) begin end
      else begin $error(" 100 x 5 is not equal 500"); err = 1'b1; end

    #5 xdataa = 32'd2147483648; xdatab = 32'd2;
    #20 assert(xresult == 32'b0) begin end
      else begin $error(" overflow is not equal 0"); err = 1'b1; end

    if(err == 1'b1) $error("** TEST(s) FAILED for 'mult.sv'");
    else $display("ALL TESTS PASSED! This marks the end of tests for 'mult.sv'.");
  end

endmodule: tb_mult
