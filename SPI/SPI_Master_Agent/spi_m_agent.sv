 class spi_m_agent extends uvm_agent;

        //Factory registration
        `uvm_component_utils(spi_m_agent)

       //Handles of agent_config,driver,monitor,sequencer

        spi_m_agent_config m_agt_cfg;
        spi_m_sequencer  m_seqrh;
        spi_m_driver    m_dvrh;
        spi_m_monitor   m_monh;


       //-------Standard methods --------//
        extern function new(string name="spi_m_agent", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);

     endclass

       //-------Constructor new  method-------//
        function spi_m_agent::new(string name="spi_m_agent",uvm_component parent);
                super.new(name,parent);

        endfunction

 //---------Build_phase method --------//
        function void spi_m_agent::build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db #(spi_m_agent_config)::get(this," ","spi_m_agent_config",m_agt_cfg))
                `uvm_fatal("config","con't get agent_config from uvm_config_db")

                m_monh=spi_m_monitor::type_id::create("m_monh",this);

                if(m_agt_cfg.is_active==UVM_ACTIVE)
                        begin
                                m_dvrh=spi_m_driver::type_id::create("m_dvrh",this);
                                m_seqrh=spi_m_sequencer::type_id::create("m_seqrh",this);
                        end
        endfunction


       //-------- Connect phase method -------//
        function void spi_m_agent::connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                if(m_agt_cfg.is_active==UVM_ACTIVE)
                        begin

                        m_dvrh.seq_item_port.connect(m_seqrh.seq_item_export);
                        end
        endfunction


s