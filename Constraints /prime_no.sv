// ------------------------------------------------------------------
// Author: Omkar Ashish Shelar
// Date: 08 September 2023
// ------------------------------------------------------------------
// Q: Generate prime numbers 

class prime_cons;
  rand int num[];
  
  constraint size{num.size() inside {[15:30]};}
  constraint prime{foreach(num[i])
    num[i] == prime_num(i);}
  
  function int prime_num(int a);
    int i;
    if(a<=2)begin 
      return 2;
    end
    else begin 
      for(i=2;i<a;i++)begin
        if(a%i==0)begin 
          return 2;
        end
      end
      return a;
    end
  endfunction
  
  function void post_randomize();
    $display("**************************************************************");
    $display("%p",num);
    $display("**************************************************************");
  endfunction
  
endclass: prime_cons
    
module tb();
  prime_cons c;
  initial begin 
    c = new();
    c.randomize();
  end
endmodule 
