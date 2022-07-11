RTL= ../Uart_rtl/* 
work= work #library name
SVTB1= ../env/top.sv
INC = +incdir+../env +incdir+../test +incdir+../uart_agent_top 
SVTB2 = ../test/uart_package.sv
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
#COVOP = -coveropt 3 +cover=bcsf
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit mem_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit mem_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit mem_cov3;run -all; exit"
VSIMBATCH4= -c -do  " log -r /* ;coverage save -onexit mem_cov4;run -all; exit"
VSIMBATCH5= -c -do  " log -r /* ;coverage save -onexit mem_cov5;run -all; exit"
VSIMBATCH6= -c -do  " log -r /* ;coverage save -onexit mem_cov6;run -all; exit"
VSIMBATCH7= -c -do  " log -r /* ;coverage save -onexit mem_cov7;run -all; exit"
VSIMBATCH8= -c -do  " log -r /* ;coverage save -onexit mem_cov8;run -all; exit"
VSIMBATCH9= -c -do  " log -r /* ;coverage save -onexit mem_cov9;run -all; exit"


help:
        @echo =============================================================================================================
        @echo "! USAGE          --  make target                                                                                                                 !"
        @echo "! clean          =>  clean the earlier log and intermediate files.                                                                       !"
        @echo "! sv_cmp         =>  Create library and compile the code.                                                                                !"
        @echo "! run_sim    =>  run the simulation in batch mode.                                                                               !"
        @echo "! run_test1       =>  clean, compile & run the simulation for half_duplex_test in batch mode.                !" 
        @echo "! run_test2      =>  clean, compile & run the simulation for full_duplex_test in batch mode.                   !" 
        @echo "! run_test3      =>  clean, compile & run the simulation for loop_back_test in batch mode.                   !"
        @echo "! run_test4      =>  clean, compile & run the simulation for parity_test in batch mode.              !" 
        @echo "! run_test5      =>  clean, compile & run the simulation for framing_test in batch mode.              !" 
        @echo "! run_test6      =>  clean, compile & run the simulation for over_run_test in batch mode.              !" 
        @echo "! run_test7      =>  clean, compile & run the simulation for break_interrupt_test in batch mode.              !" 
        @echo "! run_test8      =>  clean, compile & run the simulation for time_out_test in batch mode.              !" 
        @echo "! run_test9      =>  clean, compile & run the simulation for thr_empty_test in batch mode.              !" 
        @echo "! view_wave1 =>  To view the waveform of half_duplex_test                                                                    !" 
        @echo "! view_wave2 =>  To view the waveform of full_duplex_test                                                                               !" 
        @echo "! view_wave3 =>  To view the waveform of loop_back_test                                                                                       !" 
        @echo "! view_wave4 =>  To view the waveform of parity_test                                                                              !" 
        @echo "! view_wave5 =>  To view the waveform of framing_test                                                                              !" 
        @echo "! view_wave6 =>  To view the waveform of over_run_test                                                                              !" 
        @echo "! view_wave7 =>  To view the waveform of break_interrupt_test                                                                              !" 
        @echo "! view_wave8 =>  To view the waveform of time_out_test                                                                              !" 
        @echo "! view_wave9 =>  To view the waveform of thr_empty_test                                                                              !" 
        @echo "! regress    =>  clean, compile and run all testcases in batch mode.                                                             !"
        @echo "! report     =>  To merge coverage reports for all testcases and  convert to html format.                        !"
        @echo "! cov        =>  To open merged coverage report in html format.                                                                          !"
        @echo ====================================================================================================================



sv_cmp:
        vlib $(work)
        vmap work $(work)
        vlog -work $(work) $(RTL) $(INC) $(SVTB2) $(SVTB1)

run_test1:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH1)  -wlf wave_file1.wlf -l test1.log  -sv_seed random  work.top +UVM_TESTNAME=half_duplex_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test2:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH2)  -wlf wave_file2.wlf -l test2.log  -sv_seed random  work.top +UVM_TESTNAME=full_duplex_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

run_test3:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH3)  -wlf wave_file3.wlf -l test3.log  -sv_seed random  work.top +UVM_TESTNAME=loop_back_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3

run_test4:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH4)  -wlf wave_file4.wlf -l test4.log  -sv_seed random  work.top +UVM_TESTNAME=parity_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4

run_test5:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH5)  -wlf wave_file5.wlf -l test5.log  -sv_seed random  work.top +UVM_TESTNAME=framing_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5

run_test6:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH6)  -wlf wave_file6.wlf -l test6.log  -sv_seed random  work.top +UVM_TESTNAME=over_run_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov6

run_test7:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH7)  -wlf wave_file7.wlf -l test7.log  -sv_seed random  work.top +UVM_TESTNAME=break_interrupt_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov7

run_test8:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH8)  -wlf wave_file8.wlf -l test8.log  -sv_seed random  work.top +UVM_TESTNAME=time_out_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov8

run_test9:sv_cmp
        vsim $(VSIMOPT) $(VSIMCOV) $(VSIMBATCH9)  -wlf wave_file9.wlf -l test9.log  -sv_seed random  work.top +UVM_TESTNAME=thr_empty_test
        vcover report  -cvg  -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov9

view_wave1:
        vsim -view wave_file1.wlf
        
view_wave2:
        vsim -view wave_file2.wlf
        
view_wave3:
        vsim -view wave_file3.wlf
        
view_wave4:
        vsim -view wave_file4.wlf

view_wave5:
        vsim -view wave_file5.wlf

view_wave6:
        vsim -view wave_file6.wlf

view_wave7:
        vsim -view wave_file7.wlf

view_wave8:
        vsim -view wave_file8.wlf

view_wave9:
        vsim -view wave_file9.wlf

report:
        vcover merge mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 mem_cov7 mem_cov8 mem_cov9
        vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov

regress: clean run_test1 run_test2 run_test3 run_test4 run_test5 run_test6 run_test7 run_test8 run_test9 report cov

cov:
        firefox covhtmlreport/index.html&
        
clean:
        rm -rf transcript* *log*  vsim.wlf fcover* covhtml* mem_cov* *.wlf modelsim.ini
        clear
