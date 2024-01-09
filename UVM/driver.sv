
class alu_driver extends uvm_driver #(alu_sequence_item);
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_component_utils(alu_driver)
  
  // declaring the handle name for the virtual interface access
  virtual alu_interface vif_driver;	
  
  // instantiating the sequence_item 
  alu_sequence_item item;
  
  // CONSTRUCTOR
  function new(string name = "alu_driver", uvm_component parent);
    super.new(name,parent);
    `uvm_info("DRIVER_CLASS","Inside Constructor",UVM_HIGH)
  endfunction: new
  
  // BUILD PHASE
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DRIVER_CLASS","Build Phase", UVM_HIGH)
    
    // getting the virtual interface
    if(!(uvm_config_db #(virtual alu_interface)::get(this,"*","vif",vif_driver)))begin
      `uvm_error("DRIVER_CLASS","OOPS! Unable to get VIF from config_db :(")
    end
    /*
    this implies this class
    vif_driver is the name of the virtual interface being used in the driver class
    we are accessing the virtual interface "vif" set in the top module and giving it the name as vif_driver
    now for this to work we need a handle which declared after registering the class above
    as a safety check we use the "if" condition to cater to the case when we are not able to get the handle vif
    */
  endfunction: build_phase
  
  // CONNECT PHASE
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("DRIVER_CLASS","Connect Phase", UVM_HIGH)
  endfunction: connect_phase
  
  // RUN PHASE
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("DRIVER_CLASS","Run Phase", UVM_HIGH)
    
    // forever drive the sequence item to the DUT via the interface until end of simulation
    
    forever begin
      item = alu_sequence_item::type_id::create("item");
      // use the seq_item_port of the sequencer to get the next sequence item and assign/put it to the sequence item you created here i.e., "item"
      seq_item_port.get_next_item(item);
      // applying driving logic using the drive task 
      drive(item);
      seq_item_port.item_done();
    end
    
  endtask: run_phase
  
  task drive (alu_sequence_item item);
    @(posedge vif_driver.clock);
    vif_driver.reset <= item.reset;
    vif_driver.a <= item.a;
    vif_driver.b <= item.b;
    vif_driver.op_code <= item.op_code;
  endtask: drive
  
endclass: alu_driver
