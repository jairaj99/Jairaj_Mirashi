   class ctrl extends uvm_reg;

        /*Factory registration */
        `uvm_object_utils(ctrl)

        rand uvm_reg_field char_len;
             uvm_reg_field reserved1;
        rand uvm_reg_field go_busy;
        rand uvm_reg_field rx_neg;
        rand uvm_reg_field tx_neg;
        rand uvm_reg_field lsb;
        rand uvm_reg_field ie;
        rand uvm_reg_field ass;
             uvm_reg_field reserved2;

        //------Constructor new method --------//
        function new(string name="ctrl");
                super.new(name,32,UVM_NO_COVERAGE);

        endfunction

	        //------ UVM Register Build function  --------//
        virtual function void build ();
                char_len =uvm_reg_field::type_id::create("char_len");
                reserved1 =uvm_reg_field::type_id::create("reserved1");
                go_busy =uvm_reg_field::type_id::create("go_busy");
                rx_neg =uvm_reg_field::type_id::create("rx_neg");
                tx_neg =uvm_reg_field::type_id::create("tx_neg");
                lsb =uvm_reg_field::type_id::create("lsb");
                ie =uvm_reg_field::type_id::create("ie");
                ass =uvm_reg_field::type_id::create("ass");
                reserved2 =uvm_reg_field::type_id::create("reserved2");

                char_len.configure(this ,7,0,"RW",0,7'b0000000,1 ,1 ,0 );
                reserved1.configure(this, 1, 7,"RO",0,1'b0,1,1,0);
                go_busy.configure(this, 1,8,"RW", 0,1'b0,1,1,0);
                rx_neg.configure(this,1 ,9,"RW",0,1'b0, 1,1,0);
                tx_neg.configure(this,1,10,"RW",0,1'b0,1,1,0);
                lsb.configure(this,1 ,11, "RW",0,1'b0,1,1,0);
                ie.configure(this,1 ,12, "RW",0,1'b0,1,1,0);
                ass.configure(this,1 ,13, "RW",0,1'b0,1,1,0);
                reserved2.configure(this,18 ,14, "RW",0,18'b0,1,1,0);
        endfunction
    endclass
