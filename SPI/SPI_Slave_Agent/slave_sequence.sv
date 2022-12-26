 class slave_sequence extends uvm_sequence #(spi_s_xtn);

        /*Factory registration*/
                `uvm_object_utils (slave_sequence)


        spi_s_xtn req;
//      bit miso_loc;
        bit miso_pad_i;

        // --------- Standard UVM Methods -----------//

        extern function new(string name = "slave_sequence");

  endclass

       //-----------------  constructor new method  -------------------//
       function slave_sequence::new(string name ="slave_sequence");
                super.new(name);

       endfunction

 class miso_seq extends slave_sequence ;

          // Factory registration
          `uvm_object_utils(miso_seq)

          //Standard  UVM Methods
          extern function new (string name ="miso_seq");
          extern task body();
  endclass

        //-----------------  constructor new method  -------------------//
        function miso_seq::new(string name ="miso_seq");
                   super.new(name);

         endfunction
        //-----------------  task body method  -------------------//

        task miso_seq::body();

             req =spi_s_xtn::type_id::create("req");

             start_item (req);
                begin
                        assert(req.randomize ()with { miso_pad_i == req.miso_pad_i;});
                        $display("miso_pad_i=%d",miso_pad_i);
                end

             finish_item(req);

        endtask
