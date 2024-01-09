// Code your testbench here
// or browse Examples
// ALU Verification 

// declaring the timescale 
`timescale 1ns/1ns

// invoking the UVM packages 
import uvm_pkg::*;
`include "uvm_macros.svh"

// include UVM files (in order)
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"

module top;
  
  // declaring the essential signals; clock always defined in the top module
  logic clock;
  
  // instantiating the interface
  // PS: signal connections to the DUT will be done via an Interface
  alu_interface intf(.clock(clock));
  
  // setting the interface
  initial begin
    uvm_config_db #(virtual alu_interface)::set(null,"*","vif",intf);
    /*
    "*" implies that this virtual interface handle is available to every class i.e., test, env, agent ...
    "vif" is the name (string) used to access the interface intf
    */
  end

  // instantiating the DUT 
  alu dut (.clock(intf.clock),.reset(intf.reset),.A(intf.a),.B(intf.b),.ALU_Sel(intf.op_code),.ALU_Out(intf.result),.CarryOut(intf.carryout));
  
  // toggling the clock 
  initial begin 
    clock = 0;
    #5;
    forever clock = #2 ~clock;
  end
  
  // start the test
  initial begin
    run_test("alu_test");
  end
  
  // finishing the testbench
  initial begin
    #5000;
    $display("Ran Out of Clock Cycles ! :(");
    $finish();
  end
  
  // to display waveform 
  initial begin 
    $dumpfile("omkar.vcd");
    $dumpvars();
  end
  
endmodule: top
