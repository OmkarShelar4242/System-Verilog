
class alu_env extends uvm_env;
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_component_utils(alu_env)
  
  // Instantiating agent and scoreboard
  alu_agent agent;
  alu_scoreboard scoreboard;
  
  // CONSTRUCTOR
  function new(string name = "alu_env", uvm_component parent);
    super.new(name,parent);
    `uvm_info("ENV_CLASS","Inside Constructor",UVM_HIGH)
  endfunction: new
  
  // BUILD PHASE
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ENV_CLASS","Build Phase", UVM_HIGH)
    
    // object creation using type id method
    agent = alu_agent::type_id::create("agent",this);
    scoreboard = alu_scoreboard::type_id::create("scoreboard",this);
    
  endfunction: build_phase
  
  // CONNECT PHASE
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ENV_CLASS","Connect Phase", UVM_HIGH)
    
    // connecting the scoreboard with the monitor
    agent.monitor.monitor_port.connect(scoreboard.scoreboard_port);
    
  endfunction: connect_phase
  
  // RUN PHASE
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("RUN_CLASS","Run Phase", UVM_HIGH)
  endtask: run_phase
  
endclass: alu_env
