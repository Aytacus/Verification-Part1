`timescale 1ns/1ps

module tb;

  // Signal declaration
  reg clk = 0;

  // Parameters for waveform generation
  real period = 0.0;       
  real duty_cycle = 0.0;    
  real high_time = 0.0, low_time = 0.0;

  // Print values after 12 ns
  initial begin
    #12;
    $display("---- Variable Values at 12ns ----");
    $display("clk = %0b", clk);
    $display("period = %0f", period);
    $display("duty_cycle = %0f", duty_cycle);
    $display("high_time = %0f", high_time);
    $display("low_time = %0f", low_time);
    $display("---------------------------------");
  end

endmodule
