module x7seg(
    input  logic [15:0] x,
    input  logic        clk,
    input  logic        clr,
    output logic [6:0] a2g,
    output logic [3:0] an, //数码管使能
    output logic       dp ); // 小数点
    
    logic [1:0] s;   // 选择哪个数码管
    logic [3:0] digit;
    logic [19:0] clkdiv;
  
    assign dp = 1;           // DP off
    assign s = clkdiv[19:18];// count every 10.4ms        
    
    //4个数码管 4选1 (mux44)
    always_comb
      case(s)
        0: digit = x[3:0];
        1: digit = x[7:4];
        2: digit = x[11:8];
        3: digit = x[15:12];
        default: digit = x[3:0];
      endcase
    
    // 8个数码管 使能 (ancode)
    always_comb
      case(s)
        0: an = 4'b1110;
        1: an = 4'b1101;
        2: an = 4'b1011;
        3: an = 4'b0111;
        default: an = 4'b1110;
      endcase
    
    // 时钟分频器
    always @(posedge clk or posedge clr)
    begin
      if(clr == 1)
        clkdiv <=0;
      else
        clkdiv <= clkdiv + 1;
    end
    
    //实例化 7段数码管
    Hex7Seg s7(.data(digit), .a2g(a2g));    
endmodule