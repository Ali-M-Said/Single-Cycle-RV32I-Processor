vlib work
vlog *.v 
vsim -voptargs=+acc work.TopModule

# Add important signals to waveform
add wave -divider "===== CONTROL ====="
add wave clk
add wave reset

add wave -divider "===== PROGRAM COUNTER ====="
add wave -hex TopModule/PC

add wave -divider "===== REGISTER FILE (x0 to x7) ====="
add wave -hex TopModule/reg_file/regfile[0]
add wave -hex TopModule/reg_file/regfile[1]
add wave -hex TopModule/reg_file/regfile[2]
add wave -hex TopModule/reg_file/regfile[3]
add wave -hex TopModule/reg_file/regfile[4]
add wave -hex TopModule/reg_file/regfile[5]
add wave -hex TopModule/reg_file/regfile[6]
add wave -hex TopModule/reg_file/regfile[7]

add wave -divider "===== DATA MEMORY (0 to 9) ====="
add wave -hex TopModule/data_memory/data_memory[0]
add wave -hex TopModule/data_memory/data_memory[1]
add wave -hex TopModule/data_memory/data_memory[2]
add wave -hex TopModule/data_memory/data_memory[3]
add wave -hex TopModule/data_memory/data_memory[4]
add wave -hex TopModule/data_memory/data_memory[5]
add wave -hex TopModule/data_memory/data_memory[6]
add wave -hex TopModule/data_memory/data_memory[7]
add wave -hex TopModule/data_memory/data_memory[8]
add wave -hex TopModule/data_memory/data_memory[9]

# Run full simulation
run -all
