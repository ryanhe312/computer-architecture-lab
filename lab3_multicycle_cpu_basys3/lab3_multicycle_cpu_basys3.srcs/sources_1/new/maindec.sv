`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2020 10:05:10 AM
// Design Name: 
// Module Name: maindec
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


module maindec(
    input   logic       clk, reset,
    input   logic [5:0] op,
    output  logic       pcwrite, memwrite, irwrite, regwrite,
    output  logic       alusrca, branch, iord, memtoreg, regdst, 
    output  logic [1:0] alusrcb, pcsrc,
    output  logic [2:0] aluop,
    output  logic       immext
    );
    
    //States
    parameter FETCH     = 4'b0000;
    parameter DECODE    = 4'b0001;
    parameter MEMADR    = 4'b0010;
    parameter MEMRD     = 4'b0011;
    parameter MEMWB     = 4'b0100;
	parameter MEMWR	  = 4'b0101;
	parameter RTYPEEX 	  = 4'b0110;
	parameter RTYPEWB	  = 4'b0111;
	parameter BEQEX	  = 4'b1000;
	parameter ADDIEX	  = 4'b1001;
	parameter ADDIWB	  = 4'b1010;
	parameter JEX		  = 4'b1011;
	parameter ANDIEX	  = 4'b1100;
	parameter ORIEX	  = 4'b1101;
	parameter SLTIEX	  = 4'b1110;
	parameter BNEEX	  = 4'b1111;
	
	//op code
	parameter LW	    = 6'b100011;
	parameter SW	    = 6'b101011;
	parameter RTYPE	= 6'b000000;
	parameter BEQ   	= 6'b000100;
	parameter ADDI 	= 6'b001000;
	parameter J		= 6'b000010;
	parameter ANDI    	= 6'b001100;
	parameter ORI     	= 6'b001101;
	parameter SLTI     = 6'b001010;
	parameter BNE    	= 6'b001101;
	
	logic [3:0] state, nextstate;
	logic [16:0] controls;
	
	always_ff @(posedge clk, posedge reset)
	if(reset) state <= FETCH;
	else state <= nextstate;
	
	always_comb
	case(state)
		FETCH:		nextstate = DECODE;
		DECODE:  case(op)
					LW:		nextstate = MEMADR;
					SW:		nextstate = MEMADR;
					RTYPE:	nextstate = RTYPEEX;
					BEQ:	nextstate = BEQEX;
					ADDI:	nextstate = ADDIEX;
					J:		nextstate = JEX;
					ANDI:	nextstate = ANDIEX;
					ORI:	nextstate = ORIEX;
					SLTI:	nextstate = SLTIEX;
					BNE:	nextstate = BNEEX;
					default:nextstate = 4'bx;
				 endcase
		MEMADR:  case(op)
                    LW:		nextstate = MEMRD;
                    SW:		nextstate = MEMWR;
                    default:nextstate = 4'bx;
			     endcase
		MEMRD:		nextstate = MEMWB;
		MEMWB:		nextstate = FETCH;
		MEMWR:		nextstate = FETCH;
		RTYPEEX:	nextstate = RTYPEWB;
		RTYPEWB:	nextstate = FETCH;
		BEQEX:		nextstate = FETCH;
		ADDIEX:		nextstate = ADDIWB;
		ADDIWB:		nextstate = FETCH;
		JEX:		nextstate = FETCH;
		ANDIEX:		nextstate = ADDIWB;
		ORIEX:		nextstate = ADDIWB;
		SLTIEX:		nextstate = ADDIWB;
		BNEEX:		nextstate = FETCH;
		default:	nextstate = 4'bx;
	endcase
	
	assign {aluop[2],immext,pcwrite, memwrite, irwrite, regwrite, alusrca, branch,
			iord, memtoreg, regdst, alusrcb, pcsrc, aluop[1:0]} = controls;
	
	always_comb
	case(state)
		FETCH:	controls = 17'h05010;
		DECODE:	controls = 17'h00030;
		MEMADR:	controls = 17'h00420;
		MEMRD:	controls = 17'h00100;
		MEMWB:	controls = 17'h00880;
		MEMWR:	controls = 17'h02100;
		RTYPEEX:controls = 17'h00402;
		RTYPEWB:controls = 17'h00840;
		BEQEX:	controls = 17'h00605;
		ADDIEX:	controls = 17'h00420;
		ADDIWB:	controls = 17'h00800;
		JEX:	controls = 17'h04008;
		ANDIEX:	controls = 17'h18420;
		ORIEX:	controls = 17'h18421;
		SLTIEX:	controls = 17'h08423;
		BNEEX:	controls = 17'h00405;
		default:controls = 17'hxxxxx;
	endcase
    
endmodule
