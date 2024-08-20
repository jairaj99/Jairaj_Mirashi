module counter_load (
    input logic clk,         // Clock input
    input logic rst,         // Reset input
    input logic load,        // Load control input
    input logic [3:0] data_in,  // 4-bit data input to load into the counter
    output logic [3:0] data_out  // 4-bit data output from the counter
);

    // Internal register to hold the current counter value
    logic [3:0] counter_reg;

    // Always block triggered on the rising edge of the clock or reset signal
    always_ff @(posedge clk or posedge rst) begin
        // If reset is active, set counter register to zero
        if (rst) begin
            counter_reg <= 4'b0000;
        end 
        // If load is active, load the data_in value into the counter register
        else if (load) begin
            counter_reg <= data_in;
        end 
        // If counter register value is 13 or greater, reset it to zero
        else if (counter_reg >= 4'd13) begin
            counter_reg <= 4'b0000;
        end 
        // Otherwise, increment the counter register value
        else begin
            counter_reg <= counter_reg + 1;
        end
    end

    // Assign the value of the counter register to the data_out output
    assign data_out = counter_reg;

endmodule
