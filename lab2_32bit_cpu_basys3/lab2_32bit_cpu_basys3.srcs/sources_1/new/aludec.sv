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


module aludec(
    input logic [5:0] funct,
    input logic [1:0] aluop,
    output logic [2:0] alucontrol
);

    always_comb
        case(aluop)
            2'b00:  alucontrol <= 3'b010;//add (for lw/sw/addi)
            2'b01:  alucontrol <= 3'b110;//sub (for beq)
            default: case(funct)
                6'b100000:  alucontrol <= 3'b010;//add
                6'b100010:  alucontrol <= 3'b110;//sub
                6'b100100:  alucontrol <= 3'b000;//and
                6'b100101:  alucontrol <= 3'b001;//or
                6'b101010:  alucontrol <= 3'b111;//slt
                default:    alucontrol <= 3'bxxx;//???
            endcase
        endcase

endmodule
