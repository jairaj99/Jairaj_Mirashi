    `timescale 1ns/10ps

    module top;

        import spi_pkg::*;
        import uvm_pkg::*;


        //clock generation
        bit clk;

        initial
        begin
                clk=0;
                forever
                        #10 clk =~ clk;
        end

        // Interface handle
        spi_if in(clk);

	        //Instantiation and connection of  DUT

        spi_top  DUV  (  .wb_clk_i(in.clk),
                        .wb_rst_i(in.wb_rst_i),
                        .wb_adr_i(in.wb_adr_i),
                        .wb_dat_i(in.wb_dat_i),
                        .wb_dat_o(in.wb_dat_o),
                        .wb_sel_i(in.wb_sel_i),
                        .wb_we_i(in.wb_we_i),
                        .wb_stb_i(in.wb_stb_i),
                        .wb_cyc_i(in.wb_cyc_i),
                        .wb_ack_o(in.wb_ack_o),
                        .wb_int_o(in.wb_int_o),
                        .miso_pad_i(in.miso_pad_i),
                        .mosi_pad_o(in.mosi_pad_o),
                        .ss_pad_o(in.ss_pad_o),
                        .sclk_pad_o(in.sclk_pad_o));


        //In initial begin block
        initial
        begin
                uvm_config_db #(virtual spi_if)::set(null,"*","v_if",in);
                run_test();
        end

    endmodule

