// Include the definition of the sequence item class
`include "seq_item.sv"   // Contains the seq_item class which defines the sequence item structure

// Include the base sequence class definition
`include "base_seq.sv"   // Contains the base_seq class which defines the base sequence for test scenarios

// Include the sequencer class definition
`include "sequencer.sv"  // Contains the sequencer class which is responsible for driving sequences of items

// Include the driver class definition
`include "driver.sv"     // Contains the driver class which drives sequence items onto the DUT

// Include the monitor class definition
`include "monitor.sv"    // Contains the monitor class which observes signals and collects data

// Include the scoreboard class definition
`include "scoreboard.sv" // Contains the scoreboard class which checks the correctness of the DUT's responses

// Include the agent class definition
`include "agent.sv"      // Contains the agent class which bundles the sequencer, driver, and monitor

// Include the environment class definition
`include "env.sv"        // Contains the environment class which sets up and connects the agent and other components
