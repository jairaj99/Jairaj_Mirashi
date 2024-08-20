interface counter_inf (input logic clock);

    // 4-bit data input for the counter
    logic [3:0] data_in; 
    
    // 4-bit data output from the counter
    logic [3:0] data_out; 
    
    // Control signal to load a specific value into the counter
    logic load;
    
    // Reset signal to initialize the counter
    logic rst;

    // Driver Clocking Block
    // Specifies how signals are sampled and driven during the positive edge of the clock
    clocking driver_cb @(posedge clock); 
        default input #1 output #1; // Default delays for input and output
        output rst;    // Output reset signal
        output data_in; // Output data input
        output load;   // Output load signal
    endclocking

    // Output Monitor Clocking Block
    // Specifies how the data_out signal is monitored during the positive edge of the clock
    clocking output_mon_cb @(posedge clock); 
        default input #1 output #1; // Default delays for input and output
        input data_out; // Input data output
    endclocking

    // Input Monitor Clocking Block
    // Specifies how the load, rst, and data_in signals are monitored during the positive edge of the clock
    clocking input_mon_cb @(posedge clock); 
        default input #1 output #1; // Default delays for input and output
        input load;     // Input load signal
        input rst;      // Input reset signal
        input data_in;  // Input data input
    endclocking

    // Driver Modport
    // Specifies the modport for driving signals using the driver_cb clocking block
    modport DRIVER (
        clocking driver_cb
    );

    // Input Monitor Modport
    // Specifies the modport for monitoring input signals using the input_mon_cb clocking block
    modport INPUT_MON (
        clocking input_mon_cb
    );

    // Output Monitor Modport
    // Specifies the modport for monitoring output signals using the output_mon_cb clocking block
    modport OUTPUT_MON (
        clocking output_mon_cb
    );

endinterface
