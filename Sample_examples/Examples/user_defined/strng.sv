module strng;

string str1,str2;
initial
begin
str1="Maven Silicon";
str2="Maven Silicon";
str2=str2.toupper();
$display("STRING1 = %s",str1);
$display("STRING2 = %s",str2);
$display("%s", str1.substr(0, str1.len-8));
if(str1==str2)
$display("Match");
else
$display("Mismatch");
end
endmodule
