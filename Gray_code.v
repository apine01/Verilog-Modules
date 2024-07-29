// Gray code translator for hexadecimal numbers
`include "binary_to_hexadecimal.v"

module gray_code
  (
   i_sw0,
   i_sw1,
   i_sw2,
   i_sw3,
   o_3bus,
   o_gray
   );

  input i_sw0;

  input i_sw1;

  input i_sw2;
  
  input i_sw3;
  
  output [3:0] o_3bus; // 4 bits to be changed as hexdecimal bits
  
  output [3:0] o_gray;
  
  wire [3:0] o_hexa; // declaration for decoder
  
  // wire outputs to be decoded after combinational logic
  wire [3:0] b_3;
  
  assign b_3[3] = i_sw3;
  assign b_3[2] = i_sw3 ^ i_sw2;
  assign b_3[1] = i_sw1 ^ b_3[2]; 
  assign b_3[0] = i_sw0 ^ b_3[1]; 
  
  assign o_3bus = b_3;
  
binary_to_hex decoder
  (
   o_3bus,
   o_hexa
   );

  assign o_gray = o_hexa;
  
endmodule 