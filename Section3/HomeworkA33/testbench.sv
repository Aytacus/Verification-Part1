`timescale 1ns/1ps

module tb;

  reg [31:0] arr1[0:14];  
  reg [31:0] arr2[0:14];  
  integer i;

  initial begin
    
    for (i = 0; i < 15; i = i + 1) begin
      arr1[i] = $urandom;
      arr2[i] = $urandom;
    end

    $write("arr1: ");
    for (i = 0; i < 15; i = i + 1) begin
      $write("%0d ", arr1[i]);
    end
    $write("\n");

    $write("arr2: ");
    for (i = 0; i < 15; i = i + 1) begin
      $write("%0d ", arr2[i]);
    end
    $write("\n");
  end

endmodule


