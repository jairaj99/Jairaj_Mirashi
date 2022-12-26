 interface spi_if (input bit  clk);

        logic        wb_rst_i ;
        logic  [4:0] wb_adr_i;
        logic  [31:0] wb_dat_i;
        logic  [31:0] wb_dat_o;
        logic  [3:0] wb_sel_i;
        logic        wb_we_i;
        logic        wb_stb_i;
        logic        wb_cyc_i;
        logic        wb_ack_o;
        logic        wb_int_o;

        logic  [31:0] ss_pad_o;
        bit sclk_pad_o;

        bit mosi_pad_o;
        bit miso_pad_i;

        /* UART Driver clocking bolck*/
                clocking spi_drv_cb @(posedge clk);
                        default input #1 output #1;

                        output  wb_rst_i ;
                        output  wb_adr_i;
                        output  wb_sel_i;
                        output  wb_dat_i;
                        output  wb_we_i;
                        output  wb_stb_i;
                        output  wb_cyc_i;
                        input   wb_ack_o;
                        input   wb_dat_o;
                        input   wb_int_o;

                        input   ss_pad_o;
                        input   mosi_pad_o;
                        output  miso_pad_i;
                        input sclk_pad_o;

                endclocking

       /* UART Monitor Clocking block */
                clocking spi_mon_cb @(posedge clk);
                        default input #1 output #1;


                        input  wb_adr_i;
                        input  wb_sel_i;
                        input  wb_dat_i;
                        input  wb_dat_o;
                        input  wb_we_i;
                        input  wb_stb_i;
                        input  wb_cyc_i;
                        input  wb_ack_o;
                        input  wb_int_o;

                        input ss_pad_o;
                        input mosi_pad_o;
                        input miso_pad_i;
                        input sclk_pad_o;

                endclocking

        /* Modports*/

           modport SPI_DRV (clocking spi_drv_cb);
           modport SPI_MON (clocking spi_mon_cb);

  endinterface

