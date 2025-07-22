# 🧠 Single-Cycle RV32I Processor

This project implements a **32-bit single-cycle RISC-V (RV32I) processor** using Verilog HDL. The design follows the Harvard architecture and executes **one instruction per clock cycle**.

Built during the Digital Design Workshop (2024/2025), this project helped me understand the core concepts of processor design, datapath integration, and hardware simulation.

---

## 🏗️ Features

- Harvard Architecture (separate instruction/data memory)
- Fully modular Verilog design
- Supports basic RISC-V instructions (ADD, SUB, LW, SW, BEQ, etc.)
- ALU with support for: ADD, SUB, AND, OR, XOR, SHL, SHR
- Simulation with Fibonacci sequence in ModelSim

---

## 📁 Project Structure

```
/rtl         → All Verilog modules
/programs    → Machine code (fibonacci)
/docs        → Report & diagrams
```

---

## 💡 Modules

## 💡 Modules

- `ALU.v` – Arithmetic and logic operations (ADD, SUB, AND, OR, XOR, SHL, SHR)
- `ControlUnit.v` – Main control logic and ALU decoder based on instruction fields
- `data_mem.v` – Data memory (64-entry RAM), supports lw/sw
- `instruction_mem.v` – Instruction memory (ROM), loads program from file
- `MUX.v` – Reusable 2x1 multiplexer used for PCSrc, ALUSrc, ResultSrc
- `PC_reg.v` – Program counter register with reset and load control
- `PCNext_logic.v` – Calculates next PC based on PC+4 or branch target
- `register_file.v` – 32x32-bit register file with dual-read and single-write
- `SignExtender.v` – Extracts and sign-extends immediates (I, S, B types)
- `TopModule.v` – Integrates all components into one single-cycle datapath

---

## 🧪 Simulation

Tested on a **Fibonacci program**, demonstrating:
- Arithmetic calculations
- Conditional branching
- Memory write

### 📝 Sample C code:
```c
int x = 0, y = 1;
for (int i = 0; i < 10; i++) {
  if (sel == 1) { x = x + y; sel = 2; }
  else         { y = x + y; sel = 1; }
}
```

### 🧾 Sample machine code:
```
00004033
00000093
00100113
00100193
00100213
00000293
00a00313
00000393
00418c63
00110133
404181b3
00229393
0023a023
00420a63
002080b3
004181b3
00229393
0013a023
00128293
fc62cae3
00000000

```

---

## 📸 Waveform

<img width="1600" height="971" alt="image" src="https://github.com/user-attachments/assets/9ebae06b-0769-4458-b8f3-97e26de06e6c" />


---

## 🙋‍♂ Authors

Ali Mohamed  
GitHub: [@Ali_Said](https://github.com/Ali-M-Said)

Abdelrahman Mohamed Misbah  
GitHub: [@Abdelrahman-Misbah]([https://github.com/Abdelrahman-Misbah])
