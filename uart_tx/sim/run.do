#***************************************************#
# Clean Work Library
#***************************************************#
if [file exists "work"] {vdel -all}
vlib work

#***************************************************#
# Start a new Transcript File
#***************************************************#
#transcript file log/fifo_run_log.log
# better make one for each test

#***************************************************#
# Compile RTL and TB files
#***************************************************#
vlog -f uart_tx_dut.f
vlog -f uart_tx_tb.f

#***************************************************#
# Optimizing Design with vopt
#***************************************************#
vopt uart_tx_top -o top_opt -debugdb  +acc +cover=sbecf+uart_tx(rtl).

#***************************************************#
# Simulation of a Test
#***************************************************#
transcript file log/uart_tx_test.log
vsim top_opt -c -assertdebug -debugDB -fsmdebug -coverage +UVM_TESTNAME=uart_tx_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage attribute -name TESTNAME -value uart_tx_test
coverage save coverage/uart_tx_test.ucdb

#***************************************************#
# Close the Transcript file
#***************************************************#
transcript file ()

#***************************************************#
# save the coverage in text files
#***************************************************#

vcover report coverage/uart_tx_test.ucdb -cvg -details -output coverage/fun_coverage.txt
vcover report coverage/uart_tx_test.ucdb  -output coverage/code_coverage.txt