 class spi_s_agent extends uvm_agent;

        //Factory registration
        `uvm_component_utils(spi_s_agent)

       //Handles of agent_config,driver,monitor,sequencer

        spi_s_agent_config s_agt_cfg;
        spi_s_sequencer  s_seqrh;
        spi_s_driver    s_dvrh;
        spi_s_monitor   s_monh;


       //-------Standard methods --------//
        extern function new(string name="spi_s_agent", uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);

     endclass

       //-------Constructor new  method-------//
        function spi_s_agent::new(string name="spi_s_agent",uvm_component parent);
                super.new(name,parent);

        endfunction
  //---------Build_phase method --------//
        function void spi_s_agent::build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db #(spi_s_agent_config)::get(this," ","spi_s_agent_config",s_agt_cfg))
                `uvm_fatal("config","con't get agent_config from uvm_config_db")

                s_monh=spi_s_monitor::type_id::create("s_monh",this);

                if(s_agt_cfg.is_active==UVM_ACTIVE)
                        begin
                                s_dvrh=spi_s_driver::type_id::create("s_dvrh",this);
                                s_seqrh=spi_s_sequencer::type_id::create("s_seqrh",this);
                        end
        endfunction


       //-------- Connect phase method -------//
        function void spi_s_agent::connect_phase(uvm_phase phase);
                super.connect_phase(phase);
                if(s_agt_cfg.is_active==UVM_ACTIVE)
                        begin

                        s_dvrh.seq_item_port.connect(s_seqrh.seq_item_export);
                        end
        endfunction
