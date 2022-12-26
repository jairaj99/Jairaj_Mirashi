class spi_m_agent_config extends uvm_object;

        //Factory registration
        `uvm_object_utils(spi_m_agent_config)

       //virtual interface handle
        virtual spi_if v_if;

       // Agent configuration
                uvm_active_passive_enum is_active =UVM_ACTIVE;

       // Declare the mon_rcvd_xtn_cnt as static int
                static int mon_rcvd_xtn_cnt =0;

       // Declare the drv_data_sent_cnt as static int
                static int drv_data_sent_cnt =0;

        //------Standard UVM_Method--------//
                extern function new (string name ="spi_m_agent_config");

  endclass

    //-----------------  constructor new method  -------------------//
                function spi_m_agent_config::new(string name ="spi_m_agent_config");
                        super.new(name);
                endfunction
