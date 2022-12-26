    class spi_base_test extends uvm_test;

        //Factory registration
        `uvm_component_utils (spi_base_test)

        // env , agent, agent_config of handles
        env  env_h;
        env_config e_cfg;
        spi_m_agent_config  m_agt_cfg;
        spi_s_agent_config  s_agt_cfg;

        spi_reg_block  block_h;
        //Declaring  local variables to the test class

        bit has_scoreboard=1;
        bit has_spi_m_agent=1;
        bit has_spi_s_agent=1;
        bit has_virtual_seqr=1;

        //--------- Standard UVM Method -----------//
                extern function new (string name = "spi_base_test",uvm_component parent);
                extern function void build_phase (uvm_phase phase);

    endclass
        //-----------------  constructor new method  -------------------//
                function spi_base_test :: new (string name ="spi_base_test",uvm_component parent);
                        super.new(name,parent);

                endfunction

        //------------------- Build_Phase method ----------------//
                function void spi_base_test :: build_phase(uvm_phase phase);
                        super.build_phase(phase);

                        //create env_config object
                        e_cfg=env_config::type_id::create("e_cfg");

                        if(has_spi_m_agent)
                        begin
                                 // create the instance for spi_m_agent_config
                                m_agt_cfg=spi_m_agent_config::type_id::create("m_agt_cfg");

                                //Get the virtual interafce from the config database
                                if(!uvm_config_db #(virtual spi_if)::get(this,"","v_if",m_agt_cfg.v_if))
                                `uvm_fatal("spi_base_test","cannot get the config data from uvm_config_db")

                                //is_active to uvm_active
                                m_agt_cfg.is_active=UVM_ACTIVE;

                                // assign the spi_m_agent_config handle to the enviornment
                                // config's(env_config) spi_m_agent_config handle
                                e_cfg.m_agt_cfg = m_agt_cfg;


                        end

                       if(has_spi_s_agent)
                        begin
                                 // create the instance for spi_m_agent_config
                                s_agt_cfg=spi_s_agent_config::type_id::create("s_agt_cfg");

                                //Get the virtual interafce from the config database
                                if(!uvm_config_db #(virtual spi_if)::get(this,"","v_if",s_agt_cfg.v_if))
                                `uvm_fatal("spi_base_test","cannot get the config data from uvm_config_db")

                                //is_active to uvm_active
                                s_agt_cfg.is_active=UVM_ACTIVE;

                                // assign the spi_m_agent_config handle to the enviornment
                                // config's(env_config) spi_m_agent_config handle
                                e_cfg.s_agt_cfg = s_agt_cfg;

                        end

                        block_h = spi_reg_block::type_id::create("block_h");
                        block_h.build();
                        e_cfg.block_h=block_h;

                        e_cfg.has_scoreboard= has_scoreboard;
                        e_cfg.has_spi_m_agent=has_spi_m_agent;
                        e_cfg.has_spi_s_agent=has_spi_s_agent;
                        e_cfg.has_virtual_seqr=has_virtual_seqr;

                        // set the config object into UVM config DB
                        uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);

                        // create the instance for ram_envh handle
                        env_h=env::type_id::create("env_h", this);



        endfunction

class char_lengths_test extends spi_base_test;

        //Factory Registration
`uvm_component_utils(char_lengths_test);

//virtual seq handle

char_len_vseq vseq_h;

//=============== standard UVM Methods ===================//
extern function new(string name="char_lengths_test",uvm_component parent);
extern function void  build_phase(uvm_phase phase);
extern task run_phase (uvm_phase phase);
endclass

//============= constructor new method =========================//
function char_lengths_test::new(string name="char_lengths_test",uvm_component parent);
super.new(name,parent);
endfunction

//============== build phase method =========================//
function  void char_lengths_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

//=============== Run phase method ========================//
task char_lengths_test::run_phase(uvm_phase phase);

        phase.raise_objection(this);
        vseq_h = char_len_vseq::type_id::create("vseq_h");
        vseq_h.start(env_h.v_seqrh);
        #400;
        phase.drop_objection(this);
endtask

//================lsb====================//
class lsb1_test extends spi_base_test;

        //Factory Registration
`uvm_component_utils(lsb1_test);

//virtual seq handle

lsb1_vseq lsb1_v_h;

//=============== standard UVM Methods ===================//
extern function new(string name="lsb1_test",uvm_component parent);
extern function void  build_phase(uvm_phase phase);
extern task run_phase (uvm_phase phase);
endclass

//============= constructor new method =========================//
function lsb1_test::new(string name="lsb1_test",uvm_component parent);
super.new(name,parent);
endfunction

//============== build phase method =========================//
function  void lsb1_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

//=============== Run phase method ========================//
task lsb1_test::run_phase(uvm_phase phase);

        phase.raise_objection(this);
        lsb1_v_h = lsb1_vseq::type_id::create("lsb1_v_h");
        lsb1_v_h.start(env_h.v_seqrh);
        #400;
        phase.drop_objection(this);
endtask

//================lsb2 ====================//
class lsb2_test extends spi_base_test;

        //Factory Registration
`uvm_component_utils(lsb2_test);

//virtual seq handle

lsb2_vseq lsb2_v_h;

//=============== standard UVM Methods ===================//
extern function new(string name="lsb2_test",uvm_component parent);
extern function void  build_phase(uvm_phase phase);
extern task run_phase (uvm_phase phase);
endclass

//============= constructor new method =========================//
function lsb2_test::new(string name="lsb2_test",uvm_component parent);
super.new(name,parent);
endfunction

//============== build phase method =========================//
function  void lsb2_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

//=============== Run phase method ========================//
task lsb2_test::run_phase(uvm_phase phase);

        phase.raise_objection(this);
        lsb2_v_h = lsb2_vseq::type_id::create("lsb2_v_h");
        lsb2_v_h.start(env_h.v_seqrh);
        #400;
        phase.drop_objection(this);
endtask


//================ txrx1 ====================//
class txrx1_test extends spi_base_test;

        //Factory Registration
`uvm_component_utils(txrx1_test);

//virtual seq handle

txrx1_vseq txrx1_v_h;

//=============== standard UVM Methods ===================//
extern function new(string name="txrx1_test",uvm_component parent);
extern function void  build_phase(uvm_phase phase);
extern task run_phase (uvm_phase phase);
endclass

//============= constructor new method =========================//
function txrx1_test::new(string name="txrx1_test",uvm_component parent);
super.new(name,parent);
endfunction

//============== build phase method =========================//
function  void txrx1_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

//=============== Run phase method ========================//
task txrx1_test::run_phase(uvm_phase phase);

        phase.raise_objection(this);
        txrx1_v_h = txrx1_vseq::type_id::create("txrx1_v_h");
        txrx1_v_h.start(env_h.v_seqrh);
        #400;
        phase.drop_objection(this);
endtask


//================== txrx2 ======================//

class txrx2_test extends spi_base_test;

        //Factory Registration
`uvm_component_utils(txrx2_test);

//virtual seq handle

txrx2_vseq txrx2_v_h;

//=============== standard UVM Methods ===================//
extern function new(string name="txrx2_test",uvm_component parent);
extern function void  build_phase(uvm_phase phase);
extern task run_phase (uvm_phase phase);
endclass

//============= constructor new method =========================//
function txrx2_test::new(string name="txrx2_test",uvm_component parent);
super.new(name,parent);
endfunction

//============== build phase method =========================//
function  void txrx2_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

//=============== Run phase method ========================//
task txrx2_test::run_phase(uvm_phase phase);

        phase.raise_objection(this);
        txrx2_v_h = txrx2_vseq::type_id::create("txrx2_v_h");
        txrx2_v_h.start(env_h.v_seqrh);
        #400;
        phase.drop_objection(this);
endtask


//================slave select=====================//
class ss1_test extends spi_base_test;

        //Factory Registration
`uvm_component_utils(ss1_test);

//virtual seq handle

ss1_vseq ss_v_h;

//=============== standard UVM Methods ===================//
extern function new(string name="ss1_test",uvm_component parent);
extern function void  build_phase(uvm_phase phase);
extern task run_phase (uvm_phase phase);
endclass

//============= constructor new method =========================//
function ss1_test::new(string name="ss1_test",uvm_component parent);
super.new(name,parent);
endfunction

//============== build phase method =========================//
function  void ss1_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

//=============== Run phase method ========================//
task ss1_test::run_phase(uvm_phase phase);

        phase.raise_objection(this);
        ss_v_h = ss1_vseq::type_id::create("ss_v_h");
        ss_v_h.start(env_h.v_seqrh);
        #400;
        phase.drop_objection(this);
endtask

//================ serial clock =====================//
class sclk1_test extends spi_base_test;

        //Factory Registration
`uvm_component_utils(sclk1_test);

//virtual seq handle

sclk1_vseq sclk_v_h;

//=============== standard UVM Methods ===================//
extern function new(string name="sclk1_test",uvm_component parent);
extern function void  build_phase(uvm_phase phase);
extern task run_phase (uvm_phase phase);
endclass

//============= constructor new method =========================//
function sclk1_test::new(string name="sclk1_test",uvm_component parent);
super.new(name,parent);
endfunction

//============== build phase method =========================//
function  void sclk1_test::build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

//=============== Run phase method ========================//
task sclk1_test::run_phase(uvm_phase phase);

        phase.raise_objection(this);
        sclk_v_h = sclk1_vseq::type_id::create("sclk_v_h");
        sclk_v_h.start(env_h.v_seqrh);
        #400;
        phase.drop_objection(this);
endtask
