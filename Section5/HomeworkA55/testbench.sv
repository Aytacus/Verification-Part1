module tb;

  class MyClass;
    reg [7:0] a, b, c;

    function new(input [7:0] a_val, input [7:0] b_val, input [7:0] c_val);
      a = a_val;
      b = b_val;
      c = c_val;
    endfunction

  endclass
  
  MyClass obj;

  initial begin
    obj = new(2, 4, 56);

    $display("Value of a: %0d", obj.a);
    $display("Value of b: %0d", obj.b);
    $display("Value of c: %0d", obj.c);
  end

endmodule




