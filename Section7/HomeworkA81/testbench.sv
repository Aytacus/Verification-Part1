module tb;

  int task1_count = 0;
  int task2_count = 0;

  // Task 1: triggers every 20 ns
  task automatic task1;
    forever begin
      #20;
      task1_count++;
      $display("Time: %0t ns -> Task 1 Trigger", $time);
    end
  endtask

  // Task 2: triggers every 40 ns
  task automatic task2;
    forever begin
      #40;
      task2_count++;
      $display("Time: %0t ns -> Task 2 Trigger", $time);
    end
  endtask

  initial begin
    fork
      task1();
      task2();
    join_none

    // Run simulation for 200 ns
    #200;

    // Display task execution counts
    $display("\n=== Execution Summary ===");
    $display("Task 1 executed %0d times", task1_count);
    $display("Task 2 executed %0d times", task2_count);

    $finish;
  end

endmodule

