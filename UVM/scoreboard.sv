
class alu_scoreboard extends uvm_scoreboard;
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_component_utils(alu_scoreboard)
  
  // instantiating the implementation port 
  uvm_analysis_imp #(alu_sequence_item,alu_scoreboard) scoreboard_port;
  
  // instantiating a queue to store all the transactions 
  alu_sequence_item transactions [$];
  
  // CONSTRUCTOR
  function new (string name = "alu_scoreboard", uvm_component parent);
    super.new(name,parent);
    `uvm_info("SCOREBOARD_CLASS","Inside the Constructor",UVM_HIGH)
  endfunction: new
  
  // BUILD PHASE
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SCOREBOARD_CLASS","Build Phase",UVM_HIGH)
    
    // object creation using new method
    scoreboard_port = new("scoreboard_port",this);
  endfunction: build_phase
  
  // CONNECT PHASE 
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SCOREBOARD_CLASS","Connect Phase",UVM_HIGH)
  endfunction: connect_phase
  
  // WRITE METHOD
  function void write (alu_sequence_item item);
    /*
    to store all the items generated by running multiple sequences make use of a queue
    */
    transactions.push_back(item);
  endfunction: write
  
  // RUN PHASE 
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("SCOREBOARD_CLASS","Run Phase",UVM_HIGH)
    
    // we are carrying out the comparison with the expected result here
    forever begin 
      
      // 1. get the packet/transaction/item from the queue
      alu_sequence_item current_transaction;
      wait(transactions.size()!=0);
      current_transaction = transactions.pop_front();
      // 2. do the comparison using the compare task
      compare(current_transaction);
    end
    
  endtask: run_phase
  
  task compare (alu_sequence_item current_transaction);
    // we first generate the expected value 
    logic [7:0] expected_result;
    bit expected_carryout;
    // then compare with the received value 
    logic [7:0] actual_result;
    bit actual_carryout;
    
    // generating the expected values 
    case (current_transaction.op_code)
      0: begin 
        expected_result = current_transaction.a + current_transaction.b;
      end
      1: begin 
        expected_result = current_transaction.a - current_transaction.b;
      end
      2: begin 
        expected_result = current_transaction.a * current_transaction.b;
      end
      3: begin 
        expected_result = current_transaction.a / current_transaction.b;
      end
    endcase
    
    // storing the received value
    actual_result = current_transaction.result;
    
    // comparing 
    if (expected_result != actual_result) begin 
      `uvm_error("COMPARE",$sformatf("OOPS! Transaction Failed :( | Expected = %d <--> Actual = %d",expected_result,actual_result))
    end
    else begin 
      `uvm_info("COMPARE",$sformatf("HOORAY! Transaction Passed :) | Expected = %d <--> Actual = %d",expected_result,actual_result),UVM_LOW)
    end
    
  endtask: compare
  
endclass: alu_scoreboard
