package counter_pkg;

    import uvm_pkg::*;
   // `include "uvm_macros.svh"
    `include "counter_trans.sv"
    `include "counter_env_config.sv"
    `include "counter_input_driver.sv"
    `include "counter_input_monitor.sv"
    `include "counter_input_sequencer.sv"
    `include "counter_input_agent.sv"
    `include "counter_output_monitor.sv"
    `include "counter_output_agent.sv"
    `include "counter_scoreboard.sv"
    `include "counter_env.sv"
    `include "counter_seq.sv"
    `include "counter_base_test.sv"

endpackage
