// ----------------------------------------------------
// Author: Omkar Ashish Shelar
// ----------------------------------------------------
// Q --> Requirements of the array are as follows: 
// 		1. size = 9
//		2. value between 1 to 9
//		3. two values between indices 0 & 7, should be same

module tb();
  bit [3:0] a[];
  initial begin
    bit [3:0] idx[2];
    
    randomize(a,idx) with {
      a.size() == 9;
      unique {idx};
      foreach(idx[i]) idx[i] inside {[0:7]};
      solve idx before a;
      foreach(a[i]){
        a[i] inside {[1:9]};
        a[idx[0]] == a[idx[1]];
      }
    };
        $display("************************");
        $display("%p",a);
        $display("%p",idx);
        
  end
endmodule
