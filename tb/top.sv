`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

module top_tb;
	
	logic clk = 0;
	always #5 clk= ~clk;

	ldo1_intf ldo_vif(clk);

	ldo_1 dut(
			.EN_LDO1(ldo_vif.EN_LDO1),
			.DISCHG_LDO1(ldo_vif.DISCHG_LDO1),
			.VSEL_LDO1(ldo_vif.VSEL_LDO1),
			.DVS_ON_LDO1(ldo_vif.DVS_ON_LDO1),
			.VREF_OP85V_LDO1(ldo_vif.VREF_OP85V_LDO1),
			.RESET_LDO1(ldo_vif.RESET_LDO1),
			.PAD_LDO1(ldo_vif.PAD_LDO1),
			.VDD_IO_LDO1(ldo_vif.VDD_IO_LDO1),
			.VDD_LDO1(ldo_vif.VDD_LDO1),
			.GND_LDO1(ldo_vif.GND_LDO1),
			.PBKG(ldo_vif.PBKG),
			.PWROK_LDO1(ldo_vif.PWROK_LDO1)
			);

	initial begin
		uvm_config_db#(virtual ldo1_intf)::set(null,"*","vif",ldo_vif);
		run_test();	
		$finish;
	end

endmodule
