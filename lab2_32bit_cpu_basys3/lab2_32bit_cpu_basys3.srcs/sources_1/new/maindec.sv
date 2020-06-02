`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2020 10:45:30 AM
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
    input logic [5:0] op,
    output logic memtoreg,memwrite,
    output logic branch,alusrc,bne,//new bne signal
    output logic regdst,regwrite,
    output logic jump,immext,//new immext
    output logic [2:0] aluop//new op digit for imm
);

    logic [11:0] controls;
    
    assign {regwrite,regdst,alusrc,branch,
            bne,memwrite,memtoreg,jump,
            aluop,immext} = controls;
    
    always_comb
        case(op)
            6'b000000:  controls <= 12'b1100_0000_0100;//RTYPE
            6'b100011:  controls <= 12'b1010_0010_0000;//LW
            6'b101011:  controls <= 12'b0010_0100_0000;//SW
            6'b000100:  controls <= 12'b0001_0000_0010;//BEQ
            6'b000101:  controls <= 12'b0001_1000_0010;//BNE
            6'b001000:  controls <= 12'b1010_0000_0000;//ADDI
            6'b001100:  controls <= 12'b1010_0000_1001;//ANDI
            6'b001101:  controls <= 12'b1010_0000_1011;//ORI
            6'b001010:  controls <= 12'b1010_0000_1110;//SLTI
            6'b000010:  controls <= 12'b0000_0001_0000;//J
            default:    controls <= 12'bxxxx_xxxx_xxxx;//illegal op
        endcase
        

endmodule
