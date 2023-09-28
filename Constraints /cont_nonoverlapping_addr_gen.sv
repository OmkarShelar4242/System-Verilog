// ------------------------------------------------------------------
// Author: Omkar Ashish Shelar
// ------------------------------------------------------------------
// Q: Generate contiguous, non-overlapping address regions within a given range. 

class address_reg_cons; 
  typedef struct{
  rand int index ; 
  rand bit [31:0] start_addr ; 
  rand bit [31:0] end_addr ; 
  rand bit [31:0] size   ; 
  } regions; 
  
  rand regions regions[];
  
  constraint num_reg{regions.size() inside {3,4};}
  
  constraint reg_val {foreach(regions[i]){
    regions[i].index == i ;
    regions[i].size inside {[10:20]} ; 
    regions[i].end_addr == regions[i].start_addr + regions[i].size -1 ; 
    regions[i].start_addr < regions[i].end_addr; 
    regions[i].end_addr < 100 ; // Upper Limit of all Mem locations.        
    }}
    constraint cont {foreach(regions[i])
    {if(i< regions.size()-1)
      regions[i].end_addr == regions[i+1].start_addr -1;
    }}
  
endclass 


module abc ; 
  initial begin 
    address_reg_cons c = new() ; 
    c.randomize() ; 
    foreach(c.regions[i])
      begin 
        $display("**************************************************************");
        $display("Index::%0d::Start Addr::%0h::End Addr::%0h",c.regions[i].index,c.regions[i].start_addr , c.regions[i].end_addr); 
      end 
  end 
endmodule 
