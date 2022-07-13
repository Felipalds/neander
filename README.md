# neander
Final project of <b>Digital Systems</b> - a simple, theoric computer.

## Purpouse
- Computer Architecture inspired in IAS Computer from <i>Von Neumann</v>
- <i>"It is too simple that you, without much work, can program it and project it"</i>

## Von Neumann Architecture
- Without in and out
- Memory and CPU only
- The data and the controll signals is in the same architecture

## General Work
- Control Unit catch the instruction
- Decodify it
- Activate Control Signals
  - Activate memory search
  - Activate Logic Arithmetic Unit

## Data Type
- 1 int data (1 byte)
- 2's complement

## CU - control unity
- automatization of Neander
- need a counter
- it is a combinational system!!!!!
- all execute same time, decod says which will be the output
- every time that you touch a registrator, it is a clock cycle
- just increment PC after RdM
- add or and not is the same with a mux controling ula op

// no pc de verdade, acontece a busca com o endereço de memória da linguagem?
// o valor das instruções tb vai para a ula?