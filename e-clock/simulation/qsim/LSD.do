onerror {exit -code 1}
vlib work
vlog -work work LSD.vo
vlog -work work sec.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.sec_vlg_vec_tst -voptargs="+acc"
vcd file -direction LSD.msim.vcd
vcd add -internal sec_vlg_vec_tst/*
vcd add -internal sec_vlg_vec_tst/i1/*
run -all
quit -f
