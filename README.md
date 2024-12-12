# RISC CPU Design and Implementation

## Overview

This repository contains the implementation of a Reduced Instruction Set Computer (RISC) CPU, designed and tested as part of the **EE 326: Computer Organization and Processor Architecture Design** course at **IIT Mandi**, under the guidance of Dr. Shubhajit Roy Chowdhury. The project demonstrates the development of a functional processor capable of executing a custom instruction set with essential features of RISC architecture.

The CPU was developed using Verilog HDL, simulated in Xilinx Vivado. It supports basic arithmetic, logical operations, memory access, and control flow instructions.

---

## Features

### Instruction Set Architecture (ISA)
- **Word Size**: 16 bits.
- **Instruction Format**:
  - `[Opcode (4 bits)][Destination Register (3 bits)][Source Register 1 (3 bits)][Source Register 2/Immediate (6 bits)]`.
- **Supported Instructions**:
  - **Arithmetic**: `add`, `sub`.
  - **Logical**: `not`, `and`, `or`.
  - **Data Transfer**: `mov`, `movi`, `ld`, `str`.
  - **Control Flow**: `jmp`, `b` (branch).
  - **Special**: `hlt` (halt).
- **Memory Model**:
  - Word-addressable memory with a linear addressing space of 8K words.
  - Operands are 16-bit signed integers.

![image](https://github.com/user-attachments/assets/73cf92ca-e410-4247-a1ce-5343ab562d40)
![image](https://github.com/user-attachments/assets/9b6864c4-c069-4da8-a10c-2554d86b51d6)


### Processor Components
- **Datapath**:
  - Arithmetic Logic Unit (ALU) for arithmetic and logical operations.
  - Register file for general-purpose storage.
  - Instruction and data memory interfaces.
  - Immediate extension for handling immediate values.
- **Control Unit**:
  - Finite State Machine (FSM) for fetch, decode, and execute stages.
  - Signal generation for correct sequencing and execution.

### Simulation and Testing
- Component-level and integrated simulations.
- Programs executed include:
  - Fibonacci sequence generation.
  - Arithmetic and logical operations.

