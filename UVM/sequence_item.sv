
class alu_sequence_item extends uvm_sequence_item;
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_object_utils(alu_sequence_item);
  
  // CONSTRUCTOR
  function new (string name = "alu_sequence_item");
    super.new(name);
    `uvm_info("SEQ_ITEM_CLASS","Inside Constructor",UVM_HIGH);
  endfunction: new
  
  // SIGNAL INSTANTIATION
  
  // INPUT SIGNALS
  rand logic reset;
  rand logic [7:0] a,b;
  rand logic [3:0] op_code;
  
  // OUTPUT SIGNALS
  logic [7:0] result;
  bit carryout;
  
  // DEFAULT CONSTRAINTS (WRT DESIGN SPEC GIVEN) {PS: "_c" implies it is a constraint}
  
  // constraint to restrict the select line values to only the legal ones
  constraint ALU_Sel_c {op_code inside {[0:3]};}
  
  // constraint to make sure that a >= b
  constraint input_vals_c {a >= b;}
  
endclass: alu_sequence_item
