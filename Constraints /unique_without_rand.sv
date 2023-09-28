// ----------------------------------------------
// Author: Omkar Ashish Shelar
// ----------------------------------------------
// Q: Unique random numbers without using "rand" or "randc"

class unique_cons;
  int data [15];

  function new();
    foreach(data[i])begin
      data[i] = i;
    end
  endfunction

  function void display();
    $display("*************************************************");
    $display("unique values = %p",data);
    $display("*************************************************");
  endfunction

  function void data_shuffle();
    data.shuffle();
  endfunction
  
endclass

module unique_tb;
  unique_cons c;
  initial begin 
    c = new();
    c.data_shuffle();
    c.display();
  end
endmodule
