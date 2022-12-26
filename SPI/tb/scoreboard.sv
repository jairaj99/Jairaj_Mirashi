class scoreboard extends uvm_scoreboard;

        //Factory Registration
        `uvm_component_utils(scoreboard)

        uvm_tlm_analysis_fifo #(spi_m_xtn) m_fifo;
        uvm_tlm_analysis_fifo #(spi_s_xtn) s_fifo;

        env_config e_cfg;

        spi_m_xtn m_data;
        spi_s_xtn s_data;

        spi_m_xtn m_cov_data;
        spi_s_xtn s_cov_data;

        int xtns_compared;

        covergroup m_cg;
                option.per_instance=1;

        CHAR_LEN: coverpoint m_data.ctrl_reg[6:0]{
                                        bins c2 = {[7'b1111111:7'b0000000]};
                                                }

        GO_BUSY: coverpoint m_data.ctrl_reg[8]{
                                        bins g1 = {1,0};
                                                }
	          LSB: coverpoint m_data.ctrl_reg[11]{
                                        bins l1 = {0,1};
                                            }

        TX_NEG: coverpoint m_data.ctrl_reg[10]{
                                        bins t1 = {0,1};
                                                }

        RX_NEG: coverpoint m_data.ctrl_reg[9]{
                                        bins r1 = {0,1};
                                                }


        ASS: coverpoint m_data.ctrl_reg[13]{
                                        bins a1 = {0,1};
                                                }


        DIVDER: coverpoint m_data.divider[15:0]{
                                        bins d1 = {[16'hffff:16'h0000]};
                                                }
        SS_REG: coverpoint m_data.ss[31:0]{
                                bins s ={32'h01}; }

        endgroup

        extern function new(string name = "scoreboard",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
        extern task run_phase(uvm_phase phase);
        extern task compare();
        extern function void report_phase(uvm_phase phase);

endclass

//===================== constructor ========================//
function scoreboard::new(string name="scoreboard", uvm_component parent);
        super.new(name,parent);

        m_cg = new;
        s_cg = new;

endfunction

//======================= Build_phase =========================//
function void scoreboard::build_phase(uvm_phase phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
                `uvm_fatal("SCOREBOARD","cannot get e_cfg from uvm_config_db. Have you set it?")

                m_data = spi_m_xtn::type_id::create("m_data");
                s_data = spi_s_xtn::type_id::create("s_data");

                m_fifo = new("m_fifo",this);
                s_fifo = new("s_fifo",this);

        super.build_phase(phase);

endfunction

//====================== run_phase ========================//
task scoreboard::run_phase(uvm_phase phase);
   fork
        forever
                begin
                        m_fifo.get(m_data);
                        m_cov_data = m_data;
                        `uvm_info("m_data","data" , UVM_LOW)
                //      m_fifo.print();
                        m_cg.sample();
                        m_fifo.print();
                end
        forever
                begin
                        s_fifo.get(s_data);
                        s_cov_data = s_data;
                        `uvm_info("s_data"," data" , UVM_LOW)
                //      s_fifo.print();
                        s_cg.sample();
                        s_fifo.print();
                        compare();
                end
   join
endtask

//===================== compare ====================//
task scoreboard::compare();

        if(m_data.ctrl_reg[6:0]==0)  // char len is zero

                        if(((m_data.tx0 == m_data.rx0) || (m_data.tx1 == m_data.rx1) || (m_data.tx2 == m_data.rx2) || (m_data.tx3 == m_data.rx3)))
                                begin
                                        $display("data comparision successfull");
                                        xtns_compared++;
                                end


        if (m_data.ctrl_reg[6:0]!=0)  // char len is not zero

                for(int i=0;i<m_data.ctrl_reg[6:0]-1;i++)

                        begin
                                if(((m_data.tx0[i] == m_data.rx0[i]) || (m_data.tx1[i] == m_data.rx1[i]) || (m_data.tx2[i] == m_data.rx2[i]) || (m_data.tx3[i] == m_data.rx3[i])))
                                        begin
                                                $display(" comparision successfull");
                                                xtns_compared++;
                                        end

                                else
                                        begin
                                                $dislplay("comparision unsuccessfull");
                                        end

                        end
        else
                for(int i=m_data.ctrl_reg[6:0]-1;i>=0;i--)

                        begin
                                if(((m_data.tx0[i] == m_data.rx0[i]) || (m_data.tx1[i] == m_data.rx1[i]) || (m_data.tx2[i] == m_data.rx2[i]) || (m_data.tx3[i] == m_data.rx3[i])))
                                        begin
                                                $display("data matching successfull");
                                                xtns_compared++;
                                        end

                                else
                                        begin
                                                $dislplay("data matching unsuccessfull");
                                        end
                        end

endtask


//====================== report phase ======================//
function void scoreboard::report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf(" Simulation Report from ScoreBoard \n Number of Transactions compared : %0d \n\n",xtns_compared), UVM_LOW)
endfunction

