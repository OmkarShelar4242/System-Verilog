
class alu_sequencer extends uvm_sequencer #(alu_sequence_item);
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_component_utils(alu_sequencer)
  
  // CONSTRUCTOR
  function new(string name = "alu_sequencer", uvm_component parent);
    super.new(name,parent);
    `uvm_info("SEQUENCER_CLASS","Inside Constructor",UVM_HIGH)
  endfunction: new
  
  // BUILD PHASE
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("SEQUENCER_CLASS","Build Phase", UVM_HIGH)
  endfunction: build_phase
  
  // CONNECT PHASE
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("SEQUENCER_CLASS","Connect Phase", UVM_HIGH)
  endfunction: connect_phase
  
endclass: alu_sequencer
