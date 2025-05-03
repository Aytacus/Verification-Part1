`include "test.sv"
`timescale 1ns/1ps

module tb;
  
  reg resetn = 0;   //////rst represent DUT reset Signal

  /////// User Logic goes here
  
	initial begin
      resetn=0;
      #100
      resetn=1;
      forever begin
        #50 resetn= ~resetn;
      end
    end
  
  
  
  
  /////// User code ends here
 
  
  test t1 = new();
  
  initial begin
    #201;
    t1.no_gen(resetn);
    t1.display();
  end
  
  
endmodule