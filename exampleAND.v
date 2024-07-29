// example and gate
module and_example(input_1,input_2,and_result);

input input_1;
input input_2;
output and_result;
	
wire hot_one;
assign hot_one = input_1 & input_2;
assign and_result = hot_one;
endmodule // end of module