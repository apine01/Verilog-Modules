// full debouncer module 
`include "debouncer_state.v"
`include "bcd_counter.v"

module deb
  ( 
    i_sclr,
	i_clk,
	i_in,
	o_out
	);
	
  input i_sclr;  // clears counter when pressed
  
  input i_clk;   
  
  input i_in;    // input signal to be debounced
  
  output o_out;  // output with no bounce
  
  wire [width-1:0] w_useless;  // useless output
  
  wire w_done;   // declaring wire to be connected from counters cout to state machine 
  
  wire w_cnt;    // declaring wire to be connected from the inverted statecnt to the counters enable(cin)
  
  wire w_cnten;   // inverted form of w_cnt
  
  // counter specifications with a 50 MHzclock in mind 
  parameter modulus = 5000000;  // time delay will be 100 ms
  
  parameter width = 23;   // minimum bits needed to count to modulus
  
  // wire connections
  assign w_cnten = !w_cnt; // invert before going into counter
  
//--------------------------------------------------------------------------------------------------------

// debouncer state machine
seq_debouncer seq0 
  (
    .i_in(i_in),           
	.i_done(w_done),         
	.i_clk(i_clk),
	.o_stateout(o_out),      // output
	.o_statecnt(w_cnt)       // inverted and connected to input enable of counter
	);
  
 // counter module
  bcd_counter #(.MOD(modulus), .BUS_WIDTH(width)) bcd0
  ( 
    .i_clk(i_clk),
    .i_sclr(i_sclr),
    .i_cin(w_cnten),        // i_cin port
    .o_cnt(w_useless),      // do not need this output at all
    .o_cout(w_done)         // connected to done input of seq_debouncer
	);
endmodule