# HDL
This repository contains an embedded VHDL-based audio processor capable of interpreting and executing an 8-bit instruction set for audio playback. The processor's architecture includes a central processing unit (CPU) with a state machine for managing various audio commands such as Play, Pause, Seek, and Stop.

## Project Directory Structure
- **doc**: contains datasheet of WM8731 Audio Codec
- **hw**: contains scripts to compile design and program to the DEC-1 SoC Board
- **parser**: contains audio file example and 8-bit instructions
- **sim**: contains testbench, and scripts for simulating on ModelSim
- **src**: contains all source code, including top level design and 8-bit instructions
   
## Instruction Set
The processor supports the following 8-bit instructions:
- **Play** (0 0 RPT NA NA NA NA NA)
  - RPT: Determines whether the audio should repeat
- **Pause** (0 1 NA NA NA NA NA NA)
  - Pauses audio playback while maintaining the memory pointer position
- **Seek** (1 0 NA SK4 SK3 SK2 SK1 SK0)
  - Adjusts the memory address based on the 5-bit seek instruction
- **Stop** (1 1 NA NA NA NA NA NA)
  - Stops audio playback and resets the memory pointer to zero

## Components
- **Instruction Memory**: Stores a set of predefined audio instructions.
- **Audio Codec**: Interfaces with the processor for audio data output
- **Control Unit**: Manages the coordination between the ALU and registers

## Additional Notes
Quartus Prime and ModelSim were the main software applications used in this project. Quartus Prime was used to compile design and upload to the DEC-1 SoC Board, as well as the In-System Memory Editor in order to give the system real-time modifications. ModelSim was used to simulate a verify the operation of the design through the testbench. 
