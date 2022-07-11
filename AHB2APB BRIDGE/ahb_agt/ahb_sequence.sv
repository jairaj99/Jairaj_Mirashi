class ahb_sequence  extends uvm_sequence #(ahb_xtn);

        `uvm_object_utils(ahb_sequence)

        extern function new(string name = "ahb_sequence");
endclass

function ahb_sequence::new(string name = "ahb_sequence");
        super.new(name);
endfunction

///-------test sequence-------/////
class incr_4 extends ahb_sequence;

        `uvm_object_utils(incr_4)

                logic [31:0] haddr;
                logic hwrite;
                logic [2:0] hsize;
                logic [2:0] hburst;

        extern function new(string name = "incr_4");
        extern task body();
endclass

function incr_4::new(string name = "incr_4");
        super.new(name);
endfunction

task incr_4::body();

        req = ahb_xtn::type_id::create("req");

        start_item(req);
                assert(req.randomize() with {Htrans == 2'b10;}); //first xtn is NS
                finish_item(req);
 //store in local variables
        haddr = req.Haddr;
        hsize = req.Hsize;
        hburst = req.Hburst;
        hwrite = req.Hwrite;

        //-----INCR 4---------//
        if(hburst == 3'b011)
        begin
                for(int i=0; i<3; i++)
                begin
                        haddr = haddr + (2**hsize);
                        start_item(req);

                        if(hsize == 0)
                                assert(req.randomize() with {Hsize == hsize; Hburst == hburst;
                                                                                        Hwrite == hwrite; Htrans == 2'b11;
                                                                                        Haddr == haddr;});
                        //Haddr = haddr + 1'b1;

                        if(hsize == 1)
                                assert(req.randomize() with {Hsize == hsize; Hburst == hburst;
                                                                                        Hwrite == hwrite; Htrans == 2'b11;
                                                                                        Haddr == haddr;});
                        //Haddr = haddr + 2'b10;

                        if(hsize == 2)
                                assert(req.randomize() with {Hsize == hsize; Hburst == hburst;
                                                                                        Hwrite == hwrite; Htrans == 2'b11;
                                  finish_item(req);

                        haddr = req.Haddr;
                end
        end
                                                                                                            