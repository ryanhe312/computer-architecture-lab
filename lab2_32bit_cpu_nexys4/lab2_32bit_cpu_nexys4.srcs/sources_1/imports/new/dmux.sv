`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2020 10:02:30 AM
// Design Name: 
// Module Name: dmux
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


module dmux #(parameter WIDTH = 8)(
    input   logic [WIDTH-1:0]   data,
    input   logic s,
    output  logic [WIDTH-1:0]   y0, y1
    );
    
    assign y0 = (s == 0) ? data : 0;
    assign y1 = (s == 1) ? data : 0;
    
endmodule

