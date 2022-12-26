class spi_sequence extends uvm_sequence #(spi_m_xtn);

`uvm_object_utils(spi_sequence)

 rand uvm_reg_data_t data;

env_config e_cfg;

extern function new(string name = "spi_sequence");

endclass

//Constuctor
function spi_sequence::new(string name = "spi_sequence");
    super.new(name);

endfunction


class m_sequence1 extends spi_sequence;

`uvm_object_utils(m_sequence1)

extern function new(string name = "m_sequence1");
 extern task body();

endclass

function m_sequence1::new(string name = "m_sequence1");
    super.new(name);

endfunction

task m_sequence1::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
            `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?")

        req=spi_m_xtn::type_id::create("req");

        start_item(req);
        assert(req.randomize() with{wb_adr_i==5'h0; wb_we_i==0;});
        $display("reading from rx0=%0d",req.rx0);
        `uvm_info("RX",$sformatf("Configration of RX0 sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

         start_item(req);
        assert(req.randomize() with{wb_adr_i==5'h4; wb_we_i==0;});
        $display("reading from rx1=%0d",req.rx1);
        `uvm_info("RX",$sformatf("Configration of RX1 sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

         start_item(req);
        assert(req.randomize() with{wb_adr_i==5'h8; wb_we_i==0;});
        $display("reading from rx2=%0d",req.rx2);
        `uvm_info("RX",$sformatf("Configration of RX2 sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

         start_item(req);
        assert(req.randomize() with{wb_adr_i==5'h12; wb_we_i==0;});
        $display("reading from rx3=%0d",req.rx3);
        `uvm_info("RX",$sformatf("Configration of RX3 sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

   end

endtask