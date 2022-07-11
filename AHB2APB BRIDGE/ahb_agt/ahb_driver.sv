class ahb_driver extends uvm_driver#(ahb_xtn);
//factory reg
`uvm_component_utils(ahb_driver)
//handle for interface
virtual ahb_if.AHB_MP vif;
//declar ehandle for rd_config class
ahb_config ahb_cfg;
//uvm methods
	
	extern function new(string name ="ahb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(ahb_xtn xtn);
endclass

//CODE FOR NEW	
function ahb_driver::new( string name="ahb_driver",uvm_component parent);
super.new(name,parent);
endfunction

//code for build
function void ahb_driver::build_phase(uvm_phase phase);
super.build_phase(phase);
//getiing config
	  if(!uvm_config_db #(ahb_config)::get(this,"","ahb_config",ahb_cfg))
		`uvm_fatal("CONFIG","cannot get() hcfg from uvm_config_db. Have you set() it?")
$display("%p",ahb_cfg);
  endfunction
//code for coneect phase
function void ahb_driver::connect_phase(uvm_phase phase);
vif=ahb_cfg.vif;
endfunction
 code for run phase

        task ahb_driver::run_phase(uvm_phase phase);
                forever
                 begin
                seq_item_port.get_next_item(req);
                send_to_dut(req);
                seq_item_port.item_done();
                end
        endtask

//code for sen to dut task
        task ahb_driver::send_to_dut(ahb_xtn xtn);
`uvm_info("AHB_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
 //Active low reset
        @(vif.ahb_drv_cb);
        vif.ahb_drv_cb.Hresetn <= 1'b0;

        repeat(2)
        @(vif.ahb_drv_cb);
        vif.ahb_drv_cb.Hresetn <= 1'b1;
         @(vif.ahb_drv_cb);
        vif.ahb_drv_cb.Hwrite  <= xtn.Hwrite;
        vif.ahb_drv_cb.Htrans <= xtn.Htrans;
        vif.ahb_drv_cb.Hsize   <= xtn.Hsize;
        vif.ahb_drv_cb.Haddr   <= xtn.Haddr;
        vif.ahb_drv_cb.Hreadyin <= 1'b1; //since we have 1 AHB Master, Hreadyin will always be high indicating to slave that Master is ready to send

         @(vif.ahb_drv_cb);

        //wait till Hreadyout goes high - the moment it goes high drive Hwdata
        wait(vif.ahb_drv_cb.Hreadyout)
                vif.ahb_drv_cb.Hwdata<=xtn.Hwdata;

  //      ahb_cfg.drv_data_count++;
endtask

                                                   