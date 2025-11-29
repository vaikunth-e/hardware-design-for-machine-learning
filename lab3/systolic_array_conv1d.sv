`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2025 07:34:55 PM
// Design Name: 
// Module Name: systolic_array_conv1d
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module systolic_array_conv1d #(parameter int N = 3)(
    input logic signed [7:0] x_in,
    input logic signed [7:0] w [N],
    input logic signed [7:0] y_in,
    input logic clk,
    output logic signed [7:0] y_out
    );
    
    logic signed [7:0] x_bus [N+1];
    logic signed [7:0] y_bus [N+1];
    
    genvar i;
    generate
        for (i = 0; i < N; i++) begin: SL
            unit_slice u (
                .clk(clk),
                .x_in (x_bus[i+1]),
                .x_out(x_bus[i]),
                .w    (w[i]),
                .y_in (y_bus[i]),
                .y_out(y_bus[i+1])
             );
        end
    endgenerate
    
    assign x_bus[N] = x_in;
    assign y_bus[0] = y_in;
    assign y_out = y_bus[N];
endmodule
