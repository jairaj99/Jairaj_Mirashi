class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)

uvm_tlm_analysis_fifo #(uart_xtn)fifo_uarth[];
uart_xtn u_data1,u_data2;
uart_xtn u_cov_data1,u_cov_data2;
env_config e_cfg;

int DATA_IO_Verified;

covergroup uart_fcov1;
    option.per_instance=1;

//address
ADD: coverpoint u_cov_data1.wb_addr_i{
                                    bins b1 = {0,1,2,3,4,5};
}

CHAR: coverpoint u_cov_data1.lcr[1:0]{
                                    bins b1 = {2'b00};
                                    bins b2 = {2'b01};
                                    bins b3 = {2'b10};
                                    bins b4 = {2'b11};

}

STOP_BITS: coverpoint u_cov_data1.lcr[2]{
                                    bins b1 = {0,1};
}

PARITY: coverpoint u_cov_data1.lcr[3]{
                                    bins b1 = {0,1};
}

EVEN_ODD_P: coverpoint u_cov_data1.lcr[4]{
                                    bins b1 = {0,1};
}

STICK_P: coverpoint u_cov_data1.lcr[5]{
                                    bins b1 = {0,1};
}

BREAK_CONTROL: coverpoint u_cov_data1.lcr[6]{
                                    bins b1 = {1};
}

WR_EN: coverpoint u_cov_data1.wb_we_i;

endgroup

covergroup uart_fcov2;
    option.per_instance=1;

//address
ADD: coverpoint u_cov_data2.wb_addr_i{
                                    bins b1 = {0,1,2,3,4,5};
}

CHAR: coverpoint u_cov_data2.lcr[1:0]{
                                    bins b1 = {2'b00};
                                    bins b2 = {2'b01};
                                    bins b3 = {2'b10};
                                    bins b4 = {2'b11};

}

STOP_BITS: coverpoint u_cov_data2.lcr[2]{
                                    bins b1 = {0,1};
}

PARITY: coverpoint u_cov_data2.lcr[3]{
                                    bins b1 = {0,1};
}

EVEN_ODD_P: coverpoint u_cov_data2.lcr[4]{
                                    bins b1 = {0,1};
}

STICK_P: coverpoint u_cov_data2.lcr[5]{
                                    bins b1 = {0,1};
}

BREAK_CONTROL: coverpoint u_cov_data2.lcr[6]{
                                    bins b1 = {1};
}

WR_EN: coverpoint u_cov_data2.wb_we_i;

endgroup


extern function new(string name = "scoreboard",uvm_component parent = null);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);



endclass

//Constuctor 
function scoreboard::new(string name = "scoreeboard",uvm_component parent);
    super.new(name,parent);
    uart_fcov1 = new;
    uart_fcov2 = new;

endfunction

//Build_phase 
function void scoreboard::build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg)))
        `uvm_fatal("SCOREBOARD","cannot get e_cfg from uvm_config_db. Have you set it?")
            fifo_uarth = new[e_cfg.no_of_uart_agents];

    foreach(fifo_uarth[i])
        begin
            fifo_uarth[i]=new($sformatf("fifo_uarth[%0d]*",i),this);
        end        
            u_data1 = uart_xtn::type_id::create("u_data1");
            u_data2 = uart_xtn::type_id::create("u_data2");

    super.build_phase(phase);
    
endfunction

//Run_phase
task scoreboard::run_phase(uvm_phase phase);
fork
    begin
        forever
            begin
            fifo_uarth[0].get(u_data1);
            u_cov_data1 = u_data1;
            uart_fcov1.sample();
            compare();
            end
        forever 
            begin 
            fifo_uarth[1].get(u_data2);
            u_cov_data2 = u_data2;
            uart_fcov2.sample();
            compare();
            end
    end

join
endtask

function void scoreboard::compare();
        if((u_data1.thr==u_data2.rb) || (u_data2.thr==u_data1.rb)) //half duplex
                begin
                `uvm_info(get_type_name(), $sformatf("Scoreboard(half_duplex) - Data Match successful"), UVM_MEDIUM)
                xtns_compared++ ;        
                end
        else
                `uvm_error(get_type_name(), $sformatf("\n Scoreboard(half_duplex) Error [Data Mismatch]: \n"))

        


        if((u_data1.thr==u_data2.rb) && (u_data2.thr==u_data1.rb)) //full duplex
                begin
                `uvm_info(get_type_name(), $sformatf("Scoreboard(full_duplex) - Data Match successful"), UVM_MEDIUM)
                xtns_compared++ ;        
                end
        else
                `uvm_error(get_type_name(), $sformatf("\n Scoreboard(full_duplex) Error [Data Mismatch]: \n"))
        
        

        if((mcr[4]==1) && ((u_data1.thr==u_data1.rb) && (u_data2.thr==u_data2.rb))) //loop back
                begin
                `uvm_info(get_type_name(), $sformatf("Scoreboard(full_duplex) - Data Match successful"), UVM_MEDIUM)
                xtns_compared++ ;        
                end
        else
                `uvm_error(get_type_name(), $sformatf("\n Scoreboard(full_duplex) Error [Data Mismatch]: \n"))



        if(lsr[2]==1) //parity error
                        $display("PARITY ERROR");

        if(lsr[3]==1) //framing error
                        $display("FRAMING ERROR");

        if(lsr[1]==1) //overrun error
                        $display("OVERRUN ERROR");

        if(lsr[4]==1) //break interrupt
                        $display("BREAK INTERRUPT");

        if(lsr[5]==1) //THR empty
                        $display("TRANSMITTER HOLDING REGISTER EMPTY INTERRUPT");


endfunction

//Report phase
function void scoreboard::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("MSTB: Simulation Report from ScoreBoard \n Number of Read Transactions compared : %0d \n\n",xtns_compared), UVM_LOW)

endfunction
