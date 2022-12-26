    class env extends uvm_env;

        /*Factory registration */
        `uvm_component_utils(env)

        //Agent_tops , env_config , Scoreboard , agent_config ,vitual_seqr handles

        spi_m_agent_top    m_agt_tp;
        spi_s_agent_top    s_agt_tp;
        scoreboard sb;
        virtual_seqr v_seqrh;

        env_config e_cfg;
        spi_m_agent_config m_agt_cfg;
        spi_s_agent_config s_agt_cfg;

        adapter adp_h;
        uvm_reg_predictor#(spi_m_xtn) prd_h;
        spi_reg_block block_h;

        //---------- Standard UVM Methods --------//
          extern function new (string name ="env",uvm_component parent);
          extern function void build_phase (uvm_phase phase);
          extern function void connect_phase (uvm_phase phase);

    endclass

       //--------Constructor new method-------//
        function env::new(string name ="env",uvm_component parent);
                super.new(name,parent);

        endfunction

       //--------Build_phase method --------//
        function void  env::build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db #(env_config)::get(this," ", "env_config",e_cfg))
                `uvm_fatal("config","can't get env_config from uvm_config_db")

                if(e_cfg.has_spi_m_agent)
                        begin
                                m_agt_tp= spi_m_agent_top::type_id::create("m_agt_tp",this);

                                uvm_config_db #(spi_m_agent_config)::set(this,"*","spi_m_agent_config",e_cfg.m_agt_cfg);
                        end

                if(e_cfg.has_spi_m_agent)
                        begin
                                s_agt_tp=spi_s_agent_top::type_id::create("s_agt_tp",this);
                                uvm_config_db #(spi_s_agent_config)::set(this,"*","spi_s_agent_config",e_cfg.s_agt_cfg);
                        end

                if(e_cfg.has_virtual_seqr)
                        v_seqrh=virtual_seqr::type_id::create("v_seqrh",this);

		                    //Adapter creation

                adp_h = adapter::type_id::create("adp_h");


                //Predictor creation
                prd_h = uvm_reg_predictor#(spi_m_xtn) ::type_id::create("prd_h",this);

                if(e_cfg.has_scoreboard)
                        sb=scoreboard::type_id::create("sb",this);

       endfunction

       //--------Connect_phase method-------//
        function void  env::connect_phase(uvm_phase phase);
                super.connect_phase(phase);

                if(e_cfg.has_virtual_seqr)
                        begin
                                v_seqrh.m_seqrh=m_agt_tp.m_agt.m_seqrh;
                                v_seqrh.s_seqrh=s_agt_tp.s_agt.s_seqrh;

                        end


                  //Set Target sequencer and target agent adapter in register map for master
                  e_cfg.block_h.spi_map.set_sequencer(m_agt_tp.m_agt.m_seqrh,adp_h);

                  //Set the Predictor Map
                  prd_h.map = e_cfg.block_h.spi_map;

                //Set predictor adapter
                prd_h.adapter = adp_h;

                //Connect the predictor to the bus agent monitor analysis port
                m_agt_tp.m_agt.m_monh.spi_m_mon_port.connect(prd_h.bus_in);

		        if(e_cfg.has_scoreboard)
                        begin
                                m_agt_tp.m_agt.m_monh.spi_m_mon_port.connect(sb.m_fifo.analysis_export);

                                s_agt_tp.s_agt.s_monh.spi_mon_port.connect(sb.s_fifo.analysis_export);

                        end

        endfunction
