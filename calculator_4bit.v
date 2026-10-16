`timescale 1ns / 1ps

module calculator_4bit (
    input [3:0] A,      // 4-bit vector input A
    input [3:0] B,      // 4-bit vector input B
    input op,           // 0 = Add, 1 = Subtract
    output [3:0] Sum,   // 4-bit result vector
    output C_out        // Carry-out / Borrow flag
);

    wire [3:0] B_mux;   // Holds inverted or non-inverted B bits
    wire c1, c2, c3;    // Internal wires to ripple the carry bit

    // XOR gates acting as a controlled inverter for 2's complement
    xor ctrl0 (B_mux[0], B[0], op);
    xor ctrl1 (B_mux[1], B[1], op);
    xor ctrl2 (B_mux[2], B[2], op);
    xor ctrl3 (B_mux[3], B[3], op);

    // Chaining four 1-bit full adders hierarchically
    // We pass 'op' directly into the first carry-in to add the +1 for subtraction
    full_adder fa0 (.a(A[0]), .b(B_mux[0]), .c_in(op), .sum(Sum[0]), .c_out(c1));
    full_adder fa1 (.a(A[1]), .b(B_mux[1]), .c_in(c1), .sum(Sum[1]), .c_out(c2));
    full_adder fa2 (.a(A[2]), .b(B_mux[2]), .c_in(c2), .sum(Sum[2]), .c_out(c3));
    full_adder fa3 (.a(A[3]), .b(B_mux[3]), .c_in(c3), .sum(Sum[3]), .c_out(C_out));

endmodule
