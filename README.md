# Synchronous FIFO in Verilog

## Overview
This repository contains a simple synchronous FIFO (First-In, First-Out) implementation in Verilog. A synchronous FIFO is a circular buffer that operates on a single clock domain, commonly used for data buffering and synchronization between modules or systems.

## Design Details
- FIFO Depth: 32 entries
- Data Width: 32 bits
- Implementation: Built using a dual-port RAM module to support simultaneous read and write operations.
- Features: 
  - Full and empty flags (`fifo_full`, `fifo_empty`) for buffer status.
  - Write and read pointers with wrap-around logic.

## Tools
- **Compilation**: Cadence NC-Verilog (irun) or any standard Verilog compiler.
- **Simulation**: Cadence SimVision for waveform analysis.

## Implementation
The design consists of two modules:
1. `ram`: A dual-port RAM with 32-bit data width and 32-entry depth.
2. `sync_fifo`: The top-level FIFO module managing pointers and full/empty conditions.

See the code in [`sync_fifo.v`](./sync_fifo.v) for the full implementation.

### Port Description
| Port       | Width | Direction | Description               |
|------------|-------|-----------|---------------------------|
| `clk`      | 1     | Input     | Clock signal             |
| `rst_n`    | 1     | Input     | Active-low reset         |
| `we`       | 1     | Input     | Write enable             |
| `re`       | 1     | Input     | Read enable              |
| `wr_data`  | 32    | Input     | Data to write            |
| `rd_data`  | 32    | Output    | Data read from FIFO      |
| `fifo_full`| 1     | Output    | FIFO full flag           |
| `fifo_empty`| 1    | Output    | FIFO empty flag          |

## Verification
I’m currently developing a class-based testbench to verify the design, including:
- Correct read/write operations.
- Full and empty flag behavior.
- Edge cases (e.g., simultaneous read/write).

Simulation results and waveforms will be added once the testbench is complete.


