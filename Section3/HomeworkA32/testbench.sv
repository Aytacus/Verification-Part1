`timescale 1ns/1ps

module tb;

  
  reg [7:0] arr[0:9];
  integer i;

  initial begin
    for (i = 0; i < 10; i = i + 1) begin
      arr[i] = i * i;
    end
    #10;
    for (i = 0; i < 10; i = i + 1) begin
      $display("arr[%0d] = %0d", i, arr[i]);
    end
  end

endmodule
