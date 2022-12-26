   class  spi_reg_block extends uvm_reg_block;

        /*Factory registration */
        `uvm_object_utils(spi_reg_block)

        // register instances
        rand ctrl ctrl_regh;

        rand rxtx_reg rxtx_h0;
        rand rxtx_reg rxtx_h1;
        rand rxtx_reg rxtx_h2;
        rand rxtx_reg rxtx_h3;
        rand divider_reg  dvd_h;
        rand ss_reg  ss_h;

        //Block map
        uvm_reg_map spi_map;


        //------Constructor new method --------//
        function new(string name="spi_reg_block");
                super.new(name, build_coverage(UVM_CVR_ADDR_MAP));

        endfunction

        //----Creating, building and configuring the register instances----//

	      //UVM Build function
        virtual function void build();

           ctrl_regh =ctrl::type_id::create("ctrl");
           ctrl_regh.build();
           ctrl_regh.configure(this, null,"");
           ctrl_regh.add_hdl_path_slice("ctrl",0,32);   //reg name in rtl,starting position,no.of bits wide

           rxtx_h0 =rxtx_reg::type_id::create("rxtx_reg");
           rxtx_h0.build();
           rxtx_h0.configure(this, null,"");
           rxtx_h0.add_hdl_path_slice("rx",0,32);   //reg name in rtl,starting position,no.of bits wide

           rxtx_h1 =rxtx_reg::type_id::create("rxtx_reg");
           rxtx_h1.build();
           rxtx_h1.configure(this, null,"");
           rxtx_h1.add_hdl_path_slice("rx",0,32);

           rxtx_h2 =rxtx_reg::type_id::create("rxtx_reg");
           rxtx_h2.build();
           rxtx_h2.configure(this, null,"");
           rxtx_h2.add_hdl_path_slice("rx",0,32);

           rxtx_h3 =rxtx_reg::type_id::create("rxtx_reg");
           rxtx_h3.build();
           rxtx_h3.configure(this, null,"");
           rxtx_h3.add_hdl_path_slice("rx",0,32);

           dvd_h =divider_reg::type_id::create("divider_reg");
           dvd_h.build();
           dvd_h.configure(this, null,"");
           dvd_h.add_hdl_path_slice("divider_reg",0,32);

	               ss_h =ss_reg::type_id::create("ss_reg");
           ss_h.build();
           ss_h.configure(this, null,"");
           ss_h.add_hdl_path_slice("ss",0,32);


        //Create map
                spi_map = create_map("spi_map",0,4,UVM_LITTLE_ENDIAN);

        //Memory map creation and reg map to it
                spi_map.add_reg(ctrl_regh , 'h10, "RW");
                spi_map.add_reg(rxtx_h0,    'h0, "RW");
                spi_map.add_reg(rxtx_h1,    'h4, "RW");
                spi_map.add_reg(rxtx_h2,    'h8, "RW");
                spi_map.add_reg(rxtx_h3,    'hc, "RW");
                spi_map.add_reg(dvd_h,      'h14, "RW");
                spi_map.add_reg(ss_h,       'h18, "RW");

                add_hdl_path ("top.DUV", "RTL");

                lock_model();

        endfunction

   endclass
