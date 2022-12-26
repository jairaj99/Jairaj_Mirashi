    class spi_s_driver extends uvm_driver #(spi_s_xtn);

        //Factory registration

        `uvm_component_utils(spi_s_driver)

        //virtual interface handle
        virtual spi_if.SPI_DRV v_if;

        // agent config handle

        spi_s_agent_config s_agt_cfg;

        env_config e_cfg;

        //spi reg block handle
        spi_reg_block block_h;


        //--------- Standard methods -------//

        extern function new (string name="spi_s_driver",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern function void connect_phase(uvm_phase phase);
        extern function void report_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task send_to_dut(spi_s_xtn s_xtn);
     endclass

       //-------Constructor new method -------//
        function spi_s_driver::new(string name="spi_s_driver",uvm_component parent);
                super.new(name,parent);

        endfunction

      //-------- Build_phase method -----//
        function void spi_s_driver::build_phase(uvm_phase phase);
                super.build_phase(phase);

                if(!uvm_config_db #(spi_s_agent_config)::get(this," ","spi_s_agent_config",s_agt_cfg))

                `uvm_fatal("config","can't get agent_config from uvm_config_db");

                if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))

                `uvm_fatal("e_cfg","cannot get the config data")

      endfunction

       //--------Connect_phase---------//
        function void spi_s_driver::connect_phase(uvm_phase phase);

                super.connect_phase(phase);
                v_if=s_agt_cfg.v_if;

        endfunction

        //-----------Run_Phase------------//
        task spi_s_driver::run_phase(uvm_phase phase);

                forever
                        begin
                                seq_item_port.get_next_item(req);
                                $display("send data");
                                send_to_dut(req);
                                $display("data sent");
                                seq_item_port.item_done();
                        end
        endtask

        //--------------send to dut------------------//
        task spi_s_driver::send_to_dut(spi_s_xtn s_xtn);

                uvm_status_e status;
                bit[31:0] ctrl;

                e_cfg.block_h.ctrl_regh.read(status, ctrl, UVM_BACKDOOR);

                $display("ctrl=%0d",ctrl);

         //print transaction
    `uvm_info("SPI_SLAVE_DRIVER",$sformatf("printing from driver \n  %s",s_xtn.sprint()),UVM_MEDIUM)

   if(ctrl[6:0]==0)
                        begin
                                $display("char len");
                                if(ctrl[11])//lsb bit checking
                                        begin
                                                for(int i=0;i<128;i++)

                                        begin
                                                if(ctrl[9])
                                                begin
									@(posedge v_if.spi_drv_cb.sclk_pad_o)
									 v_if.spi_drv_cb.miso_pad_i<=s_xtn.miso_pad_i[i];
 $display("SLAVE DRIVER IS ENTERING AFTER POSEDGE,LSB==1,RXNEG==1 i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

                                			end


						  else
                                                        begin
                                                          @(negedge v_if.spi_drv_cb.sclk_pad_o)
                                              
                                                  v_if.spi_drv_cb.miso_pad_i<=s_xtn.miso_pad_i[i];
$display("SLAVE DRIVER IS ENTERING AFTER NEGEDGE,LSB==1,RXNEG==O i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);
        end
                                        end
                                        end
                                else
                                        begin

                                                for(int i=127;i>=0;i--)
                                        begin

                                        if(ctrl[9])//rx_neg checking
                                                begin

                                                        @(posedge v_if.spi_drv_cb.sclk_pad_o)
                                                        v_if.spi_drv_cb.miso_pad_i<=s_xtn.miso_pad_i[i];
 $display("SLAVE DRIVER IS ENTERING AFTER POSEDGE,LSB==0,RXNEG==1 i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

            				    end

					  else
                                                begin
                                                        @(negedge v_if.spi_drv_cb.sclk_pad_o)
                                                        v_if.spi_drv_cb.miso_pad_i<=s_xtn.miso_pad_i[i];
$display("SLAVE DRIVER IS ENTERING AFTER NEGEDGE,LSB==0,RXNEG==0 i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

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
                                                                @(posedge v_if.spi_drv_cb.sclk_pad_o)
                                                                v_if.spi_drv_cb.miso_pad_i<=s_xtn.miso_pad_i[i];
$display("SLAVE DRIVER IS ENTERING AFTER POSEDGE i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

                        end

                                                else

                                                        begin
                                                                @(negedge v_if.spi_drv_cb.sclk_pad_o)
                                                                v_if.spi_drv_cb.miso_pad_i<=s_xtn.miso_pad_i[i];

$display("SLAVE DRIVER IS ENTERING AFTER NEGEDGE i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);
                                end

                                        end
                                        end

        else
                                           begin

                                                  for(int i=ctrl[6:0]-1;i>=0;i--)
                                             begin

                                            if(ctrl[9])//rx_neg checking
                                                    begin

                                                            @(posedge v_if.spi_drv_cb.sclk_pad_o)
                                                            v_if.spi_drv_cb.miso_pad_i<=s_xtn.miso_pad_i[i];
 $display("SLAVE DRIVER IS ENTERING AFTER POSEDGEEEEEEEEE i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

                                                   end

                                         else
                                                 begin

                                                           @(negedge v_if.spi_drv_cb.sclk_pad_o)
                                                            v_if.spi_drv_cb.miso_pad_i<=s_xtn.miso_pad_i[i];
$display("SLAVE DRIVER IS ENTERING AFTER NEGEDGEEEEEEEEEEEEEE i = %d , mosi =%b, miso =%b", i,s_xtn.mosi_pad_o[i],s_xtn.miso_pad_i[i]);

                                                  end
                                            end
                                            end

                        end

       #100;

        //increment drv_data_sent_cnt
        s_agt_cfg.drv_data_sent_cnt++;

endtask


function void spi_s_driver::report_phase(uvm_phase phase);
  `uvm_info(get_type_name(), $sformatf("Report: uart driver sent %0d transactions", s_agt_cfg.drv_data_sent_cnt), UVM_LOW)

endfunction



		