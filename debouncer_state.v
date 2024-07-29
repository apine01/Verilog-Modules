// state machine for debouncer

module seq_debouncer 
  (
    i_in,           
	i_done,
	i_clk,
	o_stateout,
	o_statecnt
	);
	
  input i_in;            // input to be debounced
  
  input i_done;          // time delay output
  
  input i_clk;  
  
  reg [1:0] state_holder = s_Lw;   // holds current state to be selected, start at low waiting
  
  reg [1:0] present_state;         // state to be sent to output
  
  output reg o_stateout;           // output state that is debounced, MSB of state 
  
  output reg o_statecnt;           // output that enables counter in order for time delay, LSB of state
  
  //-------------------------------------------------------------------------------------------
  // different states, takes form of [o_stateout, o_statecnt]
  //-------------------------------------------------------------------------------------------
  
  localparam  s_Lw = 2'b00;   // low waiting state 
                            // shifts to low state when time delay is done and the signal is high
  
  localparam  s_L  = 2'b01;   // low state 
                            // shifts to high waiting once the signal is high
  
  localparam  s_Hw = 2'b10;   // high waiting state 
                            // shifts to high once the time delay is done
  
  localparam  s_H  = 2'b11;   // final high state which stays at high if the signal is high 
                            // and goes back to low waiting once the signal is low

  
always @(*) begin
  case(state_holder)
    s_Lw : begin
	  if (i_in && i_done)
	    state_holder <= s_L; 
	  else if (!i_done)
	    state_holder <= s_Lw;
	end 
	
	s_L : begin
	  if (i_in == 1'b1)
	    state_holder <= s_Hw;
	  else if (!i_in)
	    state_holder <= s_L;
    end

    s_Hw : begin
      if (i_done == 1'b1)
	    state_holder <= s_H;
	  else if (!i_done)
        state_holder <= s_Hw;
	end 
     
    s_H : begin	
	  if (i_in == 1'b1)
	    state_holder <= s_H;
	  else if (!i_in)
	    state_holder <= s_Lw;
	end
	
	default : state_holder <= s_Lw; // stays low waiting when idle 
	endcase
end 

always @(posedge i_clk) begin
   present_state <= state_holder;
   o_stateout <= present_state[1];
   o_statecnt <= present_state[0];
end 
endmodule 
  
	    