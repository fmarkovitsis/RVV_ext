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

This project implements a dedicated Vector Processing Unit (VPU) compliant with the RISC-V Vector Extension (RVV) specification. Designed to interface with a standard scalar RISC-V core, this extension unlocks data-level parallelism for tasks such as matrix operations, signal processing, and machine learning.

<table>
<tr>
<td width="50%">

**🔧 Core Technologies**
- **HDL:** Verilog & SystemVerilog
- **Synthesis:** Xilinx Vivado Design Suite
- **Target:** Zynq-7000 SoC (Zedboard)
- **Kernel:** Custom Linux Build

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

**📂 Location**: `src/`

This directory contains the Verilog/SystemVerilog source code defining the hardware logic.

| Module Type | Description |
|---|---|
| **Vector Arithmetic** | ALUs optimized for parallel integer and floating-point vector operations. |
| **Control Logic** | Decoders and sequencers handling RVV instruction dispatching. |
| **Register File** | Large vector register file (VRF) supporting multi-read/write ports. |
| **Memory Interface** | Load/Store units handling vector memory alignment and striding. |

</details>

### 🧪 Verification & Simulation
> **Testbenches to validate functional correctness**

<details>
<summary><b>🔍 Click to expand Testbench details</b></summary>

**📂 Location**: `testbenches/` & `Testbench/`

Contains simulation scripts and test vectors to verify individual modules and the full system integration.

- **Unit Tests:** Validate specific arithmetic blocks (e.g., vector adders, multipliers).
- **Integration Tests:** Verify the interaction between the scalar core and the vector extension.

</details>

### 📦 Deployment & Binaries
> **Files for physical implementation on FPGA**

| File | Description |
|---|---|
| `RiscYZedboard.zip` | Complete **Vivado Project** archive including constraints (`.xdc`) and IP configurations for the Zedboard. |
| `Final_linux.zip` | Bootable **Linux Image** and root filesystem tailored for the RISC-V SoC. |
| `DATED_files/` | Archive of historical design iterations. |

---

## 🛠️ System Architecture

The design follows a decoupled architecture where the scalar core handles control flow while offloading vector instructions to the VPU.

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
| **SD Card** | Used to boot the Linux image (`Final_linux.zip`). |

---

## 📦 Software Requirements

<div align="center">

### 🛠️ Development Environment

</div>

| Tool | Version | Purpose |
|------|---------|---------|
| **Xilinx Vivado Design Suite** | 2018.x or newer | Synthesis, Implementation, and Bitstream Generation |
| **Xilinx SDK / Vitis** | Matching Vivado | Software driver development and C/C++ application compilation |
| **ModelSim / Questa** | Optional | Advanced behavioral simulation |

### 🐧 Operating System Support

<div align="center">

![Windows](https://img.shields.io/badge/Windows-10%2F11-blue?style=flat-square&logo=windows)
![Linux](https://img.shields.io/badge/Linux-Ubuntu%2018.04+-orange?style=flat-square&logo=linux)

</div>

---

## 🚀 Getting Started

### 📋 Prerequisites

- [ ] **Xilinx Vivado** installed and licensed.
- [ ] **Digilent Zedboard** connected via USB-JTAG and UART.
- [ ] **SD Card** formatted (FAT32) for booting Linux.

### 🏁 Quick Start Guide

<details>
<summary><b>🔧 Click for setup instructions</b></summary>

#### 1️⃣ **Clone the Repository**
```bash
git clone https://github.com/fmarkovitsis/RVV_ext.git
cd RVV_ext
```

#### 2️⃣ **Extract and Open Vivado Project**
```bash
unzip RiscYZedboard.zip
```
- Open **Vivado Design Suite**
- Navigate to `File > Project > Open`
- Select the `.xpr` project file from the extracted directory

#### 3️⃣ **Synthesize and Implement Design**
- In Vivado, click **Run Synthesis**
- After completion, click **Run Implementation**
- Finally, click **Generate Bitstream**

#### 4️⃣ **Program the FPGA**
- Connect your Zedboard via JTAG
- Open **Hardware Manager** in Vivado
- Select **Program Device** and load the generated `.bit` file

#### 5️⃣ **Boot Linux (Optional)**
```bash
unzip Final_linux.zip
```
- Copy the extracted files to a FAT32-formatted SD card
- Insert the SD card into the Zedboard
- Power on the board and connect via UART (115200 baud)

</details>

---

## 📊 Key Features

### ✨ Vector Processing Capabilities

<div align="center">

| Feature | Description |
|---------|-------------|
| **🔢 Vector Register File** | 32 vector registers with configurable element width (8/16/32/64-bit) |
| **➕ Arithmetic Operations** | Add, subtract, multiply, divide, and fused multiply-add for integers and floats |
| **🔀 Permutation & Shuffle** | Flexible data reorganization within vector registers |
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

This project was developed as part of advanced computer architecture research. Contributions, bug reports, and feature requests are welcome!

### 🤝 How to Contribute

1. **Fork** the repository
2. Create a **feature branch** (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. Open a **Pull Request**

### 📧 Contact

For questions, collaboration, or support:
- **GitHub Issues**: [Report bugs or request features](https://github.com/fmarkovitsis/RVV_ext/issues)
- **Project Maintainer**: [@fmarkovitsis](https://github.com/fmarkovitsis)

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
- [FPGA Design Best Practices](https://www.intel.com/content/www/us/en/docs/programmable/683082/current/design-recommendations.html)

</td>
</tr>
</table>

### 🗂️ Repository Contents

```
RVV_ext/
├── src/                    # RTL source files (Verilog/SystemVerilog)
├── testbenches/           # Simulation testbenches
├── Testbench/             # Additional verification files
├── RiscYZedboard.zip      # Complete Vivado project archive
├── Final_linux.zip        # Linux bootable image for Zedboard
├── DATED_files/           # Historical design versions
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
