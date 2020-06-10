`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2020 11:13:56 AM
// Design Name: 
// Module Name: alu_top
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


module board_top(
    input logic [15:0] sw,
    input logic clk,
    input logic btnU,//display
    input logic btnD,//reset
    output logic [6:0] seg,
    output logic [3:0] an,
    output logic dp
);

    logic [15:0] a = {8'b0,sw[15:8]};
    logic [15:0] b = {8'b0,sw[7 :0]};
    logic [31:0] writedata, readdata, dataadr, result;
    logic memwrite;

    mips mips(.clk(clk), .reset(btnD), .memwrite(memwrite), 
                    .dataadr(dataadr), .writedata(writedata), .readdata(readdata));
    fakeimem imem(.adr(dataadr),.a(a),.b(b),.rd(readdata));
    fakedmem dmem(.clk(clk), .we(memwrite), .a(dataadr), .wd(writedata),.result(result)); 
    
    logic [15:0] x;
    logic [9:0] a_BCD;
    logic [9:0] b_BCD;
    logic [9:0] r_BCD;
    
    Bin2BCD8bit A2BCD(a[7 :0]       ,a_BCD);
    Bin2BCD8bit B2BCD(b[7 :0]       ,b_BCD);
    Bin2BCD8bit R2BCD(result[7:0]   ,r_BCD);
    
    always_comb
    begin
        case(btnU)
            1'b0:x={a_BCD[7:0],b_BCD[7:0]};
            1'b1:x={6'b0,      r_BCD[9:0]};
        endcase
    end
    
    x7seg X7(.x(x), .clk(clk), .clr(btnD),.a2g(seg), .an(an), .dp(dp));
endmodule
