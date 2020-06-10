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
    output  logic [1:0] alusrcb, pcsrc,aluop
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
	
	//op code
	parameter LW	    = 6'b100011;
	parameter SW	    = 6'b101011;
	parameter RTYPE	= 6'b000000;
	parameter BEQ   	= 6'b000100;
	parameter ADDI 	= 6'b001000;
	parameter J		= 6'b000010;
	
	logic [3:0] state, nextstate;
	logic [14:0] controls;
	
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
		default:	nextstate = 4'bx;
	endcase
	
	assign {pcwrite, memwrite, irwrite, regwrite, alusrca, branch,
			iord, memtoreg, regdst, alusrcb, pcsrc, aluop} = controls;
	
	always_comb
	case(state)
		FETCH:	controls = 15'h5010;
		DECODE:	controls = 15'h0030;
		MEMADR:	controls = 15'h0420;
		MEMRD:	controls = 15'h0100;
		MEMWB:	controls = 15'h0880;
		MEMWR:	controls = 15'h2100;
		RTYPEEX:controls = 15'h0402;
		RTYPEWB:controls = 15'h0840;
		BEQEX:	controls = 15'h0605;
		ADDIEX:	controls = 15'h0420;
		ADDIWB:	controls = 15'h0800;
		JEX:	controls = 15'h4008;
		default:controls = 15'hxxxx;
	endcase
    
endmodule
