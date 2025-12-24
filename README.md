# RVV_ext: RISC-V Vector Extension Architecture

<div align="center">

![Language](https://img.shields.io/badge/Language-Verilog%20%7C%20SystemVerilog-green?style=for-the-badge&logo=verilog)
![Architecture](https://img.shields.io/badge/ISA-RISC--V-red?style=for-the-badge&logo=riscv)
![Platform](https://img.shields.io/badge/Platform-Xilinx%20Zedboard-blue?style=for-the-badge&logo=xilinx)
![License](https://img.shields.io/badge/License-Open%20Source-orange?style=for-the-badge)

**Hardware Implementation of RISC-V Vector Extensions (RVV)**

</div>

---

## 📋 Table of Contents

- [🎯 Project Overview](#-project-overview)
- [📁 Repository Structure](#-repository-structure)
- [🛠️ System Architecture](#-system-architecture)
- [💻 Hardware Requirements](#-hardware-requirements)
- [🚀 Getting Started](#-getting-started)
- [📊 Key Features](#-key-features)
- [👥 Contributors](#-contributors)
- [📄 Documentation](#-documentation)

---

## 🎯 Project Overview

This project implements a dedicated Vector Processing Unit (VPU) compliant with the RISC-V Vector Extension (RVV) specification. Having as a basis a working implementation of RISC-V, operating on the Zedboard FPGA, the RVV extension was also added to the circuit to enable parallel computing with multiple data. These operations can be used for matrix operations, signal processing and artificial intelligence.

<table>
<tr>
<td width="50%">

**🔧 Core Technologies**
- **HDL:** Verilog & SystemVerilog
- **Synthesis:** Xilinx Vivado Design Suite
- **Target:** Zynq-7000 SoC (Zedboard)

</td>
<td width="50%">

**⚡ Key Capabilities**
- SIMD (Single Instruction, Multiple Data) execution
- Configurable vector length
- Decoupled vector memory unit
- High-throughput arithmetic pipeline

</td>
</tr>
</table>

---

## 📁 Repository Structure

### 🧠 Core RTL Sources
> **The heart of the vector processor implementation**

<details>
<summary><b>🔍 Click to expand Source details</b></summary>

**📂 Location**: `COMPLETE_CPU_and_RVV/Nanousis RiscY main RISCY_primer25k/src/CPU`

This directory contains the Verilog/SystemVerilog source code defining the hardware logic.

| Module Type | Description |
|---|---|
| **sign_ext_64.v** | Extends the sign ofa bit vector to 64 bits. |
| **sign_ext_64_selector.v** | Secects between a vector register and a sign-extended scalar, depending on a given command. |
| **vRegFile.v** | Vector Register File. |
| **valu.v** | ALU that performs vector operations. |
| **vcontrol_bypass.v** | Bypass unit for resolving data dependencies within different stages of the pipeline without stalls. |
| **vgrouping_selector.v** | Controlls how many registers are grouped in order to exoress larger dimension vectors. |
| **vl_masking.v** | Masks off bit vector elements that are not needed, depending on the decided bit vector legth. |
| **vl_setup.v** | Calculates vector length (vl) based on SEW, vector resitster grouping and AVL, while also updating the value of AVL. |
| **vsetvl.v** | Decodes instructions that set vector unit parameters (SEW, AVL etc.). |
| **cpu_phil.v** | The final version of the CPU, including the functional version of the RVV. |
</details>

### 🧪 Verification & Simulation
> **Testbenches to validate functional correctness**

<details>
<summary><b>🔍 Click to expand Testbench details</b></summary>

**📂 Location**: `DATED_files/testbenches/`

Contains simulation scripts and test vectors to verify individual modules.

</details>

## 🛠️ System Architecture

The design aims to seemlessly handle both scalar and vector instructions, using the already implemented control unit. Whenever a scalar instruction is executed, the VPU stays in an idle state, not able to write on registers or memory, while when a vector instruction is executed, the opposite occurs.

---

## 💻 Hardware Requirements

<div align="center">

### 🎛️ Primary Development Board

<table>
<tr>
<td align="center" width="30%">
<img src="https://img.shields.io/badge/Avnet-Zedboard-blue?style=for-the-badge" alt="Zedboard"/>
</td>
<td width="70%">

**Avnet / Digilent Zedboard**
- **SoC**: Xilinx Zynq-7000 (XC7Z020-CLG484-1)
- **Architecture**: Dual-core ARM Cortex-A9 + Artix-7 Class FPGA
- **Memory**: 512 MB DDR3
- **Storage**: 256 Mb Quad-SPI Flash, 4 GB SD Card
- **Interface**: 10/100/1000 Ethernet, USB OTG, USB-UART
- **Display**: HDMI Output, VGA Output, OLED Display

</td>
</tr>
</table>

</div>

### 🔌 Connectivity & I/O
To fully utilize the design on the Zedboard, the following connections are standard:

| Interface | Usage |
|----------|-------|
| **USB-UART** | Serial console for Linux/Bare-metal terminal access (115200 baud). |
| **JTAG** | For programming the bitstream via Vivado Hardware Manager. |
---

## 📦 Software Requirements

<div align="center">

### 🛠️ Development Environment

</div>

| Tool | Version | Purpose |
|------|---------|---------|
| **Xilinx Vivado Design Suite** | 2018.x or newer | Synthesis, Implementation, and Bitstream Generation |
| **GTK Wave & Icarus Verilog** | Newest Versions | For checking the waveforms during debugging |

---

## 🚀 Getting Started

### 📋 Prerequisites

- [ ] **Xilinx Vivado** installed and licensed.
- [ ] **Digilent Zedboard** connected via USB-JTAG and UART.

### 🏁 Quick Start Guide

#### 1️⃣ **Clone the Repository**
```bash
git clone https://github.com/fmarkovitsis/RVV_ext.git
cd RVV_ext
```

#### 2️⃣ **Open Vivado Project**

- Open **Vivado Design Suite**
- Create a new project, with Zedboard as the target device
- Drop the files contained in `COMPLETE_CPU_and_RVV_zedboard/RiscYZedboard\RiscYZedboard.srcs/sources_1/imports/RiscyVivadoWorking.srcs/sources_1/imports/src/CPU` in sources and the files contained in `COMPLETE_CPU_and_RVV_zedboard/RiscYZedboard/RiscYZedboard.srcs/constrs_1/imports/vga_zedboard-master`

#### 3️⃣ **Synthesize and Implement Design**
- In Vivado, click **Run Synthesis**
- After completion, click **Run Implementation**
- Finally, click **Generate Bitstream**

#### 4️⃣ **Program the FPGA**
- Connect your Zedboard via JTAG
- Open **Hardware Manager** in Vivado
- Select **Program Device** and load the generated `.bit` file

</details>

---

## 📊 Key Features

### ✨ Vector Processing Capabilities

<div align="center">

| Feature | Description |
|---------|-------------|
| **🔢 Vector Register File** | 32 vector registers with configurable element width (8/16/32/64-bit) |
| **➕ Arithmetic Operations** | Add, subtract, multiply, divide, and fused multiply-add for integers and floats |
| **💾 Memory Operations** | Unit-stride, strided, and indexed load/store patterns |
| **🎭 Masking Support** | Predicated execution for conditional vector operations |
| **⚡ Configurable VLEN** | Adjustable vector length for performance/area trade-offs |

</div>

### 🎯 RVV Compliance

This implementation targets **RISC-V Vector Extension v1.0** specification compliance, supporting:

- **Vector-Vector Operations**: Element-wise operations between vector registers
- **Vector-Scalar Operations**: Broadcasting scalar values across vector elements
- **Vector Load/Store**: Efficient memory access patterns
- **Vector Reductions**: Sum, min, max operations across vector elements
- **Widening/Narrowing**: Operations that change element width

---

## 👥 Contributors

<div align="center">

### 🌟 Project Team

</div>

This project was developed as part of ECE338 - Parallel Computer Architecture Course in University of Thessaly. Contributions, bug reports, and feature requests are welcome!

### 🤝 How to Contribute

1. **Fork** the repository
2. Create a **feature branch** (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. Open a **Pull Request**

### 📧 Contact

For questions, collaboration, or support:
- **GitHub Issues**: [Report bugs or request features](https://github.com/fmarkovitsis/RVV_ext/issues)

---

## 📄 Documentation

### 📚 Additional Resources

<table>
<tr>
<td width="50%">

**🔍 Technical References**
- [RISC-V Vector Extension Spec v1.0](https://github.com/riscv/riscv-v-spec)
- [Xilinx Zynq-7000 Technical Reference](https://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf)
- [Vivado Design Suite User Guide](https://www.xilinx.com/support/documentation/sw_manuals/xilinx2018_1/ug893-vivado-ide.pdf)

</td>
<td width="50%">

**📖 Learning Materials**
- [RISC-V ISA Manual](https://riscv.org/technical/specifications/)
- [Vector Processing Fundamentals](https://en.wikipedia.org/wiki/Vector_processor)
</td>
</tr>
</table>

### 🗂️ Repository Contents

```
RVV_ext/
├── COMPLETE_CPU_and_RVV/                # FINAL RTL source files for both the vanilla and RVV units 
├── COMPLETE_CPU_and_RVV_zedboard/       # Same files with COMPLETE_CPU_and_RVV, included constrain files and tested on zedboard
├── RawSourceFiles                       # A functional version of the RVV extension, yet incomplete 
├── DATED_files/                         # Historical design versions
├── Project - Parallel Architecture.pdf  # A presentation explaining further the sub-units implemented for the extension
├── Vector_Instructions_Project.pdf/     # A report, describing the implemented modules and the supported instructions
└── README.md              # This file
```

---

## 📜 License

This project is open-source and available for academic and research purposes. Please refer to the repository for specific licensing terms.

---

## 🙏 Acknowledgments

- **RISC-V Foundation** for the open ISA specification
- **Xilinx** for FPGA tools and development boards
- The **open-source hardware community** for inspiration and support

---

## 📊 Project Status

<div align="center">

![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-1.0-blue?style=for-the-badge)
![Contributions](https://img.shields.io/badge/Contributions-Welcome-orange?style=for-the-badge)

</div>

### 🚧 Roadmap

- [x] Core vector arithmetic units
- [x] Vector register file implementation
- [x] Memory interface and load/store units
- [x] Basic RVV instruction support
- [ ] Full RVV 1.0 specification compliance
- [ ] Performance optimizations
- [ ] Extended precision floating-point
- [ ] Advanced vector permutation operations

---

<div align="center">

**⭐ If you find this project useful, please consider giving it a star! ⭐**

</div>
