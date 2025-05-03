module tb;

  
  int dyn_array[];

  initial begin
    
    dyn_array = new[7];

    
    for (int i = 0; i < 7; i++) begin
      dyn_array[i] = (i + 1) * 7;
    end

    
    #20;

    dyn_array = new[20](dyn_array);  

    
    for (int i = 7; i < 20; i++) begin
      dyn_array[i] = (i - 6) * 5;
    end

    
    $display("---- Dynamic Array Contents ----");
    for (int i = 0; i < 20; i++) begin
      $write("%0d ", dyn_array[i]);
    end
    $display("\n--------------------------------");
  end

endmodule

