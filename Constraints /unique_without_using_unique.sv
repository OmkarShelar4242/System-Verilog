// ----------------------------------------------
// Author: Omkar Ashish Shelar
// ----------------------------------------------
// Q: Generate unique random number without using unique keyword 

class unique_cons;
  rand bit [5:0] data [10];

  function void pre_randomize();
    data.shuffle();
  endfunction

  function void post_randomize();
    $display("*************************************************");
    $display("unique values = %p",data);
    $display("*************************************************");
  endfunction

  function new();
    for(int i = 0;i<20;i++)begin
      data[i] = i;
    end
  endfunction
  
endclass

module unique_tb;
  unique_cons c;
  initial begin
    c = new();
    c.randomize();
  end
endmodule
