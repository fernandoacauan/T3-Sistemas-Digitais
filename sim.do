if {[file exists work]} {
    vdel -all -lib work
}
vlib work
vmap work work


vcom -work work -2008 -explicit queue.vhd
vcom -work work -2008 -explicit deserializer.vhd
vcom -work work -2008 -explicit top.vhd
vcom -work work -2008 -explicit tb.vhd
# vcom -work work -2008 - explicit tbDeserializer.vhd
# vcom -work work -2008 - explicit tbQueue.vhd

vsim work.tb


quietly set StdArithNoWarnings 1
quietly set StdVitalGlitchNoWarnings 1


do wave.do

run 10000 us

