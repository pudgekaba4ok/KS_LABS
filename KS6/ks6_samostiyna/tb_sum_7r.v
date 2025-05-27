module tb_sum_7r;
  wire C1, C2;
  wire [6:0] Ain, Bin;
  reg  [6:0] Ain_r, Bin_r;
  reg        Ci_r;
  wire [6:0] res_my, res_ref;

  sum_7r     myblock  (Ain, Bin, Ci_r, res_my, C1);
  ref_sum_7r refblock (Ain, Bin, Ci_r, res_ref, C2);

  initial begin
    $display("\tTime\tAin\t  Bin\t  Ci\tres_my\t Cl\tres_ref\tC2");
    $monitor("%t\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
              $time, Ain, Bin, Ci_r, res_my, C1, res_ref, C2);
    #1000 $finish;
  end
  initial begin
    Ain_r = 7'd0; Bin_r = 7'd0; Ci_r = 0; #50;
    Ain_r = 7'd5; Bin_r = 7'd10; Ci_r = 0; #50;
    Ain_r = 7'd5; Bin_r = 7'd10; Ci_r = 1; #50;
    Ain_r = 7'd127; Bin_r = 7'd0; Ci_r = 0; #50;
    Ain_r = 7'd127; Bin_r = 7'd1; Ci_r = 0; #50;
    Ain_r = 7'd127; Bin_r = 7'd127; Ci_r = 0; #50;
    Ain_r = 7'd100; Bin_r = 7'd27; Ci_r = 1; #50;
    Ain_r = 7'b1010101; Bin_r = 7'b0101010; Ci_r = 0; #50;
    Ain_r = 7'd0; Bin_r = 7'd0; Ci_r = 1; #50;
    Ain_r = 7'd45; Bin_r = 7'd37; Ci_r = 1; #50;
  end

  assign Ain = Ain_r;
  assign Bin = Bin_r;
endmodule
