`timescale 1ns / 1ps

module tb_calculator;
    // Emulated registers to drive inputs
    reg [3:0] A;
    reg [3:0] B;
    reg op;

    // Monitor wires to read outputs
    wire [3:0] Sum;
    wire C_out;

    // Instantiate the Unit Under Test (UUT)
    calculator_4bit uut (
        .A(A), 
        .B(B), 
        .op(op), 
        .Sum(Sum), 
        .C_out(C_out)
    );

    initial begin
        // --- TEST 1: ADDITION (op = 0) ---
        op = 0; A = 4'b0010; B = 4'b0011; // 2 + 3 = 5 (Expected: Sum = 0101, C_out = 0)
        #10; // Wait 10 nanoseconds
        
        A = 4'b0111; B = 4'b0101; // 7 + 5 = 12 (Expected: Sum = 1100, C_out = 0)
        #10;

        // --- TEST 2: SUBTRACTION (op = 1) ---
        op = 1; A = 4'b1000; B = 4'b0011; // 8 - 3 = 5 (Expected: Sum = 0101, C_out = 1)
        #10;

        A = 4'b0101; B = 4'b0101; // 5 - 5 = 0 (Expected: Sum = 0000, C_out = 1)
        #10;
        
        $finish; // End the simulation
    end
endmodule
