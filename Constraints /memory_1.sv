// ----------------------------------------------------
// Author: Omkar Ashish Shelar
// ----------------------------------------------------
// Q --> Memory Block:
//		1. memory region: 0x0 to 0x100
//		2. reserved memory: 0x20 to 0xE0
//		3. size of a block of memory needed by us: 16 Bytes 
// 		4. address is 4-Byte aligned 
// Write a verilog constraint to choose a block of memory of the given size such that it is outside the reserved region, but inside the memory region

class cons;
  rand bit [31:0] addr;
  int size = 'h10;
  
  constraint c { addr inside {[0:'h100]}; !(addr inside {['h20:'hE0]}); addr%4==0; addr+size inside {[0:'h20],['hE0:'h100]}; !(addr+size inside{['h20:'hE0]}); }
  
  function void post_randomize();
    $write("%d",addr);
  endfunction 
  
endclass

module tb();
  cons c;
  initial begin
    c = new();
    repeat(20) c.randomize();
  end
endmodule 
