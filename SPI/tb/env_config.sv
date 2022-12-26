    class env_config extends uvm_object;

        //Fcatory registration
        `uvm_object_utils(env_config)

        bit has_functional_coverage = 0;
        bit has_scoreboard=1;
        bit has_spi_m_agent=1;
        bit has_spi_s_agent=1;
        bit has_spi_m_agent_top=1;
        bit has_spi_s_agent_top=1;
        bit has_virtual_seqr=1;
        bit has_coverage=1;

       // Agents configuration handles
        spi_m_agent_config m_agt_cfg;
        spi_s_agent_config s_agt_cfg;
        spi_reg_block block_h;
       //-------Standard UVM methods -----//
        extern function new (string name ="env_config");

   endclass

      //-----Constructor new method------//
        function env_config ::new(string name ="env_config");

                super.new(name);

        endfunction
