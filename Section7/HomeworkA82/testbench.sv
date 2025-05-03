class transaction;
  bit [7:0] addr = 8'h12;
  bit [3:0] data = 4'h4;
  bit we = 1'b1;
  bit rst = 1'b0;
endclass
class generator;
  transaction trans;

  function transaction generate_tx();
    trans = new();
    $display("[GENERATOR] addr: %h, data: %h, we: %b, rst: %b",
              trans.addr, trans.data, trans.we, trans.rst);
    return trans;
  endfunction
endclass

class driver;
  task drive(transaction t);
    $display("[DRIVER]    addr: %h, data: %h, we: %b, rst: %b",
              t.addr, t.data, t.we, t.rst);
  endtask
endclass
module tb;

  generator gen;
  driver drv;
  transaction t;

  initial begin
    // Nesne oluştur
    gen = new();
    drv = new();

    // Transaction oluştur ve al
    t = gen.generate_tx();

    // Driver’a gönder
    drv.drive(t);

    $finish;
  end

endmodule

