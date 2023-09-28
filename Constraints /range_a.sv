// ------------------------------------------------------------------
// Author: Omkar Ashish Shelar
// ------------------------------------------------------------------
// Q: Generate a number between 0-100 70% of the time & 101-255 30% of the time

class range_cons;
  rand bit [7:0] a;
  constraint c_dist {a dist {[0:100]:=7, [101:255]:=3};}
endclass

module range_tb;
  range_cons c;
  initial begin 
    c = new();
    repeat(20)begin 
      c.randomize();
      if(c.a<100)begin
        $display("a = %d -- under dist [0:100]",c.a);
      end
      else begin 
        $display("a = %d -- under dist [101:255]",c.a); 
      end
    end
  end
endmodule
