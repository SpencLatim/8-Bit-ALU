### 8-Bit ALU

Arithmatic Logic Units (ALU's) are critical components within most digital systems. It allows computations such as addition and multiplication as well as logical operations like NOT and AND to be use on data inputted into it, which are fundamental to most compututing done today. This project revolves around the creation of an 8 bit ALU on an FPGA, using the board peripherals to both display the results and control the input data. It can perform 15 different operations, and can be marked as complete due to the project vision being complete. 

### Getting started

The VHDL program was designed to run in Quartus on the DE10-lite FPGA board. The program simply has to be run in Quartus while having quartus recognize the FGPA board through the device settings. The switches are used to control the numbers inputted into the ALU, while a push button is used to signal that the operation should be performed. The first two switches from the right determine the 2 bit input, the next two switches the other 2-bit input, the next 4 being the operation code, and the final 2 being address to use when displaying the value from the memory. 
