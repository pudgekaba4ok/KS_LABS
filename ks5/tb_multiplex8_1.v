`timescale 1ns / 1ps

module tb_multiplex8_1;

reg [7:0] D;
reg [2:0] S;
reg EN;

wire Y;

multiplex8_1 uut (
    .D(D),
    .S(S),
    .EN(EN),
    .Y(Y)
);

initial begin
    $display("Time\tEN\tS\tD\t\tY");
    $monitor("%0dns\t%b\t%03b\t%b\t\t%b", $time, EN, S, D, Y);

    
    D = 8'b10101010; 

    // ???? 1: EN = 0 (????????), ??????????? ??? ???????? S
    EN = 0;
    S = 3'b000; #10;
    S = 3'b001; #10;
    S = 3'b010; #10;
    S = 3'b011; #10;
    S = 3'b100; #10;
    S = 3'b101; #10;
    S = 3'b110; #10;
    

    // ???? 2: EN = 1 (??????????), ????? ??????? ???? Z
    EN = 1;
    S = 3'b000; #10;
    S = 3'b101; #10;
    //Test 3 EN = 0 (????????)
    EN=0;
    S = 3'b111; #10;

    $stop; 
end

endmodule
