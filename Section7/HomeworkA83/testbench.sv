class transaction;
  rand bit [7:0] a;
  rand bit [7:0] b;
  rand bit wr;
endclass

class generator;
  transaction trans;
  mailbox gen2drv;
  int trans_count;
  
  
  function new(mailbox gen2drv, int trans_count);
    this.gen2drv = gen2drv;
    this.trans_count = trans_count;
  endfunction
  
  task main();
    for(int i = 0; i < trans_count; i++) begin
      trans = new();
      if(!trans.randomize()) begin
        $display("Generator: Transaction randomization failed at iteration %0d", i);
        $finish;
      end
      
      $display("\n[Generator] Transaction %0d:", i);
      $display("  a = %0d, b = %0d, wr = %0d", trans.a, trans.b, trans.wr);
      
      gen2drv.put(trans);
      $display("[Generator] Transaction %0d sent to driver", i);
    end
  endtask
endclass

class driver;
  transaction trans;
  mailbox gen2drv;
  
  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction
  
  task main();
    forever begin
      gen2drv.get(trans);
      
      $display("[Driver] Transaction received:");
      $display("  a = %0d, b = %0d, wr = %0d", trans.a, trans.b, trans.wr);
      
     
      #5;
    end
  endtask
endclass

class environment;
  generator gen;
  driver drv;
  mailbox gen2drv;
  int trans_count;
  
  function new(int trans_count);
    this.trans_count = trans_count;
    gen2drv = new();
    gen = new(gen2drv, trans_count);
    drv = new(gen2drv);
  endfunction
  
  task run();
    fork
      gen.main();
      drv.main();
    join_any
  endtask
endclass

module tb_transaction;
  environment env;
  
  initial begin
    env = new(10);
    
    env.run();
    
    
    #100;
    
    $display("\nTest completed successfully!");
    $finish;
  end
endmodule




