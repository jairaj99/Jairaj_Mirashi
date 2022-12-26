  class spi_m_driver extends uvm_driver #(spi_m_xtn);

        //Factory registration

        `uvm_component_utils(spi_m_driver)

        //virtual interface handle
        virtual spi_if.SPI_DRV v_if;

        // agent config handle

        spi_m_agent_config m_agt_cfg;


       //--------- Standard methods -------//

        extern function new (string name="spi_m_driver",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern function void report_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task send_to_dut(spi_m_xtn m_xtn);


    endclass

 //-------Constructor new method -------//
        function spi_m_driver::new(string name="spi_m_driver",uvm_component parent);
                super.new(name,parent);

        endfunction


       //-------- Build_phase method -----//
        function void spi_m_driver::build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db #(spi_m_agent_config)::get(this," ","spi_m_agent_config",m_agt_cfg))

                `uvm_fatal("config","can't get agent_config from uvm_config_db");


      endfunction


       //--------Connect_phase---------//
        function void spi_m_driver::connect_phase(uvm_phase phase);

                super.connect_phase(phase);
                v_if=m_agt_cfg.v_if;

        endfunction

 //---------Run_phase----------
        task  spi_m_driver::run_phase (uvm_phase phase);
                super.run_phase(phase);
                @(v_if.spi_drv_cb);
                v_if.spi_drv_cb.wb_rst_i<=1'b1;
                v_if.spi_drv_cb.wb_stb_i<=1'b0;
                v_if.spi_drv_cb.wb_cyc_i<=1'b0;

                @(v_if.spi_drv_cb);
                v_if.spi_drv_cb.wb_rst_i<=1'b0;

                forever
                        begin
                                seq_item_port.get_next_item(req);

                                send_to_dut(req);
                                $display("----Completed Driver Task----");
                                seq_item_port.item_done();
                        end
        endtask
 //------- send to dut  -------//

       task spi_m_driver::send_to_dut(spi_m_xtn m_xtn);
                //print transaction
                `uvm_info("SPI_MASTER_DRIVER",$sformatf("printing from driver \n  %s",m_xtn.sprint()),UVM_LOW)

                //write logic
                @(v_if.spi_drv_cb);
                v_if.spi_drv_cb.wb_adr_i<=m_xtn.wb_adr_i;
                v_if.spi_drv_cb.wb_dat_i<=m_xtn.wb_dat_i;
                v_if.spi_drv_cb.wb_sel_i<=4'b1111;
                v_if.spi_drv_cb.wb_we_i<=m_xtn.wb_we_i;
                v_if.spi_drv_cb.wb_stb_i<=1'b1;
                v_if.spi_drv_cb.wb_cyc_i<=1'b1;

                wait(v_if.spi_drv_cb.wb_ack_o)
                v_if.spi_drv_cb.wb_stb_i<=1'b0;
                v_if.spi_drv_cb.wb_cyc_i<=1'b0;

        m_agt_cfg.drv_data_sent_cnt++;

      endtask

        function void spi_m_driver::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: master driver Collected %0d Transactions", m_agt_cfg.drv_data_sent_cnt), UVM_LOW)

endfunction
