`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2020 10:02:21 AM
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
    input 	logic		clk, reset, 
	input	logic		memtoreg, regdst, iord, alusrca,
	input	logic [1:0] alusrcb, pcsrc,
	input	logic		irwrite, memwrite, regwrite, pcen, 
	input	logic [2:0] alucontrol, 
	input	logic [31:0]readdata, 
	output	logic		zero, 
	output	logic [31:0]addr, writedata, instr
);
    
    logic [31:0] pc, pcnext;
    logic [31:0] data;
    logic [31:0] rega, wd3, rd1, rd2;
    logic [4:0] writereg,ra1,ra2,wr1,wr2;
    logic [31:0] signimm, signimmsh;
    logic [31:0] srca, srcb, aluresult, aluout;
    
    assign {ra1,ra2} = instr[25:16];
    assign {wr1,wr2} = instr[20:11];
    
    //pre PC
    mux4#(32)       pcmux(.d0(aluresult), .d1(aluout), .d2({pc[31:28], instr[25:0], 2'b00}), .d3(32'hxxxx_xxxx), 
                               .s(pcsrc), .y(pcnext));
    
    //PC
    flopenr#(32)    pcreg(.clk(clk), .reset(reset), .en(pcen), .d(pcnext), .q(pc));
    
    //pre memory
    mux2#(32)       muxaddr(.d0(pc), .d1(aluout), .s(iord), .y(addr));
    
    //post memory
    flopenr#(32)    instrreg(.clk(clk), .reset(reset), .en(irwrite), .d(readdata), .q(instr));
    flopr#(32)      datareg(.clk(clk), .reset(reset), .d(readdata), .q(data));
    
    //pre regfile
    mux2#(5)        muxwa3(.d0(wr1), .d1(wr2), .s(regdst), .y(writereg));
    mux2#(32)       muxwd3(.d0(aluout), .d1(data), .s(memtoreg), .y(wd3));
    
    //regfile
    regfile         rf(.clk(clk), .we3(regwrite), .ra1(ra1), .ra2(ra2), 
                        .wa3(writereg), .wd3(wd3), .rd1(rd1), .rd2(rd2));
                        
    //post regfile              
    flopr#(32)      ra(.clk(clk), .reset(reset), .d(rd1), .q(rega));
    flopr#(32)      rb(.clk(clk), .reset(reset), .d(rd2), .q(writedata));
    
    //pre alu
    signext         se(.a(instr[15:0]),.y(signimm));
    sl2             immsh(.a(signimm), .y(signimmsh));
    
    mux2#(32)       srcamux(.d0(pc), .d1(rega), .s(alusrca), .y(srca));
    mux4#(32)       srcbmux(.d0(writedata), .d1(32'b100), .d2(signimm), .d3(signimmsh), 
                            .s(alusrcb), .y(srcb));
                            
    //alu 
    alu             alu(.a(srca), .b(srcb), .alucont(alucontrol), .result(aluresult), .zero(zero));
    
    //post alu
    flopr#(32)      alureg(.clk(clk), .reset(reset), .d(aluresult), .q(aluout));

endmodule
