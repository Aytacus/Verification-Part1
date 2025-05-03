module tb;

  reg [15:0] values [0:31];  

  task generate_multiples_of_8();
    integer i;
    begin
      for (i = 0; i < 32; i = i + 1) begin
        values[i] = i * 8;  
      end
    end
  endtask

  initial begin
    generate_multiples_of_8();  

    for (integer i = 0; i < 32; i = i + 1) begin
      $display("Value at index %0d: %0d", i, values[i]);
    end
  end

endmodule



