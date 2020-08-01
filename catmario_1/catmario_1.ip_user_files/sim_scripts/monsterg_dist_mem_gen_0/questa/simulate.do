onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib monsterg_dist_mem_gen_0_opt

do {wave.do}

view wave
view structure
view signals

do {monsterg_dist_mem_gen_0.udo}

run -all

quit -force
