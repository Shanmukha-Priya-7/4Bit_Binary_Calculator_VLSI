`timescale 1ns / 1ps

module full_adder (
    input a,
    input b,
    input c_in,
    output sum,
    output c_out
);
    wire w1, w2, w3;

    // Structural gates mapping your Boolean math
    xor g1 (w1, a, b);
    xor g2 (sum, w1, c_in);

    and g3 (w2, a, b);
    and g4 (w3, c_in, w1);
    or  g5 (c_out, w2, w3);
endmodule
