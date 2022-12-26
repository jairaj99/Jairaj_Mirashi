 class spi_s_agent_top extends uvm_env;

        //Factory registration
        `uvm_component_utils(spi_s_agent_top)

        //agent handle
        spi_s_agent  s_agt;

       //------ Standard Metods -----//
        extern function new (string name="spi_s_agent_top",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);

   endclass

      // ---- Constructor new method ----//
        function spi_s_agent_top::new(string name ="spi_s_agent_top",uvm_component parent);

                super.new(name,parent);

        endfunction

     // ------ Build phase method-------//
        function void  spi_s_agent_top::build_phase(uvm_phase phase);

                super.build_phase(phase);
                s_agt=spi_s_agent::type_id::create("s_agt",this);

        endfunction

  //------Run_phase method-------//

        task spi_s_agent_top::run_phase(uvm_phase phase);

                super.run_phase(phase);
                uvm_top.print_topology;

       endtask
