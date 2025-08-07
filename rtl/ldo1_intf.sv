`include "uvm_macros.svh"
import uvm_pkg::*;

interface ldo1_intf(input logic clk);

 real EN_LDO1;
 real DISCHG_LDO1;
 real DVS_ON_LDO1;
 real VREF_OP85V_LDO1;
 real RESET_LDO1;
 real PAD_LDO1;
 real VDD_IO_LDO1;
 real VDD_LDO1;
 real GND_LDO1;
 real PBKG;
 real PWROK_LDO1;	

 logic [3:0] VSEL_LDO1;

endinterface
