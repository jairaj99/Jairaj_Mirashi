   class virtual_seq extends uvm_sequence #(uvm_sequence_item);

        //Factory registration
        `uvm_object_utils (virtual_seq)

        // Handles for master and slave sequnecers
        spi_m_sequencer m_seqrh;
        spi_s_sequencer s_seqrh;

        //Virtual sequencer handle
        virtual_seqr v_seqrh;

        // runing  sequence handle
        char_len_seq1  len_h1;
        m_sequence1 m_seq1;
        ss1 ss_s_h;
        miso_seq miso_h;

        sclk1 sclk_s_h;

        lsb1 lsb_h1;
        lsb2 lsb_h2;

        txneg1 txrx_h1;
        rxneg1 txrx_h2;

        //env_config handle
        env_config e_cfg;

	        //---------Standard UVM Methods -------//

        extern function new (string name ="virtual_seq");
        extern task body();

   endclass


        //-----Constructor new method -------//
        function virtual_seq ::new(string name ="virtual_seq");
                super.new(name);

        endfunction

       //---------- Task body() ----------//

        task virtual_seq::body();

                //Get  the config object from uvm_config_db
                if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))

                `uvm_fatal("config","can't get env-config from uvm_config_db")

                assert($cast(v_seqrh,m_sequencer))
                else
                        begin

                        `uvm_error("Body","the  error in $cast of virtual sequnecer")

                        end

                        //Assign handle of virtual sequnecer
                        m_seqrh=v_seqrh.m_seqrh;
                        s_seqrh=v_seqrh.s_seqrh;
        endtask
//================= char len =========================//
   class  char_len_vseq extends virtual_seq ;


        //Factory registration
        `uvm_object_utils (char_len_vseq)



        //--------Standard UVM method ------//
        extern function new (string name ="char_len_vseq");
        extern task body();

   endclass

        //----------Constructor new method -------//
        function char_len_vseq :: new (string name ="char_len_vseq");

                super.new(name);
        endfunction
      //--------Task body -------//

        task  char_len_vseq ::  body();

                super.body();

                len_h1 = char_len_seq1::type_id::create ("len_h1");

                m_seq1  = m_sequence1::type_id::create ("m_seq1");

                miso_h= miso_seq::type_id::create("miso_h");
        begin
                begin

                len_h1.start(m_seqrh);

                end

                 begin

                miso_h.start(s_seqrh);

                end

                 begin

                m_seq1.start(m_seqrh);

                end

        end
        endtask

//================== Slave select ===========//
class  ss1_vseq extends virtual_seq ;


        //Factory registration
        `uvm_object_utils (ss1_vseq)



        //--------Standard UVM method ------//
        extern function new (string name ="ss1_vseq");
        extern task body();

   endclass

        //----------Constructor new method -------//
        function ss1_vseq :: new (string name ="ss1_vseq");

                super.new(name);
        endfunction
 //--------Task body -------//

        task  ss1_vseq ::  body();

                super.body();

                ss_s_h = ss1::type_id::create("ss_s_h");

                m_seq1  = m_sequence1::type_id::create ("m_seq1");

                miso_h= miso_seq::type_id::create("miso_h");

        begin

                begin

                ss_s_h.start(m_seqrh);

                end


                begin

                miso_h.start(s_seqrh);

                end

                begin

                m_seq1.start(m_seqrh);

                end
        end

endtask


class  sclk1_vseq extends virtual_seq ;


        //Factory registration
        `uvm_object_utils (sclk1_vseq)



        //--------Standard UVM method ------//
        extern function new (string name ="sclk1_vseq");
        extern task body();

   endclass

        //----------Constructor new method -------//
        function sclk1_vseq :: new (string name ="sclk1_vseq");

                super.new(name);
        endfunction
 //--------Task body -------//

 task  sclk1_vseq ::  body();

                super.body();

                sclk_s_h=sclk1::type_id::create("sclk_s_h");

                m_seq1  = m_sequence1::type_id::create ("m_seq1");

                miso_h= miso_seq::type_id::create("miso_h");

        begin

                begin

                sclk_s_h.start(m_seqrh);

                end

                begin

                miso_h.start(s_seqrh);

                end

                begin

                m_seq1.start(m_seqrh);

                end

        end
endtask

//==================lsb 1====================//
class  lsb1_vseq extends virtual_seq ;


        //Factory registration
        `uvm_object_utils (lsb1_vseq)


        //--------Standard UVM method ------//
        extern function new (string name ="lsb1_vseq");
        extern task body();

   endclass

        //----------Constructor new method -------//
        function lsb1_vseq :: new (string name ="lsb1_vseq");

                super.new(name);
        endfunction
 //--------Task body -------//

        task  lsb1_vseq ::  body();

                super.body();

                lsb_h1 = lsb1::type_id::create ("lsb_h1");

                m_seq1  = m_sequence1::type_id::create ("m_seq1");

                miso_h= miso_seq::type_id::create("miso_h");

       begin
                begin

                lsb_h1.start(m_seqrh);

                end

                 begin

                miso_h.start(s_seqrh);

                end

                begin

                m_seq1.start(m_seqrh);

                end

        end
        endtask

//=================lsb2======================//
class  lsb2_vseq extends virtual_seq ;


        //Factory registration
        `uvm_object_utils (lsb2_vseq)


        //--------Standard UVM method ------//
        extern function new (string name ="lsb2_vseq");
        extern task body();

   endclass

        //----------Constructor new method -------//
        function lsb2_vseq :: new (string name ="lsb2_vseq");
                super.new(name);
        endfunction

 //--------Task body -------//

 task  lsb2_vseq ::  body();

                super.body();

                lsb_h2 = lsb2::type_id::create ("lsb_h2");

               m_seq1  = m_sequence1::type_id::create ("m_seq1");

                 miso_h= miso_seq::type_id::create("miso_h");


           begin
                 begin

                 lsb_h2.start(m_seqrh);

                end

                 begin

                miso_h.start(s_seqrh);

                end


                begin

                m_seq1.start(m_seqrh);

                end
         end
        endtask

//================== mosi on tx neg and miso on !rx neg =============//

class  txrx1_vseq extends virtual_seq ;


        //Factory registration
        `uvm_object_utils (txrx1_vseq)


        //--------Standard UVM method ------//
        extern function new (string name ="txrx1_vseq");
        extern task body();

   endclass

        //----------Constructor new method -------//
        function txrx1_vseq :: new (string name ="txrx1_vseq");

                super.new(name);
        endfunction

//--------Task body -------//

        task  txrx1_vseq ::  body();

                super.body();

                txrx_h1 = txneg1::type_id::create ("txrx_h1");

                m_seq1  = m_sequence1::type_id::create ("m_seq1");

               miso_h= miso_seq::type_id::create("miso_h");

        begin

                begin

                txrx_h1.start(m_seqrh);

                end

                 begin

                miso_h.start(s_seqrh);

                end

                 begin

                m_seq1.start(m_seqrh);

                end


        end
 endtask

//===================mosi on !tx neg and miso on rx neg=====================//
class  txrx2_vseq extends virtual_seq ;


        //Factory registration
        `uvm_object_utils (txrx2_vseq)


        //--------Standard UVM method ------//
        extern function new (string name ="txrx2_vseq");
        extern task body();

   endclass

        //----------Constructor new method -------//
        function txrx2_vseq :: new (string name ="txrx2_vseq");

                super.new(name);
        endfunction
//--------Task body -------//

 task  txrx2_vseq ::  body();

                super.body();

               txrx_h2 = rxneg1::type_id::create ("txrx_h2");

               m_seq1  = m_sequence1::type_id::create ("m_seq1");

		   miso_h= miso_seq::type_id::create("miso_h");                

      begin
                begin

                txrx_h2.start(m_seqrh);

                end

                 begin

                miso_h.start(s_seqrh);

                end

                 begin

                m_seq1.start(m_seqrh);

                end

        end
endtask
                                                                      