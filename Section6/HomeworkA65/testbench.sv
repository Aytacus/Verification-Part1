class generator;
  rand bit [3:0] addr;
  rand bit wr;

  // Conditional constraint based on wr value
  constraint addr_cond {
    (wr == 1) -> (addr >= 0 && addr <= 7);
    (wr == 0) -> (addr >= 8 && addr <= 15);
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
        $display("Iteration %0d @ %0t ns -> wr: %0b, addr: %0d", i, $time, g.wr, g.addr);
      end else begin
        $display("Randomization FAILED at iteration %0d", i);
      end
      #20;
    end

    $finish;
  end
endmodule
