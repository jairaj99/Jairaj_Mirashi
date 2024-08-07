module user_define();

typedef bit[31:0] word_t;
word_t word1, word2;
struct {bit [7:0] r,g,b;} pixel;
initial
begin
pixel.r=8'd25;
pixel.g=8'd255;
pixel.b=8'd11;
end

typedef struct{bit [7:0] r,g,b;} pixel_st;
pixel_st samsung_pixel;
pixel_st sony_pixel;
initial
begin
samsung_pixel.r=8'd25;
sony_pixel='{8'd38, 8'd98, 8'd69};
$display("Samsung_Pixel =%p",samsung_pixel);
$display("Sony_Pixel= %p", sony_pixel);
end

endmodule
