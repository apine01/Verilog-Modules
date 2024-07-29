// LED_blinker
`timescale 1us/1ns

module LED_blinker(i_en, i_sw1, i_sw2, o_LED_dr);
 
  input  i_en;
  input  i_sw1;
  input  i_sw2;
	
  output o_LED_dr;

// clock generation 50 kHz
reg clk;
initial begin
	clk = 0;
	forever 
		 #20 clk = ~clk;
end

// create constant parameters for counters
  parameter c_cnt_100Hz = 250;
  parameter c_cnt_50Hz  = 500;
  parameter c_cnt_10Hz  = 2500;
  parameter c_cnt_1Hz   = 25000;
  
 // These signals will be the counters:
  reg [17:0] r_cnt_100HZ = 0;
  reg [18:0] r_cnt_50HZ = 0;
  reg [21:0] r_cnt_10HZ = 0;
  reg [24:0] r_cnt_1HZ = 0;
  
 // signals that will toggle at desired frequencies
  reg r_toggle_100Hz = 1'b0;
  reg r_toggle_50Hz = 1'b0;
  reg r_toggle_10Hz = 1'b0;
  reg r_toggle_1Hz = 1'b0;

 // select buttons for the multiplexer
  reg r_sel;
 
// counters for frequencies 

// counter_100
  always @(posedge clk) begin
    if (r_cnt_100HZ == c_cnt_100Hz -1) // -1 to account for it starting at 0
	  begin 
	    r_toggle_100Hz <= !r_toggle_100Hz;
	    r_cnt_100HZ <= 0;
	  end 
	else 
	  r_cnt_100HZ <= r_cnt_100HZ + 1;
  end
	  
// counter_50
  always @(posedge clk) begin
    if (r_cnt_50HZ == c_cnt_50Hz -1) // -1 to account for it starting at 0
	  begin 
	    r_toggle_50Hz <= !r_toggle_50Hz;
	    r_cnt_50HZ <= 0;
	  end 
	else 
	  r_cnt_50HZ <= r_cnt_50HZ + 1;
  end

// counter_10
  always @(posedge clk) begin
    if (r_cnt_10HZ == c_cnt_10Hz -1) // -1 to account for it starting at 0
	  begin 
	    r_toggle_10Hz <= !r_toggle_10Hz;
	    r_cnt_10HZ <= 0;
	  end 
	else 
	      r_cnt_10HZ <= r_cnt_10HZ + 1;
  end
	  
// counter_1
  always @(posedge clk) begin
    if (r_cnt_1HZ == c_cnt_1Hz -1) // -1 to account for it starting at 0
	  begin 
	    r_toggle_1Hz <= !r_toggle_1Hz;
	    r_cnt_1HZ <= 0;
	  end 
	else 
	    r_cnt_1HZ <= r_cnt_1HZ + 1;
  end
	 
// multiplexer select 
  always @(r_toggle_100Hz, r_toggle_50Hz,r_toggle_10Hz, r_toggle_1Hz, r_sel) begin 
	case({i_sw1, i_sw2})
	  2'b00 : r_sel <= r_toggle_100Hz;
      2'b01 : r_sel <= r_toggle_50Hz;
      2'b10 : r_sel <= r_toggle_10Hz;
      2'b11 : r_sel <= r_toggle_1Hz;
	endcase 
  end
  assign o_LED_dr = r_sel & i_en;
endmodule 