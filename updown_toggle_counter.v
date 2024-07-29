// up down counter that can be toggled from up to down and vice versa with an input

module updown_t_counter 
  #(parameter BUS_WIDTH = 4)
  ( 
    i_clk,
	i_up_down,
    i_sclr,
    i_en,
    o_cnt
	);
  
  reg      dir; // direction of counter 
  
  reg      max; // max value to reset at when the counter is down
  
  input  i_clk; // clock that drives counter
  
  input i_up_down; // if high, it counts up, if low, it counts down
  
  input i_sclr; // clears counter when 1
  
  input   i_en; // input that enables counter 
  
  output reg [BUS_WIDTH-1:0] o_cnt = 0;  // counter output
  
  
// sets max value

initial 
  max = 2**(BUS_WIDTH) - 1; // value that counter resets at when it is 0 

// selects direction of counter based on updown input
always @(posedge i_clk) begin
  if (i_up_down == 1'b1)
    dir = 1;
  else if (!i_up_down)
    dir = 0;
end 

// ----------------------------------------------------------------------------------------------------------
// Counter triggered at every rising edge of the input clock speed
// ----------------------------------------------------------------------------------------------------------
  
always @(posedge i_clk) begin 

  if (i_sclr == 1'b1 && dir)         // up counter clear, clears if sclr is 1
    o_cnt <= 0;
  else if (i_sclr == 1'b1 && !dir)   // down counter clear, clears if sclr is 1
    o_cnt <= max; 
  else if (i_en && dir)              // up counter, only enables circuit if en input is enabled
    o_cnt <= o_cnt + 1;         
  else if (i_en && !dir)
    o_cnt <= o_cnt - 1;  
  else 
    o_cnt <= o_cnt;                  // only purpose of else statement is to prevent latches from being created
  end 
 
endmodule