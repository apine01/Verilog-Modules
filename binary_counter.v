// 40 bit binary counter in hexadecimal

module counter ( 
  i_clk,
  i_sclr,
  i_cin,
  o_cnt
  );
  
  input i_clk;
  
  input i_sclr;
  
  input i_cin;
  
  output reg [39:0] o_cnt = 0;
  
 
always @(posedge i_clk) begin 
  if (i_sclr == 1'b1)  // clears if sclr is 1
    o_cnt <= 0;
  else if (i_clk && i_cin) // only enables circuit if cin input is on
    o_cnt <= o_cnt + 1;
end 

endmodule
    
  
