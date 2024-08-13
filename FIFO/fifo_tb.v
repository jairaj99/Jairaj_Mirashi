module fifo_tb();

reg clk, rst, we, re;
reg [7:0] data_in;
wire [7:0] data_out;
wire full, empty;

fifo dut (clk, rst, we, re, data_in, data_out, full, empty);

parameter t = 10;

initial begin
    clk = 1'b0;
    forever #(t/2) clk = ~clk;
end

task initialize();
begin
    we = 1'b0; 
    re = 1'b0;
    data_in = 8'b0;
end
endtask

task reset();
begin
    @(negedge clk);
    rst = 1'b1;
    @(negedge clk);
    rst = 1'b0;
end
endtask

task delay();
begin
    #10;
end
endtask

task write(input [7:0] j);
begin
    @(negedge clk);
    data_in = j;
    we = 1'b1;
end
endtask

task read();
begin
    @(negedge clk);
    re = 1'b1;
    we = 1'b0;
end
endtask

initial begin
    initialize();
    reset();
    delay();

    // Write to FIFO
    if (!full) begin
        repeat(16) begin
            write($random % 256);
            delay();
        end
    end

    we = 1'b0;

    // Read from FIFO
    if (!empty) begin
        repeat(16) begin
            read();
            delay();
        end
    end

    $finish;
end

initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
end

endmodule
