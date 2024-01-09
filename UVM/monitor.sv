
class alu_monitor extends uvm_monitor;
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_component_utils(alu_monitor)
  
  // declaring the handle name for the virtual interface access
  virtual alu_interface vif_monitor;
  
  // instantiating the sequence item
  alu_sequence_item item;
  
  // instantiating the TLM analysis port 
  uvm_analysis_port #(alu_sequence_item) monitor_port;
  
  // CONSTRUCTOR
  function new(string name = "alu_monitor", uvm_component parent);
    super.new(name,parent);
    `uvm_info("MONITOR_CLASS","Inside Constructor",UVM_HIGH)
  endfunction: new
  
  // BUILD PHASE
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("MONITOR_CLASS","Build Phase", UVM_HIGH)
    
    // getting the virtual interface
    if(!(uvm_config_db #(virtual alu_interface)::get(this,"*","vif",vif_monitor)))begin
      `uvm_error("MONITOR_CLASS","OOPS! Unable to get VIF from config_db :(")
    end
    
    // object creation using the new method
    monitor_port = new("monitor_port",this);
    
  endfunction: build_phase
  
  // CONNECT PHASE
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("MONITOR_CLASS","Connect Phase", UVM_HIGH)
  endfunction: connect_phase
  
  // RUN PHASE
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_CLASS","Run Phase", UVM_HIGH)
    
    forever begin 
      item = alu_sequence_item::type_id::create("item");
      
      wait(!vif_monitor.reset);
      
      // sampling the inputs 
      @(posedge vif_monitor.clock);
      item.a = vif_monitor.a;
      item.b = vif_monitor.b;
      item.op_code = vif_monitor.op_code;
      
      // sampling the outputs (ps: acc to design spec output is visible in the next cycle)
      @(posedge vif_monitor.clock);
      item.result = vif_monitor.result;
      item.carryout = vif_monitor.carryout;
      
      // send the item to the scoreboard (via the port)
      monitor_port.write(item);
      
    end
    
  endtask: run_phase
  
endclass: alu_monitor
