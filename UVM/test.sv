
class alu_test extends uvm_test;
  
  // REGISTER CLASS WITH UVM FACTORY
  `uvm_component_utils(alu_test)
  
  // Instantiating the environment
  alu_env env;
  
  // Instantiating our sequences and creating/declaring their handles
  alu_base_sequence reset_sequence;
  alu_test_sequence test_sequence;
  
  // CONSTRUCTOR
  function new(string name = "alu_test", uvm_component parent);
    super.new(name,parent);
    `uvm_info("TEST_CLASS","Inside Constructor",UVM_HIGH)
  endfunction: new
  
  // BUILD PHASE
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS","Build Phase", UVM_HIGH)
    
    // object creation using type id method
    env = alu_env::type_id::create("env",this);
    /*
    this implies that this class i.e., test class is the parent class of the env component
    ps: component's object creation needs 2 parameters i.e., name and the parent (unlike object classes)
    */
        
  endfunction: build_phase
  
  // CONNECT PHASE
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS","Connect Phase", UVM_HIGH)
  endfunction: connect_phase
  
  // RUN PHASE
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("TEST_CLASS","Run Phase", UVM_HIGH)
    
    // Announcement: "Hey! I am going run some sequences"
    phase.raise_objection(this);
    
    // start our sequences
    
    // 1. reset sequence
    reset_sequence = alu_base_sequence::type_id::create("reset_sequence");
    reset_sequence.start(env.agent.sequencer);
    #10;
    
    // 2. test sequence
    repeat(100) begin
    test_sequence = alu_test_sequence::type_id::create("test_sequence");
    test_sequence.start(env.agent.sequencer);
    #10;
    end
    
    /*
    within the () of the start method we specify which sequencer we want to use as there can be multiple of them
    */
    
    phase.drop_objection(this);
    
  endtask: run_phase
  
endclass: alu_test
