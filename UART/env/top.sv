`include "timescale.sv"

module top;
    import uart_package::*;
    import uvm_pkg::*;

//Clock 
bit clock0;
bit clock1;

initial 
begin
    clock0=0;
    forever 
        #5 clock0 =~ clock0;
end
    
initial 
begin
    clock1=0;
    forever 
        #10 clock1 =~ clock1;    
end

uart_if in0(clock0);
uart_if in1(clock1);

wire a,b;

//Instantiation and connection of two DUTs 
uart_top DUT1(.wb_clk_i(clock0),.wb_rst_i(in0.wb_rst_i),.wb_adr_i(in0.wb_addr_i),.wb_dat_i(in0.wb_dat_i),.wb_dat_o(in0.wb_dat_o),.wb_we_i(in0.wb_we_i),.wb_stb_i(in0.wb_stb_i),.wb_cyc_i(in0.wb_cyc_i),.wb_ack_o(in0.wb_ack_o),.wb_sel_i(in0.wb_sel_i),.int_o(in0.int_o),.stx_pad_o(a),.srx_pad_i(b));

uart_top DUT2(.wb_clk_i(clock1),.wb_rst_i(in1.wb_rst_i),.wb_adr_i(in1.wb_addr_i),.wb_dat_i(in1.wb_dat_i),.wb_dat_o(in1.wb_dat_o),.wb_we_i(in1.wb_we_i),.wb_stb_i(in1.wb_stb_i),.wb_cyc_i(in1.wb_cyc_i),.wb_ack_o(in1.wb_ack_o),.wb_sel_i(in1.wb_sel_i),.int_o(in1.int_o),.stx_pad_o(b),.srx_pad_i(a));

//Test
initial 
begin
    uvm_config_db #(virtual uart_if)::set(null,"*","vif_0",in0);
    uvm_config_db #(virtual uart_if)::set(null,"*","vif_1",in1); 

    run_test();

end

endmodule

