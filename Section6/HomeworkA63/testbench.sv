// generator class with constraints
class generator;

  rand bit [4:0] a; // max 31
  rand bit [5:0] b; // max 63

  // Constraint: limit a to 0-8 and b to 0-5
  constraint limit_c {
    a >= 0 && a <= 8;
    b >= 0 && b <= 5;
  }

  function new();
  endfunction

endclass

// Testbench module
module tb;
  generator g;
  int i;
  int error_count = 0; // To count randomization failures

  initial begin
    g = new();

    for (i = 0; i < 20; i++) begin
      if (g.randomize()) begin
        $display("Iteration %0d @ %0t ns -> a: %0d, b: %0d", i, $time, g.a, g.b);
      end else begin
        error_count++;
        $display("Iteration %0d @ %0t ns -> Randomization FAILED", i, $time);
      end
      #20;
    end

    $display("\nTotal randomization failures: %0d", error_count);
    $finish;
  end

endmodule

