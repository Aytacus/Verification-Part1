module tb;

  
  reg clk = 0;
  reg [5:0] addr;
  reg wr, en;

  
  always #20 clk = ~clk;

  
  task send_stimulus(input [5:0] address, input bit write, input bit enable);
    @(posedge clk);  
    addr = address;
    wr = write;
    en = enable;
    $display("Time: %0t ns, addr = %0d, wr = %b, en = %b", $time, addr, wr, en);
  endtask

  
  initial begin
    
    addr = 0;
    wr = 0;
    en = 0;

    
    send_stimulus(6'd5, 1'b1, 1'b1);
    send_stimulus(6'd12, 1'b0, 1'b1);
    send_stimulus(6'd25, 1'b1, 1'b0);
    send_stimulus(6'd40, 1'b0, 1'b0);

    #100; 
    $finish;
  end

endmodule

