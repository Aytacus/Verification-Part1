module tb;

  class generator;
    bit [3:0] a = 5, b = 7;
    bit wr = 1;
    bit en = 1;
    bit [4:0] s = 12;

    // Display function to print the values of data members
    function void display();
      $display("a: %0d b: %0d wr: %0b en: %0b s: %0d", a, b, wr, en, s);
    endfunction

    // Deep copy function
    function generator deep_copy();
      generator copy_instance;
      copy_instance = new(); // Create a new instance of generator
      copy_instance.a = this.a; // Copy data members
      copy_instance.b = this.b;
      copy_instance.wr = this.wr;
      copy_instance.en = this.en;
      copy_instance.s = this.s;
      return copy_instance; // Return the copied instance
    endfunction

  endclass

  generator obj, obj_copy; // Declare two generator class objects

  initial begin
    // Create an instance of the generator class
    obj = new();
    obj.display(); // Display values of original object

    // Create a deep copy of the obj instance
    obj_copy = obj.deep_copy();
    obj_copy.display(); // Display values of the copied object
  end

endmodule



