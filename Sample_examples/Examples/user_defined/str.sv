module strg;

string str1,str2;
initial
begin
str1="Maven Silicon";
str2="http://www.MAVEN_SILICON.com ";
str1 = str1.tolower();
$display("Character in 5th position is %s", str1.getc(6));
str1.putc(5,"_");
$display("%s", str1.substr(2, str1.len-1));
str1={str1, ".com"};
str1={{3{"w"}},".",str1};
str2=str2.tolower();
$display("STRING2 = %s",str2);
if(str1==str2)
$display("Match");
else
$display("Mismatch");
disp($sformatf("http://%s ",str1));
end

task disp(string s1);
$display("at time t=%0t, %s ", $time, s1);
endtask
endmodule
