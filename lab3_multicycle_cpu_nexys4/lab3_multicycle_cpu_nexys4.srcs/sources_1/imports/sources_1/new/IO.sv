`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2020 08:48:46 AM
// Design Name: 
// Module Name: IO
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


module IO(
    //connect with MIPS CPU
    input   logic       clk,
    input   logic       reset,
    input   logic       pRead,
    input   logic       pWrite,
    input   logic [1:0] addr,
    input   logic [31:0]pWriteData,
    output  logic [31:0]pReadData,
    //connect with Device
    input   logic       buttonL,    //LED
    input   logic       buttonR,    //Switch
    input   logic [15:0]switch,
    output  logic [11:0]led
    );
    
    logic [1:0] status = 2'b00;
    logic [31:0] switch1 = 0;
    logic [11:0] led1 = 0;
    
    always_ff @( posedge clk )
    begin
        if(reset)
        begin
            status 	<= 2'b00;
            led1 	<= 12'h00;
            switch1 <= 16'h00;
        end
        else
        begin
            //SW is ready
            if(buttonR)
            begin
                status[1] 	<= 1;
                switch1 	<= switch;
            end
            //LED is ready
            if(buttonL)
            begin
                status[0] 	<= 1;
                led 		<= led1;
            end
            
			//output
            if(pWrite & (addr == 2'b01))
            begin
				led1 		<= pWriteData[11:0];
				status[0] 	<= 0;
            end
			//read data
			//11：数据输入端口（高）
			//10：数据输入端口（低）
			//01：数据输出端口（LED）
			//00：状态端口
			if(pRead)
			begin
				case(addr)
					2'b11:	pReadData <= {24'b0, switch1[15:8]};
					2'b10:	pReadData <= {24'b0, switch1[7:0]};
					2'b00:	pReadData <= {30'b0, status};
					default:pReadData <= 32'b0;
				endcase
			end
        end
    end
    
endmodule
