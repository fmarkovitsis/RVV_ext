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

```mermaid
