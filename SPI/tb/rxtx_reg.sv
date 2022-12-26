   class  rxtx_reg extends uvm_reg;
        /*Factory registration*/
        `uvm_object_utils(rxtx_reg)

        uvm_reg_field rxtx;


        //------Constructor new method --------//
        function new(string name="rxtx_reg");
                super.new(name,32,UVM_NO_COVERAGE);

        endfunction

        //------ UVM Register Build function  --------//
        virtual function void build ();

        rxtx =uvm_reg_field::type_id::create("rxtx");

        rxtx.configure(this,32, 0,"RW", 0, 32'b0 ,1,1,0);

        endfunction

  endclass
