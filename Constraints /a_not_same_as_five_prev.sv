// ------------------------------------------------------------------
// Author: Omkar Ashish Shelar
// ------------------------------------------------------------------
// Q: a should not be present in the previous occurences of a

class a_cons;
  rand bit [3:0] a;
  int queue[$];
  constraint c {!(a inside {queue} );}
  function void post_randomize();
    queue.push_front(a);
    $display("Value of A = %d ",a);
    if(queue.size == 6)begin 
      queue.pop_back();
    end
    $display("previous occurences = %p",queue);
  endfunction
endclass

module a_tb;
  a_cons c;
  initial begin 
    c = new();
    repeat(15)begin 
      c.randomize();
    end
  end
endmodule
