 class spi_m_monitor extends uvm_monitor;


        //Factory registration
        `uvm_component_utils (spi_m_monitor)

        //virtual interface handle
        virtual spi_if.SPI_MON v_if;

        // Agent_config handle
        spi_m_agent_config m_agt_cfg;

        spi_m_xtn mxtn;

        env_config e_cfg;

        //Connection port
        uvm_analysis_port #(spi_m_xtn) spi_m_mon_port;

        //--------- Standard methods ---------//
        extern function new(string name="spi_m_monitor",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern function void report_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task collect_data();

    endclass

  //-------Constructor new method-------//
        function spi_m_monitor::new(string name="spi_m_monitor",uvm_component parent);
                super.new(name,parent);
                spi_m_mon_port=new("spi_m_mon_port",this);

        endfunction

        //-------build_phase method------//

        function void spi_m_monitor::build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db #(spi_m_agent_config)::get(this," ","spi_m_agent_config",m_agt_cfg))
                `uvm_fatal("config","can't get agent_config from uvm_config_db")

        endfunction

        //---------Connect_phase method-------//
        function void spi_m_monitor::connect_phase(uvm_phase phase);
                super.connect_phase(phase);

                v_if=m_agt_cfg.v_if;

        endfunction

 task spi_m_monitor::run_phase(uvm_phase phase);
        mxtn=spi_m_xtn::type_id::create("mxtn");

        forever
        begin
                collect_data();
        end
        endtask

        task spi_m_monitor::collect_data();

                @(v_if.spi_mon_cb);
                wait(v_if.spi_mon_cb.wb_ack_o);
                mxtn.wb_adr_i=v_if.spi_mon_cb.wb_adr_i;
                mxtn.wb_dat_i=v_if.spi_mon_cb.wb_dat_i;
                mxtn.wb_we_i=v_if.spi_mon_cb.wb_we_i;
                mxtn.wb_stb_i=v_if.spi_mon_cb.wb_stb_i;
                mxtn.wb_cyc_i=v_if.spi_mon_cb.wb_cyc_i;

                if(mxtn.wb_adr_i==5'h10 && mxtn.wb_we_i==1)
                mxtn.ctrl_reg=v_if.spi_mon_cb.wb_dat_i;

                if(mxtn.wb_adr_i==5'h18 && mxtn.wb_we_i==1)
                  mxtn.ss=v_if.spi_mon_cb.wb_dat_i;

                if(mxtn.wb_adr_i==5'h14 && mxtn.wb_we_i==1)
                  mxtn.divider=v_if.spi_mon_cb.wb_dat_i;

                if(mxtn.wb_adr_i==5'h0 && mxtn.wb_we_i==1)
                mxtn.tx0=v_if.spi_mon_cb.wb_dat_i;
		
			if(mxtn.wb_adr_i==5'h4 && mxtn.wb_we_i==1)
                mxtn.tx1=v_if.spi_mon_cb.wb_dat_i;

                if(mxtn.wb_adr_i==5'h8 && mxtn.wb_we_i==1)
                mxtn.tx2=v_if.spi_mon_cb.wb_dat_i;

                if(mxtn.wb_adr_i==5'h12 && mxtn.wb_we_i==1)
                mxtn.tx3=v_if.spi_mon_cb.wb_dat_i;

 if(mxtn.wb_adr_i==5'h0 && mxtn.wb_we_i==0)
                mxtn.rx0=v_if.spi_mon_cb.wb_dat_o;

                if(mxtn.wb_adr_i==5'h4 && mxtn.wb_we_i==0)
                mxtn.rx1=v_if.spi_mon_cb.wb_dat_o;

                if(mxtn.wb_adr_i==5'h8 && mxtn.wb_we_i==0)
                mxtn.rx2=v_if.spi_mon_cb.wb_dat_o;

                if(mxtn.wb_adr_i==5'h12 && mxtn.wb_we_i==0)
                mxtn.rx3=v_if.spi_mon_cb.wb_dat_o;


        `uvm_info("MASTER MONITOR",$sformatf("printing from master monitor \n %s", mxtn.sprint()),UVM_LOW)
          spi_m_mon_port.write(mxtn);

                //increment
                m_agt_cfg.mon_rcvd_xtn_cnt++;
        endtask


function void spi_m_monitor::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: slave Monitor Collected %0d Transactions", m_agt_cfg.mon_rcvd_xtn_cnt), UVM_LOW)

endfunction
