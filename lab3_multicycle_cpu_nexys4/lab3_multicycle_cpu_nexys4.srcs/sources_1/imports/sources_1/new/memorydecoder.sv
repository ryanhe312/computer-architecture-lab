`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2020 08:32:55 AM
// Design Name: 
// Module Name: memorydecoder
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


module memorydecoder(
	input	logic		clk, writeEN,
    input    logic [31:0]addr, writeData, 
    output    logic [31:0]readData, 
            
    input    logic IOclock, 
    input    logic reset, 
    input    logic btnL, btnR,
    input    logic [15:0] switch, 
    output    logic [7:0] AN,
    output    logic DP, 
    output    logic [6:0] A2G
);

    logic pRead, pWrite, mWrite;
	logic [11:0] led;
	logic [31:0] pReadData, memReadData;
	
	assign pRead = addr[7];
	assign pWrite = addr[7] & writeEN;
	assign mWrite = writeEN & (addr[7] == 0);
	

	dmem iomem(.clk(clk), .we(writeEN), .a(addr), .wd(writeData), .rd(memReadData));

	IO io(.clk(IOclock), .reset(reset), .pRead(pRead), .pWrite(pWrite), 
			.addr(addr[3:2]), .pWriteData(writeData), .pReadData(pReadData),
			.buttonL(btnL), .buttonR(btnR), .switch(switch), .led(led));
			

    mux2#(32)   readmux(.d0(memReadData), .d1(pReadData), .s(addr[7]), .y(readData));


    logic [31:0] x;
    logic [9:0] a_BCD;
    logic [9:0] b_BCD;
    logic [9:0] r_BCD;
    
    Bin2BCD8bit A2BCD(switch[15:8]       ,a_BCD);
    Bin2BCD8bit B2BCD(switch[7:0]       ,b_BCD);
    Bin2BCD8bit R2BCD(led[7:0]   ,r_BCD);

    assign x={a_BCD[7:0],b_BCD[7:0],6'b0, r_BCD[9:0]};

    x7seg X7(.x(x), .clk(clk), .clr(reset),.a2g(A2G), .an(AN), .dp(DP));
    
endmodule
