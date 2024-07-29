// 7 segment LED output
//converts hexidecimal number to drive 7 segment LED display
module segment_7
  (
   i_binary,
   i_dp,
   i_blank,
   o_leds,
   );
   

 input [3:0]      i_binary; // 4 bit input in hexidecimal
 
 input            i_dp; // 8th segment is decimal point
 
 input            i_blank; // blanks all LEDs
 
 output reg [7:0] o_leds; // connect to 7-segment LEDs & decimal point
 
 
// Definition of output pins for 7 segment display:%

//     0			
//   -----			
//   |   |			
// 5 |   |1			
//   | 6 |			
//   -----			
//   |   |			
// 4 |   |2			
//   |   |			
//   -----  . 7		
//     3				

	// Truth table for 7 segment%
always @(*) begin 
  case({i_blank, i_binary})
	{1'b0, 4'b0000} :	o_leds[6:0] = 8'b1000000; 	// If not blank, then display led's according to hexidecimal value%
	{1'b0, 4'b0001} :	o_leds[6:0] = 8'b1111001;
	{1'b0, 4'b0010} :	o_leds[6:0] = 8'b0100100;
	{1'b0, 4'b0011} :	o_leds[6:0] = 8'b0110000;
	{1'b0, 4'b0100} :	o_leds[6:0] = 8'b0011001;
	{1'b0, 4'b0101} :	o_leds[6:0] = 8'b0010010;
	{1'b0, 4'b0110} :	o_leds[6:0] = 8'b0000010;
	{1'b0, 4'b0111} :	o_leds[6:0] = 8'b1111000;
	{1'b0, 4'b1000} :	o_leds[6:0] = 8'b0000000;
	{1'b0, 4'b1001} :	o_leds[6:0] = 8'b0011000;
	{1'b0, 4'b1010} :   o_leds[6:0] = 8'b0001000;
	{1'b0, 4'b1011} :	o_leds[6:0] = 8'b0000011;
	{1'b0, 4'b1100} :	o_leds[6:0] = 8'b0100111;
	{1'b0, 4'b1101} :	o_leds[6:0] = 8'b0100001;
	{1'b0, 4'b1110} :	o_leds[6:0] = 8'b0000110;
	{1'b0, 4'b1111} :	o_leds[6:0] = 8'b0001110; 
    {1'b1, 4'bx} :	o_leds[6:0] = 8'b1111111; 	// Blanks all leds when blank=1, x means "don't care", or "any number"
	default      :  o_leds[7]   = i_dp & ~i_blank;// Logic equation for decimal point
  endcase 
    
end 
endmodule