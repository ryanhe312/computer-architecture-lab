`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2020 09:07:29 AM
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
    input logic [5:0] op,funct,
    input logic zero,
    output logic [2:0] alucontrol,
    output logic memtoreg,memwrite,jump,pcsrc,alusrc,regdst,regwrite
);

    logic [1:0] aluop;
    logic branch;
    
    maindec md(.op(op),.memtoreg(memtoreg),.memwrite(memwrite),.branch(branch),
               .alusrc(alusrc),.regdst(regdst),.regwrite(regwrite),.jump(jump),.aluop(aluop));
    aludec ad(.funct(funct),.aluop(aluop),.alucontrol(alucontrol));
    
    assign pcsrc = branch & zero; 

endmodule
