  class adapter  extends uvm_reg_adapter;

        /*Factory registration */
        `uvm_object_utils (adapter)


        //-------Constructor new method -----//
        function new(string name="adapter");
                super.new(name);

        endfunction

        //*********reg2bus method *********//

        virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
                spi_m_xtn  xtn;
                xtn = spi_m_xtn::type_id::create("xtn");

        xtn.wb_we_i=(rw.kind ==UVM_WRITE);
        xtn.wb_adr_i = rw.addr;
        xtn.wb_dat_i = rw.data;
        return xtn;
endfunction

//*********bus2reg method *********//
virtual function void bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);
        spi_m_xtn xtn ;

        if(!$cast(xtn,bus_item))
                begin
                `uvm_fatal("NOT_WRTR_TYPE","Provides bus_item is not of the correct type")
                return;
                end
        rw.kind =(xtn.wb_we_i ==0)?UVM_READ :UVM_WRITE;
        rw.addr = xtn.wb_adr_i ;
        rw.data = xtn.wb_dat_i;
        rw.status = UVM_IS_OK;

endfunction
endclass

