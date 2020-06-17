`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2020 09:53:44 AM
// Design Name: 
// Module Name: boardtest
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

module boardtest();

    logic [15:0] sw;
    logic clk;
    logic btnU;//display
    logic btnC;//clear
    logic btnL;//load 
    logic btnR;//write
    logic [6:0] seg;
    logic [3:0] an;
    logic dp;
    
    //instantiate device to be tested
    board_top top(clk, btnC, btnL, btnR, btnU, sw,an, dp,seg);
    
    assign sw = 16'b00001100_00100010;
    
    
    //initialize test
    initial
    begin
        btnC <= 1; btnU <= 0; #22; btnC <= 0; 
        #20 btnL <=1; #10 btnL <=0; 
        #20 btnR <=1; #10 btnR <=0; 
    end
        
    //generate clock to sequence tests
    always
    begin
        clk <= 1; #5; clk <= 0; #5; 
    end

endmodule
