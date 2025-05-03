// generator class with 8-bit random variables
class generator;
  rand bit [7:0] x, y, z;  // 8-bit data members

  // Constructor
  function new();
  endfunction
endclass

// Testbench module
module tb;
  generator g; // Declare generator object
  int i;

  initial begin
    g = new(); // Create the generator object

    for (i = 0; i < 20; i++) begin
      void'(g.randomize()); // Generate random values
      $display("Time: %0t ns -> x: %0d, y: %0d, z: %0d", $time, g.x, g.y, g.z);
      #20; // Wait for 20 ns
    end

    $finish;
  end
endmodule
