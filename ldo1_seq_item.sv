class ldo1_seq_item extends uvm_sequence_item;

	rand real EN_LDO1;
	rand real DISCHG_LDO1;
	rand real DVS_ON_LDO1;
	rand real VREF_OP85V_LDO1;
	rand real RESET_LDO1;
	randc logic [3:0] VSEL_LDO1;
	rand real VDD_IO_LDO1;
 	rand real VDD_LDO1;
 	rand real GND_LDO1;
 	rand real PBKG;
 	
	real PWROK_LDO1;//to monitor output
	real PAD_LDO1;

	`uvm_object_utils(ldo1_seq_item)
	
	function  new(string name="ldo1_seq_item");
		super.new(name);
    endfunction

endclass
