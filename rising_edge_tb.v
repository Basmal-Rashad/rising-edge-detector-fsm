
`timescale 1ns/1ps

module rising_edge_tb;

 reg clk;
 reg reset;
 reg level;
 wire tick_moore;
 wire tick_mealy;

    // Moore DUT
  rising_edge_moore MOORE_DUT (
  .clk(clk),
  .reset(reset),
  .level(level),
  .tick(tick_moore)
    );

    // Mealy DUT
 rising_edge_mealy MEALY_DUT (
 .clk(clk),
 .reset(reset),
 .level(level),
  .tick(tick_mealy)
    );

    // Clock Generation
initial
begin
 clk = 1'b0;

forever
 #5 clk = ~clk;
 end

// Test Stimulus
    initial
    begin

 reset = 1'b1;
 level = 1'b0;

 #12;

  reset = 1'b0;

// level goes from 0 to 1
#8;
 level = 1'b1;

// Keep level high
 #30;

 // level goes from 1 to 0
 level = 1'b0;

  #20;

// Second Rising Edge
 level = 1'b1;

#30;

 $stop;

 end

endmodule