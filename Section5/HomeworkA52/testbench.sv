class MyClass;

int unsigned a = 7;

int unsigned b = 5;

function int unsigned multiply();

return a*b;

endfunction

endclass

module tb;

MyClass obj;

int unsigned result;

int unsigned expected = 35;

initial begin

obj = new();

result= obj.multiply();

if (result==expected) begin

    $display("Test Passed");

end

else begin

     $display("Test Failed. Got %0d, Expected %0d", result, expected);

end

end

endmodule
      
      
      
    endmodule