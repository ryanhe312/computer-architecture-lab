`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2020 10:27:45 AM
// Design Name: 
// Module Name: regfile
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


module regfile(
    input logic clk,
    input logic we3,//写使能
    input logic [4:0] ra1,ra2,wa3,//读地址1，读地址2，写地址
    input logic [31:0] wd3,//写数据
    output logic [31:0] rd1,rd2//读数据
);

    logic [31:0] rf [31:0];
    always_ff@(posedge clk)
        if(we3) rf[wa3] <= wd3;
       
    assign rd1 = (ra1!=0)?rf[ra1]:0;
    assign rd2 = (ra2!=0)?rf[ra2]:0;
    
endmodule
