class generator;
  rand bit [7:0] x, y, z;

  // Constraint: Values must be between 0 and 50 (inclusive)
  constraint range_c {
    x >= 0 && x <= 50;
    y >= 0 && y <= 50;
    z >= 0 && z <= 50;
  }

  function new();
  endfunction
endclass

module tb;
  generator g;
  int i;

  initial begin
    g = new();

    for (i = 0; i < 20; i++) begin
      if (g.randomize()) begin
        $display("Time: %0t ns -> x: %0d, y: %0d, z: %0d", $time, g.x, g.y, g.z);
      end else begin
        $display("Randomization failed at iteration %0d", i);
      end
      #20;
    end

    $finish;
  end
endmodule

