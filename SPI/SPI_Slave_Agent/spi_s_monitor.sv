  class spi_s_monitor extends uvm_monitor;


        //Factory registration
        `uvm_component_utils (spi_s_monitor)

        //virtual interface handle
        virtual spi_if.SPI_MON v_if;

        // Agent_config handle
        spi_s_agent_config s_agt_cfg;
        env_config e_cfg;
//      spi_reg_block block_h;
        spi_s_xtn s_xtn;
        //Connection port
        uvm_analysis_port #(spi_s_xtn) spi_mon_port;

        //--------- Standard methods ---------//
        extern function new(string name="spi_s_monitor",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern function void report_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task collect_data();

    endclass

     //-------Constructor new method-------//
        function spi_s_monitor::new(string name="spi_s_monitor",uvm_component parent);
                super.new(name,parent);
        spi_mon_port = new("spi_mon_port",this);

        endfunction

       //-------build_phase method------//

        function void spi_s_monitor::build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db #(spi_s_agent_config)::get(this," ","spi_s_agent_config",s_agt_cfg))
                `uvm_fatal(get_type_name(),"can't get agent_config from uvm_config_db")

                if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
                 `uvm_fatal(get_type_name(),"cannot get the config data")

        endfunction

        //---------Connect_phase method-------//
        function void spi_s_monitor::connect_phase(uvm_phase phase);
                super.connect_phase(phase);

                v_if=s_agt_cfg.v_if;

        endfunction

     //--------------Run_phase------//
        task spi_s_monitor::run_phase(uvm_phase phase);
        forever
        begin
                #400;
                collect_data();
                $display("received/collected data");
        end
        endtask

   //------------Collect_data------//
        task spi_s_monitor::collect_data();
                uvm_status_e status;
                bit [31:0] ctrl;
                spi_reg_block block_h;
                s_xtn = spi_s_xtn::type_id::create("s_xtn");

                e_cfg.block_h.ctrl_regh.read(status, ctrl, UVM_BACKDOOR);

                $display("From the slave monitor ctrl=%0d",ctrl);

                 $display("from the slave monitor = %0d",e_cfg.block_h.ctrl_regh);

                @(v_if.spi_mon_cb.wb_ack_o);
if(ctrl[6:0]==0)
 begin

                 if(ctrl[11])//lsb bit checking
                 begin
                                                for(int i=0;i<128;i++)

                                                begin
                                                if(ctrl[9]) //rx_neg

                                                        begin
                                                                @(posedge v_if.spi_mon_cb.sclk_pad_o)
                                                                s_xtn.mosi_pad_o[i]=v_if.spi_mon_cb.mosi_pad_o;
                                                                s_xtn.miso_pad_i[i]=v_if.spi_mon_cb.miso_pad_i;
$display("SLAVE MONITOR IS ENTERING AFTER POSEDGE,LSB==1,RXNEG==1, i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

									 end

								  else

                                                        begin
                                                                @(negedge v_if.spi_mon_cb.sclk_pad_o)
                                                                s_xtn.mosi_pad_o[i]=v_if.spi_mon_cb.mosi_pad_o;
                                                                s_xtn.miso_pad_i[i]=v_if.spi_mon_cb.miso_pad_i;
$display("SLAVE MONITOR IS ENTERING AFTER NEGEDGE,LSB=1,RXNEG=0, i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

                                                        end
                                                end
                                        end

						   else
                                        begin

                                                for(int i=127;i>=0;i--)
                                                begin

                                        if(ctrl[9]) //rx_neg
                                                begin
                                                         @(posedge v_if.spi_mon_cb.sclk_pad_o);
                                                          s_xtn.mosi_pad_o[i]=v_if.spi_mon_cb.mosi_pad_o;
                                                          s_xtn.miso_pad_i[i]=v_if.spi_mon_cb.miso_pad_i;
$display("SLAVE MONITOR IS ENTERING AFTER POSEDGE,LSB==0,RXNEG==1, i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

                                                end

					     else
                                                begin
                                                        @(negedge v_if.spi_mon_cb.sclk_pad_o);
                                                          s_xtn.mosi_pad_o[i]=v_if.spi_mon_cb.mosi_pad_o;
                                                          s_xtn.miso_pad_i[i]=v_if.spi_mon_cb.miso_pad_i;
$display("SLAVE MONITOR IS ENTERING AFTER NEGEDGE,LSB==0,RXNEG==0 i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

                                                end
                                                end
                                       end

                end

	   else
     begin

                                if(ctrl[11])//lsb bit checking

                                        begin
                                                for(int i=0;i<ctrl[6:0]-1;i++)
                                              begin
                                                      if(ctrl[9])//rx_neg checking

                                                        begin
                                                                 @(posedge v_if.spi_mon_cb.sclk_pad_o);
                                                                 s_xtn.mosi_pad_o[i]=v_if.spi_mon_cb.mosi_pad_o;
                                                                s_xtn.miso_pad_i[i]= v_if.spi_mon_cb.miso_pad_i;
$display("SLAVE MONITOR IS ENTERING AFTER POSEDGE i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

                                                        end

				                  else

                                                        begin
                                                                 @(negedge v_if.spi_mon_cb.sclk_pad_o);
                                                               s_xtn.mosi_pad_o[i]=v_if.spi_mon_cb.mosi_pad_o;
                                                               s_xtn.miso_pad_i[i]= v_if.spi_mon_cb.miso_pad_i;
$display("SLAVE MONITOR IS ENTERING AFTER NEGEDGE i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

                                                        end

                                                end
                                        end


			  else
                                           begin

                                                  for(int i=ctrl[6:0]-1;i>=0;i--)
                                                   begin

                                            if(ctrl[9])//rx_neg checking
                                                    begin
                                                            @(posedge v_if.spi_mon_cb.sclk_pad_o);
                                                                s_xtn.mosi_pad_o[i]=v_if.spi_mon_cb.mosi_pad_o;
                                                                s_xtn.miso_pad_i[i]=v_if.spi_mon_cb.miso_pad_i;
                                                
$display("SLAVE MONITOR IS ENTERING AFTER POSEDGEEEEEEEEEEEEEEE  i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);


                                                     end
		
			       else
                                                 begin
                                                           @(negedge v_if.spi_mon_cb.sclk_pad_o);
                                                           s_xtn.mosi_pad_o[i]=v_if.spi_mon_cb.mosi_pad_o;
                                                           s_xtn.miso_pad_i[i]=v_if.spi_mon_cb.miso_pad_i;
$display("SLAVE MONITOR IS ENTERING AFTER NEGEDGEEEEEEEEEEEEEEEE i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);
                                                end

                                            end
                                            end
        end



         `uvm_info("SLAVE MONITOR",$sformatf("printing from slave monitor \n %s", s_xtn.sprint()),UVM_LOW)
          spi_mon_port.write(s_xtn);  // sending  xtn data to scoreboard using analysis port whose handle name is mon_port

//increment
    s_agt_cfg.mon_rcvd_xtn_cnt++;

endtask

function void spi_s_monitor::report_phase(uvm_phase phase);
`uvm_info(get_type_name(), $sformatf("Report: slave Monitor Collected %0d Transactions", s_agt_cfg.mon_rcvd_xtn_cnt), UVM_LOW)

endfunction
