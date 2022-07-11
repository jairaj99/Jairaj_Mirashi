class uart_sequence extends uvm_sequence #(uart_xtn);

`uvm_object_utils(uart_sequence)

env_config e_cfg;

extern function new(string name = "uart_sequence");

endclass 

//Constuctor
function uart_sequence::new(string name = "uart_sequence");
    super.new(name);
    
endfunction



//////////////////////////////////////////half_duplex_test//////////////////////////////////
//SEQ 1
class uart_sequence1 extends uart_sequence;

`uvm_object_utils(uart_sequence1);

extern function new(string name = "uart_sequence1");
extern task body();

endclass

function uart_sequence1::new(string name = "uart_sequence1");
    super.new(name);
    
endfunction

task uart_sequence1::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0100;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        /*if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end 

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    */
    end 
endtask


//SEQ 2
class uart_sequence2 extends uart_sequence;

`uvm_object_utils(uart_sequence2);

extern function new(string name = "uart_sequence2");
extern task body();

endclass

function uart_sequence2::new(string name = "uart_sequence2");
    super.new(name);
    
endfunction

task uart_sequence2::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0010;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
       /* 
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req); 
        end  */


        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask



///////////////////////////FULL_DUPLEX///////////////////////////////
//SEQ 3
class uart_sequence3 extends uart_sequence;

`uvm_object_utils(uart_sequence3);

extern function new(string name = "uart_sequence3");
extern task body();

endclass

function uart_sequence3::new(string name = "uart_sequence3");
    super.new(name);
    
endfunction

task uart_sequence3::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0100;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end 

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask




//SEQ 4 
class uart_sequence4 extends uart_sequence;

`uvm_object_utils(uart_sequence4);

extern function new(string name = "uart_sequence4");
extern task body();

endclass

function uart_sequence4::new(string name = "uart_sequence4");
    super.new(name);
    
endfunction

task uart_sequence4::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0010;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req); 
        end  


        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask



///////////////////////////////////////////LOOP_BACK//////////////////////////////
//SEQ 5
class uart_sequence5 extends uart_sequence;

`uvm_object_utils(uart_sequence5);

extern function new(string name = "uart_sequence5");
extern task body();

endclass

function uart_sequence5::new(string name = "uart_sequence5");
    super.new(name);
    
endfunction

task uart_sequence5::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0100;});                  //LSB (data_in = 4)
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //modem_control_register (4th bit data_in)
        start_item(req);
        assert (req.randomize() with {wb_addr_i==4; wb_we_i==1; wb_dat_i==8'b0001_0000;});                 
        `uvm_info("MCR",$sformatf("Configration of mcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);


        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req); 
        end  


        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end

        //line_status_register
        /*if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    */
    end
endtask

//SEQ 6 
class uart_sequence6 extends uart_sequence;

`uvm_object_utils(uart_sequence6);

extern function new(string name = "uart_sequence6");
extern task body();

endclass

function uart_sequence6::new(string name = "uart_sequence6");
    super.new(name);
    
endfunction

task uart_sequence6::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0010;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //modem_control_register (4th bit data_in)
        start_item(req);
        assert (req.randomize() with {wb_addr_i==4; wb_we_i==1; wb_dat_i==8'b0001_0000;});                 
        `uvm_info("MCR",$sformatf("Configration of mcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);


        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req); 
        end  


        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end

        //line_status_register
        /*if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end*/
    
    end
endtask




///////////////////////////////////////////PARITY_ERROR/////////////////////////////////////
//SEQ 7 
class uart_sequence7 extends uart_sequence;

`uvm_object_utils(uart_sequence7);

extern function new(string name = "uart_sequence7");
extern task body();

endclass

function uart_sequence7::new(string name = "uart_sequence7");
    super.new(name);
    
endfunction

task uart_sequence7::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0100;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_1011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end 

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask
//SEQ 8 
class uart_sequence8 extends uart_sequence;

`uvm_object_utils(uart_sequence8);

extern function new(string name = "uart_sequence8");
extern task body();

endclass

function uart_sequence8::new(string name = "uart_sequence8");
    super.new(name);
    
endfunction

task uart_sequence8::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0010;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0001_1011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end 

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask




/////////////////////////////////////////////FRAMEING_ERROR///////////////////////////////////////////////////
//SEQ 9 
class uart_sequence9 extends uart_sequence;

`uvm_object_utils(uart_sequence9);

extern function new(string name = "uart_sequence9");
extern task body();

endclass

function uart_sequence9::new(string name = "uart_sequence9");
    super.new(name);
    
endfunction

task uart_sequence9::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0100;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0100;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0100;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end 

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask


//SEQ 10 
class uart_sequence10 extends uart_sequence;

`uvm_object_utils(uart_sequence10);

extern function new(string name = "uart_sequence10");
extern task body();

endclass

function uart_sequence10::new(string name = "uart_sequence10");
    super.new(name);
    
endfunction

task uart_sequence10::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0010;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b0000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end 

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask



//////////////////////////////////////////////////OVER_RUN///////////////////////////////////////////
//SEQ 11
class uart_sequence11 extends uart_sequence;

`uvm_object_utils(uart_sequence11);

extern function new(string name = "uart_sequence11");
extern task body();

endclass

function uart_sequence11::new(string name = "uart_sequence11");
    super.new(name);
    
endfunction

task uart_sequence11::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0100;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b0000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end 

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask



//SEQ 12
class uart_sequence12 extends uart_sequence;

`uvm_object_utils(uart_sequence12);

extern function new(string name = "uart_sequence12");
extern task body();

endclass

function uart_sequence12::new(string name = "uart_sequence12");
    super.new(name);
    
endfunction

task uart_sequence12::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0010;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        //repeat(14)
        //begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        //end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end 

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask



///////////////////////////////////BREAK_INTERRUPT///////////////////////////////////////////////////////////////
//SEQ 13
class uart_sequence13 extends uart_sequence;

`uvm_object_utils(uart_sequence13);

extern function new(string name = "uart_sequence13");
extern task body();

endclass

function uart_sequence13::new(string name = "uart_sequence13");
    super.new(name);
    
endfunction

task uart_sequence13::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0100;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0100_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        /*if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end */

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask
//SEQ 14 
class uart_sequence14 extends uart_sequence;

`uvm_object_utils(uart_sequence14);

extern function new(string name = "uart_sequence14");
extern task body();

endclass

function uart_sequence14::new(string name = "uart_sequence14");
    super.new(name);
    
endfunction

task uart_sequence14::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0010;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0100_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        /*if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end */

        //line_status_register
        if(req.iir[3:1]==3'b011)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask


///////////////////////////////////////////TIME_OUT//////////////////////////////////////////////////////////
//SEQ 15
class uart_sequence15 extends uart_sequence;

`uvm_object_utils(uart_sequence15);

extern function new(string name = "uart_sequence15");
extern task body();

endclass

function uart_sequence15::new(string name = "uart_sequence15");
    super.new(name);
    
endfunction

task uart_sequence15::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0100;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0001;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b0000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        /*if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end */

        //line_status_register
        if(req.iir[3:1]==3'b110)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask
//SEQ 16 
class uart_sequence16 extends uart_sequence;

`uvm_object_utils(uart_sequence16);

extern function new(string name = "uart_sequence16");
extern task body();


endclass

function uart_sequence16::new(string name = "uart_sequence16");
    super.new(name);
    
endfunction

task uart_sequence16::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0010;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0100;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b0100_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        /*if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end */

        //line_status_register
        if(req.iir[3:1]==3'b110)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask

////////////////////////////////////////////////////////THR_EMPTY////////////////////////////
//SEQ 17
class uart_sequence17 extends uart_sequence;

`uvm_object_utils(uart_sequence17);

extern function new(string name = "uart_sequence17");
extern task body();

endclass

function uart_sequence17::new(string name = "uart_sequence17");
    super.new(name);
    
endfunction

task uart_sequence17::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0100;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0010;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
        /*if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end */

        //line_status_register
        if(req.iir[3:1]==3'b001)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask



//SEQ 18
class uart_sequence18 extends uart_sequence;

`uvm_object_utils(uart_sequence18);

extern function new(string name = "uart_sequence18");
extern task body();

endclass

function uart_sequence18::new(string name = "uart_sequence18");
    super.new(name);
    
endfunction

task uart_sequence18::body();
    begin
        if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	    `uvm_fatal("CONFIG","cannot get() e_cfg from uvm_config_db. Have you set() it?") 

        //Selecting LCR's DL acces bit 
        req = uart_xtn::type_id::create("req");
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b1000_0000;});
        `uvm_info("LCR(DL)",$sformatf("Configration of lcr(dl) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Passing DL values
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0000;});                  //MSB
        `uvm_info("DL(MSB)",$sformatf("Configration of dl(msb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0010;});                  //LSB
        `uvm_info("DL(LSB)",$sformatf("Configration of dl(lsb) sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        
        //Selecting LCR's normal register bits
        start_item(req);
        assert (req.randomize() with {wb_addr_i==3; wb_we_i==1; wb_dat_i==8'b0000_0011;});                 
        `uvm_info("LCR",$sformatf("Configration of lcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //interrupt_enable_register 
        start_item(req);
        assert (req.randomize() with {wb_addr_i==1; wb_we_i==1; wb_dat_i==8'b0000_0010;});                 
        `uvm_info("IER",$sformatf("Configration of ier sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //fifo_control_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==1; wb_dat_i==8'b1000_0110;});                 
        `uvm_info("FCR",$sformatf("Configration of fcr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        //transmitter_holding_register
        repeat(14)
        begin
        start_item(req);
        assert (req.randomize() with {wb_addr_i==0; wb_we_i==1; wb_dat_i==8'b0000_0111;});                 
        `uvm_info("THR",$sformatf("Configration of thr sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);
        end

        //interrupt_identification_register
        start_item(req);
        assert (req.randomize() with {wb_addr_i==2; wb_we_i==0;});                 
        `uvm_info("IIR",$sformatf("Configration of iir sequence : %0s", req.sprint()),UVM_LOW)
        finish_item(req);

        get_response(req);            //from driver 

        //register_buffer
       /* if(req.iir[3:1]==3'b010)
        begin
            $display("Reading from RB : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==0; wb_we_i==0;});                 
                `uvm_info("RB",$sformatf("Configration of rb sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end */

        //line_status_register
        if(req.iir[3:1]==3'b001)
        begin
            $display("Reading errors from LSR : %0b",req.iir);
            repeat(14)
            begin
                start_item(req);
                assert (req.randomize() with {wb_addr_i==5; wb_we_i==0;});                 
                `uvm_info("LSR",$sformatf("Configration of lsr sequence : %0s", req.sprint()),UVM_LOW)
                finish_item(req);
            end
        end
    
    end
endtask
