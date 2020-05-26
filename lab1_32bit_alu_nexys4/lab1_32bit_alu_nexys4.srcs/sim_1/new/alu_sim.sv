`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2020 09:12:22 AM
// Design Name: 
// Module Name: alu_sim
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


module alu_sim();
    logic [31:0]    a,b;
    logic [2:0]     alucont;
    logic [31:0]    result;
    logic           zero;
    
    alu ALU(.a(a),.b(b),.alucont(alucont),.result(result),.zero(zero));
    
    initial begin
        #0 alucont = 3'b010;
            #0 a = 32'h00000000;b = 32'h00000000;
            #10 a = 32'h00000000;b = 32'hFFFFFFFF;
            #10 a = 32'h00000001; b = 32'hFFFFFFFF;
            #10 a = 32'h000000FF;b = 32'h00000001;
        #10 alucont = 3'b110;
            #0 a = 32'h00000000;b = 32'h00000000;
            #10 a = 32'h00000000; b = 32'hFFFFFFFF;
            #10 a = 32'h00000001;b = 32'h00000001;
            #10 a = 32'h00000100;b = 32'h00000001;
        #10 alucont = 3'b111;
            #0 a = 32'h00000000; b = 32'h00000000;
            #10 a = 32'h00000000; b = 32'h00000001;
            #10 a = 32'h00000000; b = 32'hFFFFFFFF;
            #10 a = 32'h00000001; b = 32'h00000000;
            #10 a = 32'hFFFFFFFF; b = 32'h00000000;
        #10 alucont = 3'b000;
            #0 a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
            #10 a = 32'hFFFFFFFF; b = 32'h12345678;
            #10 a = 32'h12345678; b = 32'h87654321;
            #10 a = 32'h00000000; b = 32'hFFFFFFFF;
       #10 alucont = 3'b001;     
            #0 a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
            #10 a = 32'h12345678; b = 32'h87654321;
            #10 a = 32'h00000000; b = 32'hFFFFFFFF;
            #10 a = 32'h00000000; b = 32'h00000000;
       #10 alucont = 3'b000;
            #0 a = 32'hFFFFFFFF; b = 32'hFFFFFFFF;
    end
      
    
endmodule
