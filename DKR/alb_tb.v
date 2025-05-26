`timescale 1ns / 1ps

module alb_tb;

    // Inputs and Outputs
    reg clk;
    reg reset;
    reg [3:0] R_in, S_in;
    reg CI;
    reg [1:0] I;
    wire [3:0] F_ALB;
    wire CO, VO, NO, ZO;

    // Reference model outputs
    wire [3:0] ref_F_ALB;
    wire ref_CO, ref_VO, ref_NO, ref_ZO;

    // Instantiate ALB
    alb uut (
        .clk(clk),
        .reset(reset),
        .R_in(R_in),
        .S_in(S_in),
        .CI(CI),
        .I(I),
        .F_ALB(F_ALB),
        .CO(CO),
        .VO(VO),
        .NO(NO),
        .ZO(ZO)
    );

    // Instantiate Reference Model
    reference_model ref_model (
        .R(R_in),
        .S(S_in),
        .CI(CI),
        .I(I),
        .ref_F_ALB(ref_F_ALB),
        .ref_CO(ref_CO),
        .ref_VO(ref_VO),
        .ref_NO(ref_NO),
        .ref_ZO(ref_ZO)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Task for checking result
    task run_test(
        input [3:0] R,
        input [3:0] S,
        input CI_in,
        input [1:0] instr,
        input [255:0] label
    );
    begin
        R_in = R;
        S_in = S;
        CI = CI_in;
        I = instr;

        #12;  // Wait some time

        $display("\n--- %s ---", label);
        $display("Inputs: R=%b, S=%b, CI=%b, I=%b", R, S, CI_in, instr);
        $display("ALB Output:  F=%b  CO=%b  VO=%b  NO=%b  ZO=%b", F_ALB, CO, VO, NO, ZO);
        $display("REF Output:  F=%b  CO=%b  VO=%b  NO=%b  ZO=%b", ref_F_ALB, ref_CO, ref_VO, ref_NO, ref_ZO);

        if (F_ALB !== ref_F_ALB || CO !== ref_CO || VO !== ref_VO || NO !== ref_NO || ZO !== ref_ZO) begin
            $display("? ERROR: Outputs do not match.");
            if (F_ALB !== ref_F_ALB) $display("   ? F_ALB mismatch: got %b, expected %b", F_ALB, ref_F_ALB);
            if (CO !== ref_CO)       $display("   ? CO mismatch: got %b, expected %b", CO, ref_CO);
            if (VO !== ref_VO)       $display("   ? VO mismatch: got %b, expected %b", VO, ref_VO);
            if (NO !== ref_NO)       $display("   ? NO mismatch: got %b, expected %b", NO, ref_NO);
            if (ZO !== ref_ZO)       $display("   ? ZO mismatch: got %b, expected %b", ZO, ref_ZO);
        end else begin
            $display("? PASS: Outputs match.");
        end
    end
    endtask

    // Main Test Sequence
    initial begin
        // Reset
        reset = 1;
        R_in = 0;
        S_in = 0;
        CI = 0;
        I = 0;
        #10;
        reset = 0;

        // === TEST CASES ===

        run_test(4'b1010, 4'b0101, 1'b0, 2'b00, "Test 1: OR (R ? S)");
        run_test(4'b0110, 4'b0011, 1'b1, 2'b01, "Test 2: ADD (R + S + CI)");
        run_test(4'b1100, 4'b1010, 1'b0, 2'b10, "Test 3: AND-NOT (¬R & S)");
        run_test(4'b1001, 4'b0011, 1'b1, 2'b11, "Test 4: SUB (R - S - 1 + CI)");
        run_test(4'b0001, 4'b0001, 1'b0, 2'b11, "Test 5: SUB with Zero Result");
        run_test(4'b0111, 4'b0111, 1'b1, 2'b01, "Test 6: ADD with Overflow");

        $display("\nSimulation finished.");
        $finish;
    end

endmodule
