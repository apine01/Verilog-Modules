// 2 input multiplexer, mulibit

module multiplexer 
  #(parameter data_width = 8)
  (
    i_data0,
	i_data1,
	i_sel,
	o_result
	);
	
  input [data_width-1:0] i_data0;           // first input option
  
  input [data_width-1:0] i_data1;           // second input option
  
  input                    i_sel;           // select input 
  
  output reg [data_width-1:0] o_result;           // output result
  
always @(*) begin
  case(i_sel)
    1'b0 : o_result <= i_data0;
	1'b1 : o_result <= i_data1;
  endcase
end