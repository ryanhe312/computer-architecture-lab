`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2020 10:04:27 AM
// Design Name: 
// Module Name: controller
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


module controller(
	input logic clk,reset,
	input logic [5:0] op,funct,
	input logic zero,
	output logic iord,memwrite,irwrite,
	output logic regdst,memtoreg,regwrite,
	output logic alusrca,
	output logic [1:0] alusrcb,
	output logic [2:0] alucontrol,
	output logic [1:0] pcsrc,
	output logic pcen
);

	logic [1:0]	aluop;
	logic branch, pcwrite;
	
	maindec		md(.clk(clk), .reset(reset), .op(op), .pcwrite(pcwrite), 
					.memwrite(memwrite), .irwrite(irwrite), .regwrite(regwrite), 
					.alusrca(alusrca), .branch(branch), .iord(iord), .memtoreg(memtoreg), 
					.regdst(regdst), .alusrcb(alusrcb), .pcsrc(pcsrc), .aluop(aluop));
	aludec		ad(.funct(funct), .aluop(aluop), .alucontrol(alucontrol));
	
	assign pcen = (branch & zero) | pcwrite;

endmodule
