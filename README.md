# RVV_ext: RISC-V Vector Extension

**RVV_ext** is a hardware implementation of a vector processing extension for the RISC-V instruction set architecture (ISA). This project is designed to enhance a base RISC-V core with SIMD (Single Instruction, Multiple Data) capabilities, targeting FPGA platforms such as the Digilent Zedboard.

## 📖 Documentation

For detailed information regarding the architecture, design decisions, and theoretical background, please refer to the project report included in this repository:

* 📄 **[Project - Parallel Architecture.pdf](./Project%20-%20Parallel%20Architecture.pdf)**

## 📂 Repository Structure

| File/Folder | Description |
| :--- | :--- |
| **`src/`** | Contains the Verilog/SystemVerilog source code for the vector extension and processor modules. |
| **`testbenches/`** | Simulation files used to verify the functionality of the vector unit. |
| **`RiscYZedboard.zip`** | Xilinx Vivado project files and constraints for deploying the design to a Zedboard (Zynq-7000). |
| **`Final_linux.zip`** | Contains the Linux kernel/root filesystem tailored for the SoC implementation. |
| **`DATED_files/`** | Archive of previous iterations and older version files. |

## 🛠 System Requirements

To simulate or synthesize this project, the following tools are recommended:

* **Synthesis & Implementation**: Xilinx Vivado Design Suite (for Zedboard deployment).
* **Simulation**: ModelSim, Questa, or Vivado Simulator (xsim).
* **Toolchain**: A RISC-V GCC toolchain with vector extension support (if compiling custom C code for the core).

## 🚀 Getting Started

### 1. Simulation
To verify the logic without hardware:
1.  Open your preferred HDL simulator (e.g., Vivado or ModelSim).
2.  Import the source files from the `src/` directory.
3.  Import the corresponding testbench from `testbenches/`.
4.  Run the behavioral simulation.

### 2. FPGA Deployment (Zedboard)
To run the design on physical hardware:
1.  Unzip **`RiscYZedboard.zip`**.
2.  Open the project file (`.xpr`) in Xilinx Vivado.
3.  Run Synthesis and Implementation.
4.  Generate the Bitstream.
5.  Program the Zedboard via JTAG using the Hardware Manager.

## 🧩 Key Features

* **Vector Extension**: Hardware support for RISC-V Vector (RVV) instructions.
* **Parallel Processing**: Architecture optimized for data-level parallelism.
* **SoC Integration**: Designed for integration with Zynq-7000 SoC (Zedboard).

## 👥 Contributors

* **[fmarkovitsis](https://github.com/fmarkovitsis)**

*See the attached PDF documentation for full academic credits and project details.*

---
*Note: This README was generated to verify the contents of the RVV_ext repository.*
