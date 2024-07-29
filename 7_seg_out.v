// 7 segment LED output
//converts hexidecimal number to drive 7 segment LED display
module segment_7
  (
   i_hexa,
   i_dp,
   i_blank,
   o_leds,
   );
   

 input [3:0]      i_hexa; // 4 bit input in hexidecimal
 
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
  case({i_blank, i_hexa})
	{1'b0, 4'h0} :	o_leds[6:0] = 8'b1000000; 	// If not blank, then display led's according to hexidecimal value%
	{1'b0, 4'h1} :	o_leds[6:0] = 8'b1111001;
	{1'b0, 4'h2} :	o_leds[6:0] = 8'b0100100;
	{1'b0, 4'h3} :	o_leds[6:0] = 8'b0110000;
	{1'b0, 4'h4} :	o_leds[6:0] = 8'b0011001;
	{1'b0, 4'h5} :	o_leds[6:0] = 8'b0010010;
	{1'b0, 4'h6} :	o_leds[6:0] = 8'b0000010;
	{1'b0, 4'h7} :	o_leds[6:0] = 8'b1111000;
	{1'b0, 4'h8} :	o_leds[6:0] = 8'b0000000;
	{1'b0, 4'h9} :	o_leds[6:0] = 8'b0011000;
	{1'b0, 4'hA} :  o_leds[6:0] = 8'b0001000;
	{1'b0, 4'hB} :	o_leds[6:0] = 8'b0000011;
	{1'b0, 4'hC} :	o_leds[6:0] = 8'b0100111;
	{1'b0, 4'hD} :	o_leds[6:0] = 8'b0100001;
	{1'b0, 4'hE} :	o_leds[6:0] = 8'b0000110;
	{1'b0, 4'hF} :	o_leds[6:0] = 8'b0001110; 
    {1'b1, 4'hx} :	o_leds[6:0] = 8'b1111111; 	// Blanks all leds when blank=1, x means "don't care", or "any number"
	default      :  o_leds[7]   = i_dp & ~i_blank;// Logic equation for decimal point
  endcase 
    
end 
endmodule