
# RISC-V Monocycle Processor — VHDL on Altera DE1 FPGA

A fully functional 32-bit monocycle processor implementing the **RISC-V RV32I** architecture, designed in VHDL and synthesized on an **Altera DE1 FPGA** using Quartus II 13.0.

Developed as part of the Digital Electronics II laboratory at **Universidad Pedagógica y Tecnológica de Colombia (UPTC) — Sogamoso**.

---

## Supported Instructions

| Type | Instructions |
|------|-------------|
| I    | `addi`, `slti`, `ori`, `andi`, `lw` |
| R    | `add`, `sub`, `slt`, `or`, `and` |
| S    | `sw` |
| B    | `beq` |
| J    | `jal` |

---

## Architecture

The processor follows a classic monocycle datapath where every instruction completes in a single clock cycle. All stages — fetch, decode, execute, memory access, and write-back — occur within one clock pulse.

```
┌─────────┐    ┌──────────┐    ┌──────────────┐    ┌─────┐    ┌────────────┐
│   PC    │───▶│   ROM    │───▶│ Control_unit │───▶│ ALU │───▶│  BancoReg  │
│ (+4)    │    │ (512x32) │    │              │    │     │    │            │
└─────────┘    └──────────┘    └──────────────┘    └─────┘    └────────────┘
                                      │                              │
                               ┌──────▼──────┐                ┌─────▼──────┐
                               │Extensor_    │                │    RAM     │
                               │Signo        │                │ (LW / SW)  │
                               └─────────────┘                └────────────┘
```

### Modules

| File | Description |
|------|-------------|
| `PC.vhd` | 32-bit Program Counter with synchronous reset |
| `SUM.vhd` | PC+4 incrementer |
| `Sumador.vhd` | Branch target address adder |
| `ROM.vhd` | 512×32-bit instruction memory, initialized in VHDL |
| `BancoReg.vhd` | 32×32-bit register file, dual read / single write |
| `ALU.vhd` | 3-bit controlled ALU: ADD, SUB, AND, OR, SLT |
| `Extensor_Signo.vhd` | 2-bit controlled sign extender for I/S/B/J immediates |
| `RAM.vhd` | Data memory for LW and SW instructions |
| `Control_unit.vhd` | Main decoder: generates Branch, Jump, BRwr, ALUsrc, ALUop, MemWr, ResSrc |
| `MUX_ALU.vhd` | Multiplexer: register vs immediate selection for ALU input |
| `MUX_PC.vhd` | Multiplexer: PC+4 vs branch/jump target |
| `MUX_ResSCR.vhd` | Multiplexer: ALU result vs memory data for writeback |
| `procesador.vhd` | Structural top-level — connects all modules via port mapping |

---

## Key Specifications

| Parameter | Value |
|-----------|-------|
| ISA | RISC-V RV32I (subset) |
| Data width | 32 bits |
| Instruction memory | 512 words × 32 bits (ROM, VHDL-initialized) |
| Register file | 32 registers × 32 bits |
| ALU control | 3-bit signal |
| Sign extender control | 2-bit signal (I, S, B, J types) |
| Addressing | Byte-addressed, word-aligned (bits [10:2] used for ROM index) |
| Target board | Altera DE1 (Cyclone II) |
| Synthesis tool | Quartus II 13.0 |
| Clock source | DE1 onboard 50 MHz oscillator |

---

## Hardware Verification

The processor was synthesized and deployed on the Altera DE1 board. Correct execution was verified using RISC-V assembly programs loaded into the ROM, with real-time output observed on the board's peripherals:

- **8 LEDs** — connected to register X31 (bits [7:0]), used to display operand values and operation results
- **4× 7-segment displays** — used to show operands, operation identifiers (`Add`, `Sub`, `dIG1`, `EqU`, etc.), and hexadecimal counter output
- **DIP switches** — mapped to register X26 for runtime input (light sequence selector)

### Assembly programs verified on hardware

**Task 1 — Basic ALU operations demo**
Sequentially demonstrates `addi`, `add`, `sub`, `and`, `andi`, `or`, `ori`, `slt` with timed display stages:
- Stage 1: first operand on 7-segment display + LEDs
- Stage 2: operation name on display
- Stage 3: second operand on display + LEDs
- Stage 4: result on LEDs

**Task 2 — Hexadecimal counter**
Cyclic 0x0–0xF counter on 7-segment display. Count frequency adjustable via immediate value in assembly timing loop.

**Task 3 — Light sequences**
4 different LED patterns selected via 2-bit DIP switch input (register X26), running cyclically.

---

## Repository Structure

```
risc-v-monocycle-vhdl/
├── src/
│   ├── procesador.vhd        # Top-level structural instantiation
│   ├── PC.vhd
│   ├── SUM.vhd
│   ├── Sumador.vhd
│   ├── ROM.vhd
│   ├── BancoReg.vhd
│   ├── ALU.vhd
│   ├── Extensor_Signo.vhd
│   ├── RAM.vhd
│   ├── Control_unit.vhd
│   ├── MUX_ALU.vhd
│   ├── MUX_PC.vhd
│   └── MUX_ResSCR.vhd
├── asm/
│   ├── task1_alu_demo.asm
│   ├── task2_hex_counter.asm
│   └── task3_light_sequences.asm
├── sim/
│   └── waveforms/            # ModelSim/Quartus simulation screenshots
├── images/
│   └──                       # Hardware verification photos (DE1 board)
└── README.md
```

---

## Known Limitations

- **No LUI/AUIPC support** — upper immediate instructions not implemented; large constants require multiple `addi` sequences
- **ROM size** — 512 instructions maximum; addresses beyond `0x7FF` fall into uninitialized memory (`0x00000000`)
- **Single-cycle constraint** — clock period must accommodate the longest instruction path (LW: fetch → decode → ALU → memory → writeback)
- **No interrupt or exception handling**

---

## Tools

- **Quartus II 13.0** — synthesis and place-and-route
- **ModelSim** — functional simulation and waveform verification
- **RARS** — RISC-V assembly simulator used for program development and pre-synthesis validation

---

## References

- Patterson, D. A., & Hennessy, J. L. (2017). *Computer Organization and Design: The Hardware/Software Interface*. Morgan Kaufmann.
- Hennessy, J. L., & Patterson, D. A. (2019). *Computer Architecture: A Quantitative Approach*. Morgan Kaufmann.
- RISC-V ISA Specification: [riscv.org](https://riscv.org/technical/specifications/)

---

## Author

**Cristian Manuel Toba López**  
Electronics Engineering Student — UPTC Sogamoso, Colombia  
GitHub: [github.com/cristian-toba](https://github.com/cristian-toba)
