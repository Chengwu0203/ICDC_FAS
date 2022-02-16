# read_verilog FAS.v
read_file -format verilog {/home/chengwu/CIC_Contest_practice/101_2013_Frequency_Analysis_System/2013_grad_cell/FAS.v} -autoread -top FAS
source FAS.sdc
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
set verilogout_no_tri     true
link

set_host_options -max_cores 16

compile -inc
optimize_registers
optimize_netlist -area

report_timing  -delay_type max > FAS_Report_setup_time.txt; 	#set up time
report_timing  -delay_type min > FAS_Report_hold_time.txt;  	#hold time
report_area > FAS_Report_area.txt

write -hierarchy -format verilog -output  FAS_syn.v
write_sdf -version 2.1 -context verilog  FAS_syn.sdf

