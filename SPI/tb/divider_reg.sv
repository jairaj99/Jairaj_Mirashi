  class  divider_reg  extends uvm_reg;

        /*Factory registration*/
        `uvm_object_utils(divider_reg)

        rand uvm_reg_field divider;
             uvm_reg_field reserved;


        //------Constructor new method --------//
        function new(string name="divider_reg");
                super.new(name,32,UVM_NO_COVERAGE);

        endfunction

        //------ UVM Register Build function  --------//
        virtual function void build ();

                divider = uvm_reg_field::type_id::create("divider");
                reserved =uvm_reg_field::type_id::create("reserved");


                divider.configure(this,16, 0,"RW", 0, 16'b0 ,1,1,0);
                reserved.configure(this,16, 16,"RO", 0, 16'b0 ,1,1,0);

        endfunction

   endclass
