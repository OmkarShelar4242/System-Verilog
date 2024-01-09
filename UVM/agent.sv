
class alu_agent extends uvm_agent;
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_component_utils(alu_agent)
  
  // Instantiating sequencer, driver and monitor
  alu_sequencer sequencer;
  alu_driver driver;
  alu_monitor monitor;
  
  // CONSTRUCTOR
  function new(string name = "alu_agent", uvm_component parent);
    super.new(name,parent);
    `uvm_info("AGENT_CLASS","Inside Constructor",UVM_HIGH)
  endfunction: new
  
  // BUILD PHASE
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("AGENT_CLASS","Build Phase", UVM_HIGH)
    
    // object creation using type id method
    sequencer = alu_sequencer::type_id::create("sequencer",this);
    driver = alu_driver::type_id::create("driver",this);
    monitor = alu_monitor::type_id::create("monitor",this);
    
  endfunction: build_phase
  
  // CONNECT PHASE
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("AGENT_CLASS","Connect Phase", UVM_HIGH)
    
    // connect the sequencer and the driver using their inbuilt ports
    driver.seq_item_port.connect(sequencer.seq_item_export);
    
  endfunction: connect_phase
  
  // RUN PHASE
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("AGENT_CLASS","Run Phase", UVM_HIGH)
  endtask: run_phase
  
endclass: alu_agent
