   class spi_reg_seq extends uvm_sequence #(spi_m_xtn);

        /*Factory registration */
        `uvm_object_utils (spi_reg_seq)

        //reg_block handle
        spi_reg_block block_h;

        // env_config  handle
        env_config e_cfg ;

        //------Constructor new method
        function new (string name ="spi_reg_seq");
                super.new(name);
        endfunction

        //Properties used by the various register access methods
        rand uvm_reg_data_t data ;// for passing data
        rand uvm_reg_data_t ctrl_data;
        rand uvm_reg_data_t ss_data;

              uvm_status_e status;//Returning access status
        spi_m_xtn xtn;

        //------ Sequence body----//
        task body ;

                if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
                        begin
                        `uvm_error("Body","Could not find env_config")
                        end

                block_h =e_cfg.block_h;

        endtask

   endclass

//////////////////////////CHAR_LENGTHS//////////////////////////////
class char_len_seq1 extends spi_reg_seq ;

        //Factory registration
        `uvm_object_utils(char_len_seq1)


        //-----Constructor new method -------//
        function new (string name ="char_len_seq1");
                super.new(name);

        endfunction

        //---------Run_phase method-------//
        task body ;
                super.body;


                 block_h.ss_h.write(status, .value(32'h01));
                 block_h.dvd_h.write(status, .value(32'h02));
                 block_h.rxtx_h0.write(status, .value(32'd5));
                 block_h.rxtx_h1.write(status, .value(32'd1));
                 block_h.rxtx_h2.write(status, .value(32'd2));
                 block_h.rxtx_h3.write(status, .value(32'd3));

	
			        if(!block_h.ctrl_regh.randomize() with {char_len.value inside {0, 1, [2:48], [49:62], [65:85], [86:122], 127};})
                begin
                        `uvm_error("CHARACTER LENGTH","Control Register Randomisation failed for char length")
                end

                block_h.ctrl_regh.go_busy.set((1));
                block_h.ctrl_regh.tx_neg.set((1'b1));
                block_h.ctrl_regh.rx_neg.set((1'b0));
                block_h.ctrl_regh.lsb.set((1'b1));
                block_h.ctrl_regh.ie.set((1'b0));
                block_h.ctrl_regh.ass.set((1'b1));
                block_h.ctrl_regh.update(status, .path(UVM_FRONTDOOR), .parent(this));
                data = block_h.ctrl_regh.get();

endtask

endclass

/////////////////////LSB/MSB_First/////////////////////////////
class lsb1 extends spi_reg_seq ;

        //Factory registration
        `uvm_object_utils(lsb1)


        //-----Constructor new method -------//
        function new (string name ="lsb1");
                super.new(name);

        endfunction

        //---------Run_phase method-------//
        task body ;
                super.body;

                block_h.ss_h.write(status, .value(8'h01));
                block_h.dvd_h.write(status, .value(16'h01));
                block_h.rxtx_h0.write(status, .value(32'h32));
                block_h.rxtx_h1.write(status, .value(32'h48));
                block_h.rxtx_h2.write(status, .value(32'h71));
                block_h.rxtx_h3.write(status, .value(32'h93));
                block_h.ctrl_regh.go_busy.set((1));
                block_h.ctrl_regh.char_len.set((7'b0000111));
                block_h.ctrl_regh.tx_neg.set((1'b0));
                block_h.ctrl_regh.rx_neg.set((1'b1));
                block_h.ctrl_regh.lsb.set((1'b1));
                block_h.ctrl_regh.ie.set((1'b0));
                block_h.ctrl_regh.ass.set((1'b1));
                block_h.ctrl_regh.update(status, .path(UVM_FRONTDOOR), .parent(this));
			
		     data = block_h.ctrl_regh.get();
                $display("rxtx_h0:%0d,rxtx_h1:%0d,rxtx_h2:%0d,rxtx_h3:%0d",block_h.rxtx_h0,block_h.rxtx_h1,block_h.rxtx_h2,block_h.rxtx_h3);

endtask

endclass

//-------------------------------------------------------------------------------------------------------------------//
class lsb2 extends spi_reg_seq ;

        //Factory registration
        `uvm_object_utils(lsb2)


        //-----Constructor new method -------//
        function new (string name ="lsb2");
                super.new(name);

        endfunction

        //---------Run_phase method-------//
        task body ;
                super.body;

                block_h.ss_h.write(status, .value(32'h05));
                block_h.dvd_h.write(status, .value(32'h04));
                block_h.rxtx_h0.write(status, .value(32'd20));
                block_h.rxtx_h1.write(status, .value(32'h00));
                block_h.rxtx_h2.write(status, .value(8'd5));
                block_h.rxtx_h3.write(status, .value(8'd5));
                block_h.ctrl_regh.go_busy.set((1));
                block_h.ctrl_regh.char_len.set((7'b0000111));
                block_h.ctrl_regh.tx_neg.set((1'b1));
                block_h.ctrl_regh.rx_neg.set((1'b0));
                block_h.ctrl_regh.lsb.set((1'b0));
                block_h.ctrl_regh.ie.set((1'b0));
                block_h.ctrl_regh.ass.set((1'b1));
                block_h.ctrl_regh.update(status, .path(UVM_FRONTDOOR), .parent(this));
                data = block_h.ctrl_regh.get();
endtask

endclass

/////////////////////////////////////////////////MOSI on TX NEG and MISO on !RX_NEG(Posedge)///////////////////////////////
class txneg1 extends spi_reg_seq ;

        //Factory registration
        `uvm_object_utils(txneg1)


        //-----Constructor new method -------//
        function new (string name ="txneg1");
                super.new(name);

        endfunction

        //---------Run_phase method-------//
        task body ;
                super.body;

                block_h.ss_h.write(status, .value(32'h05));
                block_h.dvd_h.write(status, .value(32'h04));
                block_h.rxtx_h0.write(status, .value(8'd5));
                block_h.rxtx_h1.write(status, .value(8'd3));
                block_h.rxtx_h2.write(status, .value(8'd2));
                block_h.rxtx_h3.write(status, .value(8'd1));
                block_h.ctrl_regh.go_busy.set((1));
                block_h.ctrl_regh.char_len.set((7'b0000111));
                block_h.ctrl_regh.tx_neg.set((1'b1));
                block_h.ctrl_regh.rx_neg.set((1'b0));
                block_h.ctrl_regh.lsb.set((1'b1));
                block_h.ctrl_regh.ie.set((1'b0));
                block_h.ctrl_regh.ass.set((1'b1));
                block_h.ctrl_regh.update(status, .path(UVM_FRONTDOOR), .parent(this));
                data = block_h.ctrl_regh.get();
endtask

endclass

/////////////////////////////MISO on RX NEG and MOSI on !TX_NEG(Posedge)//////////////////////
class rxneg1 extends spi_reg_seq ;

        //Factory registration
        `uvm_object_utils(rxneg1)


        //-----Constructor new method -------//
        function new (string name ="rxneg1");
                super.new(name);

        endfunction

        //---------Run_phase method-------//
        task body ;
                super.body;

                block_h.ss_h.write(status, .value(32'h05));
                block_h.dvd_h.write(status, .value(32'h04));
                block_h.rxtx_h0.write(status, .value(8'd5));
                block_h.rxtx_h1.write(status, .value(8'd3));
                block_h.rxtx_h2.write(status, .value(8'd2));
                block_h.rxtx_h3.write(status, .value(8'd1));

                block_h.ctrl_regh.go_busy.set((1));
                block_h.ctrl_regh.char_len.set((7'b0000111));
                block_h.ctrl_regh.tx_neg.set((1'b0));
                block_h.ctrl_regh.rx_neg.set((1'b1));
                block_h.ctrl_regh.lsb.set((1'b1));
                block_h.ctrl_regh.ie.set((1'b0));
                block_h.ctrl_regh.ass.set((1'b1));
                block_h.ctrl_regh.update(status, .path(UVM_FRONTDOOR), .parent(this));
		    data = block_h.ctrl_regh.get();

endtask

endclass

/////////////////////////varaible sclk frequencies//////////////////////////////////////
class sclk1 extends spi_reg_seq ;

        //Factory registration
        `uvm_object_utils(sclk1)


        //-----Constructor new method -------//
        function new (string name ="sclk1");
                super.new(name);

        endfunction

        //---------Run_phase method-------//
        task body ;
                super.body;


                 block_h.ss_h.write(status, .value(32'h01));

                  if(!this.randomize() with {data inside {[1:128],[129:1024],[1025:65535]};}) //0-65535
                        begin
                                `uvm_error("Srial CLock Frequencies","Divider Register Randomisation failed")
                        end
			
			
                block_h.dvd_h.write(status, data, .parent(this));
                // block_h.dvd_h.write(status, .value(32'h05));
                 block_h.rxtx_h0.write(status, .value(32'd5));
                 block_h.rxtx_h1.write(status, .value(32'd1));
                 block_h.rxtx_h2.write(status, .value(32'd2));
                 block_h.rxtx_h3.write(status, .value(32'd3));
                 block_h.ctrl_regh.go_busy.set((1));
                 block_h.ctrl_regh.char_len.set((7'b00111));
                 block_h.ctrl_regh.tx_neg.set((1'b1));
                 block_h.ctrl_regh.rx_neg.set((1'b0));
                 block_h.ctrl_regh.lsb.set((1'b1));
                 block_h.ctrl_regh.ie.set((1'b0));
                 block_h.ctrl_regh.ass.set((1'b1));
                 block_h.ctrl_regh.update(status, .path(UVM_FRONTDOOR), .parent(this));
                 data = block_h.ctrl_regh.get();

        endtask

endclass


//==========SLAVE SELECT REGISTER SEQUENCE=============//
class ss1 extends spi_reg_seq ;

        //Factory registration
        `uvm_object_utils(ss1)

        rand  uvm_reg_data_t  data;
        uvm_status_e status;

        //-----Constructor new method -------//
        function new (string name ="ss1");
                super.new(name);

        endfunction

        //---------Run_phase method-------//
        task body ;
                super.body;

              if(!this.randomize() with {data inside {1, 2, 4, 8, 32, 64, 128};})
                        begin
                                `uvm_error("body","Slave select Register Randomisation failed")
                        end

		             block_h.ss_h.write(status, data, .parent(this));
                 block_h.dvd_h.write(status, .value(32'h04));
                 block_h.rxtx_h0.write(status, .value(32'd5));
                 block_h.rxtx_h1.write(status, .value(32'd1));
                 block_h.rxtx_h2.write(status, .value(32'd2));
                 block_h.rxtx_h3.write(status, .value(32'd3));
                 block_h.ctrl_regh.go_busy.set((1));
                 block_h.ctrl_regh.char_len.set((7'b00111));
                 block_h.ctrl_regh.tx_neg.set((1'b1));
                 block_h.ctrl_regh.rx_neg.set((1'b0));
                 block_h.ctrl_regh.lsb.set((1'b1));
                 block_h.ctrl_regh.ie.set((1'b0));
                 block_h.ctrl_regh.ass.set((1'b1));
                 block_h.ctrl_regh.update(status, .path(UVM_FRONTDOOR), .parent(this));
                 data = block_h.ctrl_regh.get();

endtask

endclass
