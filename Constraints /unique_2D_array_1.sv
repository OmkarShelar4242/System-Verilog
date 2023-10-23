// --------------------------------------------------------
// Author: Omkar Ashish Shelar
// --------------------------------------------------------
// Q: A 2D array such that the diagonal elements of the matrix are not repeated in their respective row or col

class cons;
  localparam n = 7;
  rand int a[n][n];
  local rand int b[n][n];
  
  constraint a_rows {foreach(a[i,]) unique{a[i]};}				// an entire row of unique values 
  constraint a_cols {foreach(a[i,j]) b[j][i] == a[i][j];}		// to access the columns of a 
  constraint b_rows {foreach(b[i,]) unique{b[i]};}				// making the columns of a unique
  constraint a_vals {foreach(a[i,j]) a[i][j] inside {[0:9]};}	// limiting the values
  
  function void post_randomize();
    $display("-------------------------");
    foreach(a[i,])begin
      $display("%p",a[i]);
    end
    $display("-------------------------");
  endfunction
endclass

module tb();
  cons c;
  initial begin 
    c=new();
    repeat(2) c.randomize();
  end
endmodule
