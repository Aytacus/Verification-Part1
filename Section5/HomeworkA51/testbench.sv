class MyClass;
  int unsigned a = 45;
  int unsigned b = 78;
  int unsigned c = 90;
endclass

module tb;
  MyClass obj;

  initial begin
    obj = new();
    $display("a = %0d, b = %0d, c = %0d", obj.a, obj.b, obj.c);
  end
endmodule
