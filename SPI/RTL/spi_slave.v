`include "timescale.v"
module spi_slave  (sck,
                   cs,
                   mosi,
                   miso
                  );

 input sck;
 input cs;
 input mosi;

 output miso;

 reg [7:0]interna_reg;
 //reg [7:0] slv_reg=8'hFF;
 reg [7:0] slv_reg=8'b10100010;
 reg [7:0] in_reg=0;
 reg [7:0] rec_reg=0;
 reg [7:0] count=0;

 assign miso = (cs==1'b0) ? slv_reg[7] : 1'bz;
 always@(negedge sck)
 begin
    if (!cs)
        slv_reg<=slv_reg<<1'b1;
 end
 always@(posedge sck)
 begin
    if (!cs)
        rec_reg<={rec_reg[6:0],mosi};
 end

 always@(posedge sck)
 begin
    if (!cs)
       count<=count+1;
    else
       count=0;
 end

 always@(posedge sck)
 if (count==7)
     begin
        in_reg<={rec_reg[6:0],mosi};
     end
endmodule
