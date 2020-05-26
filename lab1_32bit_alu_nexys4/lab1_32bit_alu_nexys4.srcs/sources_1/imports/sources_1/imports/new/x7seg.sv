module x7seg(
    input  logic [31:0] x,
    input  logic        clk,
    input  logic        clr,
    output logic [6:0] a2g,
    output logic [7:0] an, //�����ʹ��
    output logic       dp ); // С����
    
    logic [2:0] s;   // ѡ���ĸ������
    logic [3:0] digit;
    logic [19:0] clkdiv;
  
    assign dp = 1;           // DP off
    assign s = clkdiv[19:17];// count every 10.4ms        
    
    //4������� 4ѡ1 (mux44)
    always_comb
      case(s)
        0: digit = x[3:0];
        1: digit = x[7:4];
        2: digit = x[11:8];
        3: digit = x[15:12];
        4: digit = x[19:16];
        5: digit = x[23:20];
        6: digit = x[27:24];
        7: digit = x[31:28];
        default: digit = x[3:0];
      endcase
    
    // 8������� ʹ�� (ancode)
    always_comb
      case(s)
        0: an = 8'b1111_1110;
        1: an = 8'b1111_1101;
        2: an = 8'b1111_1011;
        3: an = 8'b1111_0111;
        4: an = 8'b1110_1111;
        5: an = 8'b1101_1111;
        6: an = 8'b1011_1111;
        7: an = 8'b0111_1111;
        default: an = 8'b1111_1110;
      endcase
    
    // ʱ�ӷ�Ƶ��
    always @(posedge clk or posedge clr)
    begin
      if(clr == 1)
        clkdiv <=0;
      else
        clkdiv <= clkdiv + 1;
    end
    
    //ʵ���� 7�������
    Hex7Seg s7(.data(digit), .a2g(a2g));    
endmodule