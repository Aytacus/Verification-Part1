
class transaction;
  rand bit [3:0] a;  
  rand bit [3:0] b;  
  bit [7:0] mul;    
  
  function transaction copy();
    transaction tr = new();
    tr.a = this.a;
    tr.b = this.b;
    tr.mul = this.mul;
    return tr;
  endfunction
  
  function void display(string tag);
    $display("[%0s] a = %0d, b = %0d, mul = %0d", tag, a, b, mul);
  endfunction
endclass

class generator;
  transaction trans;
  mailbox gen2drv;
  int trans_count;
  event gen_done;
  
  function new(mailbox gen2drv, int trans_count, event gen_done);
    this.gen2drv = gen2drv;
    this.trans_count = trans_count;
    this.gen_done = gen_done;
    trans = new();
  endfunction
  
  task main();
    for(int i = 0; i < trans_count; i++) begin
      if(!trans.randomize()) begin
        $display("Generator: Transaction randomization failed at iteration %0d", i);
        $finish;
      end
      
      trans.display("Generator");
      
      gen2drv.put(trans.copy());
      $display("[Generator] Transaction %0d sent to driver", i);
      
      #5;
    end
    
    -> gen_done; 
    $display("[Generator] All %0d transactions generated", trans_count);
  endtask
endclass

class driver;
  virtual multiplier_if mif;
  transaction trans;
  mailbox gen2drv;
  
  function new(virtual multiplier_if mif, mailbox gen2drv);
    this.mif = mif;
    this.gen2drv = gen2drv;
  endfunction
  
  task reset();
    $display("[Driver] Resetting DUT");
    mif.a <= 0;
    mif.b <= 0;
    @(posedge mif.clk);
  endtask
  
  task main();
    reset();
    
    forever begin
      gen2drv.get(trans);
      
      @(posedge mif.clk);
      mif.a <= trans.a;
      mif.b <= trans.b;
      
      trans.display("Driver");
      
      @(posedge mif.clk);
      trans.mul = mif.mul;
      $display("[Driver] Result: mul = %0d (a=%0d * b=%0d = %0d)", mif.mul, trans.a, trans.b, trans.a * trans.b);
      
      if(mif.mul !== (trans.a * trans.b)) begin
        $display("[Driver] ERROR: Multiplication mismatch! Expected: %0d, Got: %0d", 
                 trans.a * trans.b, mif.mul);
      end
    end
  endtask
endclass

class environment;
  generator gen;
  driver drv;
  mailbox gen2drv;
  virtual multiplier_if mif;
  int trans_count;
  event gen_done;
  
  function new(virtual multiplier_if mif, int trans_count);
    this.mif = mif;
    this.trans_count = trans_count;
    gen2drv = new();
    gen = new(gen2drv, trans_count, gen_done);
    drv = new(mif, gen2drv);
  endfunction
  
  task run();
    fork
      gen.main();
      drv.main();
    join_any
    
    wait(gen_done.triggered);
    #100; 
    $finish;
  endtask
endclass

interface multiplier_if(input logic clk);
  logic [3:0] a;
  logic [3:0] b;
  logic [7:0] mul;
endinterface


module tb_top;
  
  bit clk;
  always #5 clk = ~clk;
  
  
  multiplier_if mif(clk);
  
  
  top dut(
    .clk(clk),
    .a(mif.a),
    .b(mif.b),
    .mul(mif.mul)
  );
  
  initial begin
    environment env;
    env = new(mif, 10); 
    env.run();
  end
  
  initial begin
    $monitor("[Monitor] Time: %0t, a = %0d, b = %0d, mul = %0d", 
             $time, mif.a, mif.b, mif.mul);
    
    
  end
endmodule

