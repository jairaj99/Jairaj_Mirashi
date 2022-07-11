class virtual_sequence extends uvm_sequence #(uvm_sequence_item);

`uvm_object_utils(virtual_sequence)

uart_sequencer u_seqrh[];
virtual_sequencer v_seqrh;
env_config e_cfg;




extern function new(string name = "virtual_sequence");
extern task body();

endclass

function virtual_sequence::new(string name = "virtual_sequence");
  super.new(name);

endfunction

task virtual_sequence::body();
  if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
    `uvm_fatal("VIRTUAL_SEQUENCE","cannot get u_agt_cfg from uvm_config_db. Have you set it")

  u_seqrh = new[e_cfg.no_of_uart_agents];

  assert ($cast(v_seqrh,m_sequencer)) 
  else   
    begin
      `uvm_error("BODY", "Error in $cast of virtual sequencer")
    end
  
  foreach(u_seqrh[i])
    u_seqrh[i] = v_seqrh.u_seqrh[i];
  
endtask 

///////////////////////////////////////////////HALF_DUPLEX////////////////////////////////////////////
class vseq1 extends virtual_sequence;
  `uvm_object_utils(vseq1)

  uart_sequence1 u_seq1;
  uart_sequence2 u_seq2;

  extern function new(string name = "vseq1");
  extern task body();

  
endclass 

function vseq1::new(string name = "vseq1");
  super.new(name);

endfunction 

task vseq1::body();
  super.body();

  u_seq1 = uart_sequence1::type_id::create("u_seq1");
  u_seq2 = uart_sequence2::type_id::create("u_seq2");

  if(e_cfg.has_uart_agent)
    begin
      fork
        u_seq1.start(u_seqrh[0]);
        u_seq2.start(u_seqrh[1]);
      join
    end

endtask 


//////////////////////////////////////////////////////?FULL_DUPLEX////////////////////////////////////////
class vseq2 extends virtual_sequence;
  `uvm_object_utils(vseq2)

  uart_sequence3 u_seq3;
  uart_sequence4 u_seq4;

  extern function new(string name = "vseq2");
  extern task body();

  
endclass 

function vseq2::new(string name = "vseq2");
  super.new(name);

endfunction 

task vseq2::body();
  super.body();

  u_seq3 = uart_sequence3::type_id::create("u_seq3");
  u_seq4 = uart_sequence4::type_id::create("u_seq4");

  if(e_cfg.has_uart_agent)
    begin
      fork
        u_seq3.start(u_seqrh[0]);
        u_seq4.start(u_seqrh[1]);
      join
    end

endtask 


/////////////////////////////////////////////////////LOOP_BACK///////////////////////////////////////////
class vseq3 extends virtual_sequence;
  `uvm_object_utils(vseq3)

  uart_sequence5 u_seq5;
  uart_sequence6 u_seq6;

  extern function new(string name = "vseq3");
  extern task body();

  
endclass 

function vseq3::new(string name = "vseq3");
  super.new(name);

endfunction 

task vseq3::body();
  super.body();

  u_seq5 = uart_sequence5::type_id::create("u_seq5");
  u_seq6 = uart_sequence6::type_id::create("u_seq6");

  if(e_cfg.has_uart_agent)
    begin
      fork
        u_seq5.start(u_seqrh[0]);
        u_seq6.start(u_seqrh[1]);
      join
    end

endtask 


///////////////////////////////////////////////////////PARITY/////////////////////////////////////////////////////////////////
class vseq4 extends virtual_sequence;
  `uvm_object_utils(vseq4)

  uart_sequence7 u_seq7;
  uart_sequence8 u_seq8;

  extern function new(string name = "vseq4");
  extern task body();

  
endclass 

function vseq4::new(string name = "vseq4");
  super.new(name);

endfunction 

task vseq4::body();
  super.body();

  u_seq7 = uart_sequence7::type_id::create("u_seq7");
  u_seq8 = uart_sequence8::type_id::create("u_seq8");

  if(e_cfg.has_uart_agent)
    begin
      fork
        u_seq7.start(u_seqrh[0]);
        u_seq8.start(u_seqrh[1]);
      join
    end

endtask 


//////////////////////////////////////FRAMEING_ERROR////////////////////////////////////////
class vseq5 extends virtual_sequence;
  `uvm_object_utils(vseq5)

  uart_sequence9 u_seq9;
  uart_sequence10 u_seq10;

  extern function new(string name = "vseq5");
  extern task body();

  
endclass 

function vseq5::new(string name = "vseq5");
  super.new(name);

endfunction 

task vseq5::body();
  super.body();

  u_seq9 = uart_sequence9::type_id::create("u_seq9");
  u_seq10 = uart_sequence10::type_id::create("u_seq10");

  if(e_cfg.has_uart_agent)
    begin
      fork
        u_seq9.start(u_seqrh[0]);
        u_seq10.start(u_seqrh[1]);
      join
    end

endtask 


//////////////////////////////////////OVER_RUN////////////////////////////////////////
class vseq6 extends virtual_sequence;
  `uvm_object_utils(vseq6)

  uart_sequence11 u_seq11;
  uart_sequence12 u_seq12;

  extern function new(string name = "vseq6");
  extern task body();

  
endclass 

function vseq6::new(string name = "vseq6");
  super.new(name);

endfunction 

task vseq6::body();
  super.body();

  u_seq11 = uart_sequence11::type_id::create("u_seq11");
  u_seq12 = uart_sequence12::type_id::create("u_seq12");

  if(e_cfg.has_uart_agent)
    begin
      fork
        u_seq11.start(u_seqrh[0]);
        u_seq12.start(u_seqrh[1]);
      join
    end

endtask

//////////////////////////////////////BREAK_INTERRUPT////////////////////////////////////////
class vseq7 extends virtual_sequence;
  `uvm_object_utils(vseq7)

  uart_sequence13 u_seq13;
  uart_sequence14 u_seq14;

  extern function new(string name = "vseq7");
  extern task body();

  
endclass 

function vseq7::new(string name = "vseq7");
  super.new(name);

endfunction 

task vseq7::body();
  super.body();

  u_seq13 = uart_sequence13::type_id::create("u_seq13");
  u_seq14 = uart_sequence14::type_id::create("u_seq14");

  if(e_cfg.has_uart_agent)
    begin
      fork
        u_seq13.start(u_seqrh[0]);
        u_seq14.start(u_seqrh[1]);
      join
    end

endtask 


//////////////////////////////////////TIME_OUT////////////////////////////////////////
class vseq8 extends virtual_sequence;
  `uvm_object_utils(vseq8)

  uart_sequence15 u_seq15;
  uart_sequence16 u_seq16;

  extern function new(string name = "vseq8");
  extern task body();

  
endclass 

function vseq8::new(string name = "vseq8");
  super.new(name);

endfunction 

task vseq8::body();
  super.body();

  u_seq15 = uart_sequence15::type_id::create("u_seq15");
  u_seq16 = uart_sequence16::type_id::create("u_seq16");

  if(e_cfg.has_uart_agent)
    begin
      fork
        u_seq15.start(u_seqrh[0]);
        u_seq16.start(u_seqrh[1]);
      join
    end

endtask 

//////////////////////////////////////BREAK_INTERRUPT////////////////////////////////////////
class vseq9 extends virtual_sequence;
  `uvm_object_utils(vseq9)

  uart_sequence17 u_seq17;
  uart_sequence18 u_seq18;

  extern function new(string name = "vseq9");
  extern task body();

  
endclass 

function vseq9::new(string name = "vseq9");
  super.new(name);

endfunction 

task vseq9::body();
  super.body();

  u_seq17 = uart_sequence17::type_id::create("u_seq17");
  u_seq18 = uart_sequence18::type_id::create("u_seq18");

  if(e_cfg.has_uart_agent)
    begin
      fork
        u_seq17.start(u_seqrh[0]);
        u_seq18.start(u_seqrh[1]);
      join
    end

endtask 