// 4 bit binary to hexadecimal

module binary_to_hex
  (i_binary,
   o_hexa
   );
  
  input [3:0] i_binary;
  
  output reg [3:0] o_hexa;
  
  //breaks binary signal into 4 bits each
always @(*) begin
    case (i_binary)
      4'b0000 : o_hexa = 4'h0;
	  4'b0001 : o_hexa = 4'h1;
	  4'b0010 : o_hexa = 4'h2;
	  4'b0011 : o_hexa = 4'h3;
	  4'b0100 : o_hexa = 4'h4;
	  4'b0101 : o_hexa = 4'h5;
	  4'b0110 : o_hexa = 4'h6;
	  4'b0111 : o_hexa = 4'h7;
	  4'b1000 : o_hexa = 4'h8;
	  4'b1001 : o_hexa = 4'h9;
	  4'b1010 : o_hexa = 4'hA;
	  4'b1011 : o_hexa = 4'hB;
	  4'b1100 : o_hexa = 4'hC;
	  4'b1101 : o_hexa = 4'hD;
	  4'b1110 : o_hexa = 4'hE;
      4'b1111 : o_hexa = 4'hF;
    endcase
 end
endmodule

  