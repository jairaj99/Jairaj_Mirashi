   class  ss_reg extends uvm_reg;

        /*Factory registration*/
        `uvm_object_utils(ss_reg)

        rand uvm_reg_field ss;
             uvm_reg_field reserved;


        //------Constructor new method --------//
        function new(string name="ss_reg");
                super.new(name,32,UVM_NO_COVERAGE);

        endfunction

        //------ UVM Register Build function  --------//
        virtual function void build ();

                ss = uvm_reg_field::type_id::create("ss");
                reserved =uvm_reg_field::type_id::create("reserved");

                ss.configure (this,8, 0,"RW", 0, 8'b0 ,1,1,0);
                reserved.configure(this,24, 8,"RO", 0, 24'b0 ,1,1,0);


        endfunction

   endclass
