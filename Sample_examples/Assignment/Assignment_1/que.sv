module que();
int q1[$] ={0,1,5,6,7,8};
int q2[$] ={2,3,4};

initial
begin

//with method
//foreach(q2[i])
//q1.insert(i+2, q2[i]);

//without method
//foreach(q2[i])
q1={q1[0:1], q2, q1[2:$]};

$display("After insterting the content of q are %p",q1);
end
endmodule


