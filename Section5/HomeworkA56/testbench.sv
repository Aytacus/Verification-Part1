module tb;

  class MyClass;
    reg [3:0] a, b, c;  // 4-bit data members

    // Constructor to initialize values
    function new(input [3:0] a_val, input [3:0] b_val, input [3:0] c_val);
      a = a_val;
      b = b_val;
      c = c_val;
    endfunction

    // Task to add data members and display values
    task add_and_display();
      reg [3:0] result;
      result = a + b + c;  // Add the values of a, b, and c
      // Display the values of a, b, c, and result
      $display("a = %0d, b = %0d, c = %0d, result = %0d", a, b, c, result);
    endtask

  endclass
  
  MyClass obj;  // Declare the class object

  initial begin
    // Create an instance of MyClass with values a=1, b=2, and c=4
    obj = new(1, 2, 4);

    // Call the task to perform the addition and display the result
    obj.add_and_display();
  end

endmodule




