// counts bounces seen after our debounce module to ensure our debouncer functions
`include "debouncer_module.v"
`include "s_edge_det.v"
`include "updown_counter.v"

module deb_cnt;
  
  parameter width = 10;
  
  integer delay;       // randomly generated number to rnadomize bounces
  
  integer i;       // loop value
  
  reg    r_sclr;
  
  reg     r_clk;
  
  reg     r_sw0;       // input switch to be debounced
  
  wire [width-1:0]  w_debcnt;        // counts bounces, any count more than one 
   
  wire                     w_out;        // output from debouncer module 
  
  wire                      w_en;        // enable for the counter
  
  
// 50 MHz clock ----------------------------------------------------------------------------
initial begin
	r_clk = 0;
	forever 
		 #10 r_clk = ~r_clk; // 10 second delay since we want it to be on for half the period cycle
end 
  
// debouncer module -------------------------------------------------------------------------------

deb seq0( 
    .i_sclr(r_sclr), 
	.i_clk(r_clk),
	.i_in(r_sw0),
	.o_out(w_out)   // output that will go through edge detector
	);

defparam seq0.modulus = 500; // change time delay to (1/[50 MHz/500]) = 10,000 ns so I dont wait 5 billion years to simulate
// edge detector ---------------------------------------------------------------------------------------

sedge edge0( 
    .i_sw0(w_out),
	.i_clk(r_clk),
	.o_out(w_en)   // output that enables counter
	);

// up counter ---------------------------------------------------------------------------------------------
updown_counter #(.up_down("up"), .BUS_WIDTH(width)) upcnt0( 
    .i_clk(r_clk),
    .i_sclr(r_sclr),
    .i_en(w_en),
    .o_cnt(w_debcnt)
	);
	
//---------------------------------------------------------------------------------------------------------
// Debouncer test, simulate bounce by setting r_sw0 on and off in short delays- Test lasts 
//---------------------------------------------------------------------------------------------------------
initial begin

  r_sclr <= 1'b0;
  
  r_sw0  <= 1'b0;
  #40
  
  for (i=0; i < 10; i = i+1) begin // 10 random bounces
    delay = $urandom_range(1,10);   // random number between 1 and 10
  
    r_sw0  <= 1'b1;
    #delay;
    r_sw0  <= 1'b0;
    #delay;
  end 
  
  #100
  
  for (i=0; i < 12; i = i+1) begin // 12 random bounces
    delay = $urandom_range(1,10);   // random number between 1 and 10
  
    r_sw0  <= 1'b1;
    #delay;
    r_sw0  <= 1'b0;
    #delay;
  end 
  
  #100 
  
  r_sw0 <= 1'b1; // remains on now for atleast 20,0000 ns
  
  #30000
  
  $display("Test is complete");
  $finish;
end 
  
initial begin
  $monitor("time = %t, clk = %b, sclr = %b, out = %b, en = %b, cnt = %b", $time, r_clk, r_sclr, w_out, w_en, w_debcnt);
  $dumpfile("debcnt.vcd");
  $dumpvars();
end 
endmodule 