# RVV_ext: RISC-V Vector Extension Architecture

<div align="center">

![Language](https://img.shields.io/badge/Language-Verilog%20%7C%20SystemVerilog-green?style=for-the-badge&logo=verilog)
![Architecture](https://img.shields.io/badge/ISA-RISC--V-red?style=for-the-badge&logo=riscv)
![Platform](https://img.shields.io/badge/Platform-Xilinx%20Zedboard-blue?style=for-the-badge&logo=xilinx)
![License](https://img.shields.io/badge/License-Open%20Source-orange?style=for-the-badge)

**Hardware Implementation of RISC-V Vector Extensions (RVV)**

*Optimized for Parallel Processing and SoC Integration*

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

**RVV_ext** represents a significant step in open-source hardware acceleration. This project implements a dedicated Vector Processing Unit (VPU) compliant with the RISC-V Vector Extension (RVV) specification. Designed to interface with a standard scalar RISC-V core, this extension unlocks massive data-level parallelism for tasks such as matrix operations, signal processing, and machine learning.

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
</details>
