module x7seg(
    input  logic [15:0] x,
    input  logic        clk,
    input  logic        clr,
    output logic [6:0] a2g,
    output logic [3:0] an, //�����ʹ��
    output logic       dp ); // С����
    
    logic [1:0] s;   // ѡ���ĸ������
    logic [3:0] digit;
    logic [19:0] clkdiv;
  
    assign dp = 1;           // DP off
    assign s = clkdiv[19:18];// count every 10.4ms        
    
    //4������� 4ѡ1 (mux44)
    always_comb
      case(s)
        0: digit = x[3:0];
        1: digit = x[7:4];
        2: digit = x[11:8];
        3: digit = x[15:12];
        default: digit = x[3:0];
      endcase
    
    // 8������� ʹ�� (ancode)
    always_comb
      case(s)
        0: an = 4'b1110;
        1: an = 4'b1101;
        2: an = 4'b1011;
        3: an = 4'b0111;
        default: an = 4'b1110;
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