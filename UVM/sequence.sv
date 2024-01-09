
// alu_base_sequence == RESET sequence (over here)
class alu_base_sequence extends uvm_sequence;
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_object_utils(alu_base_sequence);
  
  // Instantiate the sequence item and declare the handle name
  alu_sequence_item reset_pkt;
  
  // CONSTRUCTOR
  function new (string name = "alu_base_sequence");
    super.new(name);
    `uvm_info("BASE_SEQ_CLASS","Inside Constructor",UVM_HIGH);
  endfunction: new
  
  // BODY: DICTATES WHAT HAPPENS WITH A SEQ_ITEM
  task body();
    `uvm_info("BASE_SEQ_CLASS","Body ",UVM_HIGH)
    
    // create the object using the type id create method 
    reset_pkt = alu_sequence_item::type_id::create("reset_pkt");
    /*
    "reset_pkt" you can use any name but it is better to use the name of the handle itself
    */
    
    // reset sequence
    start_item(reset_pkt);
    reset_pkt.randomize() with {reset == 1;};
    finish_item(reset_pkt);
    /*
    sequencer calls the "start_item()" implying that it gives the permission to start the sequence in the driver
    sequencer - driver handshaking 
    */
    
  endtask: body
  
endclass: alu_base_sequence

// creating another sequence for testing (non-reset sequence)
class alu_test_sequence extends alu_base_sequence;
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_object_utils(alu_test_sequence);
  
  // Instantiating the sequence item and declaring handle name
  alu_sequence_item test_pkt;
  
  // CONSTRUCTOR
  function new (string name = "alu_test_sequence");
    super.new(name);
    `uvm_info("TEST_SEQ_CLASS","Inside Constructor", UVM_HIGH)
  endfunction: new
  
  // BODY: DICTATES WHAT HAPPENS WITH A SEQ ITEM
  task body();
    `uvm_info("TEST_SEQ_CLASS","Body ",UVM_HIGH)
    
    // object creation using type id method
    test_pkt = alu_sequence_item::type_id::create("test_pkt");
    
    start_item(test_pkt);
    test_pkt.randomize() with {reset == 0;};
    finish_item(test_pkt);
    
  endtask
  
endclass: alu_test_sequence
