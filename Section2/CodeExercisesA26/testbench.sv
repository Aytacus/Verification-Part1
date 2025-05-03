    `include "test.sv"
     
    module tb;
     
      // Signal declaration
      reg clk = 0;
     
      // Parameters for waveform generation
      real period = 50.0;       // Period in nanoseconds
      real duty_cycle = 0.6;    // Duty cycle (60%)
      real high_time, low_time;  /// high and low time
     
      // Function to calculate high and low times
      task get_high_low_times(input real period, input real duty_cycle, output real high_time, output real low_time);
        high_time = period * duty_cycle;   // High time based on duty cycle
        low_time = period * (1 - duty_cycle);  // Low time based on remaining period
      endtask
     
      // Instantiate the test class
      test t1 = new();
     
      // Clock generation using high and low times
      initial begin
        // Get the high and low times based on period and duty cycle
        get_high_low_times(period, duty_cycle, high_time, low_time);
        
     
          // Generate clock based on high and low times
          forever begin
            clk = 1;
            #(high_time);
            clk = 0;
            #(low_time);
          end
        
      end
      
      
      real generated_value;
      
      initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        // Calculate a value based on high and low times and send it for evaluation
        #20;
        generated_value = clk;  // Add the high and low times for evaluation
        t1.no_gen(generated_value);  // Pass the generated value to the test class
        t1.display();
        #50;   
        $stop;
      end
      
    endmodule