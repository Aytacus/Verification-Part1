class generator;
  rand bit rst;
  rand bit wr;

  // Constraints
  constraint rst_prob {
    rst dist {0 := 30, 1 := 70}; // 30% 0, 70% 1
  }

  constraint wr_prob {
    wr dist {0 := 50, 1 := 50};  // 50% 0, 50% 1
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
        $display("Iteration %0d @ %0t ns -> rst: %0b, wr: %0b", i, $time, g.rst, g.wr);
      end else begin
        $display("Randomization FAILED at iteration %0d", i);
      end
      #20;
    end

    $finish;
  end
endmodule
