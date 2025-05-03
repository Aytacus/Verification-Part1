module tb;

  reg [31:0] fixed_array [19:0];  
  logic [31:0] queue[$];          
  integer i;

  initial begin
    
    for (i = 0; i < 20; i++) begin
      fixed_array[i] = $urandom;  
    end

    
    for (i = 19; i >= 0; i--) begin
      queue.push_back(fixed_array[i]);  
    end

    
    for (i = 0; i < 20; i++) begin
      $write("%0d ", fixed_array[i]);  
    end
    

    
    $display("---- Queue Contents ----");
    for (i = 0; i < $size(queue); i++) begin
      $write("%0d ", queue[i]);  
    end
    $display("\n-------------------------");
  end

endmodule


