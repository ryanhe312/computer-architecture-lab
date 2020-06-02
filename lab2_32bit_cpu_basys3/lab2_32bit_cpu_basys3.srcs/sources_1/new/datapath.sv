`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2020 09:15:10 AM
// Design Name: 
// Module Name: datapath
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


module datapath(
    input logic clk,reset,memtoreg,pcsrc,alusrc,regdst,regwrite,jump,
    input logic [2:0] alucontrol,
    input logic [31:0] instr,
    input logic [31:0] readdata,
    output logic zero,
    output logic [31:0] pc,aluout,writedata
);

    logic [4:0] writereg;
    logic [31:0] pcnext,pcnextbr,pcplus4,pcbranch,signimm,signimmsh,srca,srcb,result;

    //rext PC logic
    flopr#(32)  pcreg(.clk(clk),.reset(reset),.d(pcnext),.q(pc));
    adder       pcadd1(.a(pc),.b(32'b100),.y(pcplus4));
    sl2         immsh(.a(signimm),.y(signimmsh));
    adder       pcadd2(.a(pcplus4),.b(signimmsh),.y(pcbranch));
    mux2#(32)   pcbrmux(.d0(pcplus4),.d1(pcbranch),.s(pcsrc),.y(pcnextbr));
    mux2#(32)   pcmux(.d0(pcnextbr),.d1({pcplus4[31:28],instr[25:0],2'b00}),.s(jump),.y(pcnext));
    
    //register file logic 
    regfile     rf(.clk(clk),.we3(regwrite),.ra1(instr[25:21]),.ra2(instr[20:16]),.wa3(writereg),.wd3(result),.rd1(srca),.rd2(writedata));
    mux2#(5)    wrmux(.d0(instr[20:16]),.d1(instr[15:11]),.s(regdst),.y(writereg));
    mux2#(32)   resmux(.d0(aluout),.d1(readdata),.s(memtoreg),.y(result));
    signext     se(.a(instr[15:0]),.y(signimm));
    
    //ALU logic
    mux2#(32)   srcbmux(.d0(writedata),.d1(signimm),.s(alusrc),.y(srcb));
    alu         alu(.a(srca),.b(srcb),.alucont(alucontrol),.result(aluout),.zero(zero));

endmodule
