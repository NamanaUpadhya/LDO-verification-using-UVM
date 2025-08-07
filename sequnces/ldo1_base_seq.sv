class ldo1_base_seq extends uvm_sequence#(ldo1_seq_item);
	
	`uvm_object_utils(ldo1_base_seq)

	function new(string name="ldo1_base_seq");
		super.new(name);
	endfunction
	
	virtual task pre_cfg(ldo1_seq_item tx);
		tx.EN_LDO1 = 1.8;
		tx.DISCHG_LDO1 = 0;
		tx.VDD_LDO1 = 3.65;
		tx.VDD_IO_LDO1 = 1.8;
		tx.GND_LDO1 = 0;
		tx.PBKG = 0;
		tx.VREF_OP85V_LDO1 = 0.85;
		tx.RESET_LDO1 = 0;
		tx.DVS_ON_LDO1 = 0;
		tx.VSEL_LDO1 = 4'b0000;
		//#100_000ns;
	endtask

	endclass
//-------------------------------------------------------------------//
//NOTE: when dvs=1 it takes longer time to reach to 2.55 from 0V so make dvs=0 and vsel=0 then check for dvs=1
class sanity_seq extends ldo1_base_seq;
	`uvm_object_utils(sanity_seq)

	function new(string name="sanity_seq");
		super.new(name);
	endfunction
	
	task body();
				
			ldo1_seq_item tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 0;
			tx.VSEL_LDO1 = 0;
			finish_item(tx);
			#100_000ns;
	endtask
endclass
//-------------------------------------------------------------------//
class dvs_0_ramp_up_seq extends ldo1_base_seq;
	`uvm_object_utils(dvs_0_ramp_up_seq)

	function new(string name="dvs_0_ramp_up_seq");
		super.new(name);
	endfunction
	
	task body();
				
		for(int i=0; i<16; i++)begin
			ldo1_seq_item tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 0;
			tx.VSEL_LDO1 = i[3:0];
			finish_item(tx);
			#100_000ns;
		end
	endtask
endclass
//-------------------------------------------------------------------//
class dvs_1_ramp_up_seq extends ldo1_base_seq;
	`uvm_object_utils(dvs_1_ramp_up_seq)

	function new(string name="dvs_1_ramp_up_seq");
		super.new(name);
	endfunction
	
	task body();
				
		for(int i=0; i<16; i++)begin
			ldo1_seq_item tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1 = i[3:0];
			finish_item(tx);
			#100_000ns;
		end
	endtask
endclass
//-------------------------------------------------------------------//
class dvs_0_ramp_down_seq extends ldo1_base_seq;
	`uvm_object_utils(dvs_0_ramp_down_seq)

	function new(string name="dvs_0_ramp_down_seq");
		super.new(name);
	endfunction
	
	task body();
				
		for(int i=15; i>=0; i--)begin
			ldo1_seq_item tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 0;
			tx.VSEL_LDO1 = i[3:0];
			finish_item(tx);
			#100_000ns;
		end
	endtask
endclass
//-------------------------------------------------------------------//
class dvs_1_ramp_down_seq extends ldo1_base_seq;
	`uvm_object_utils(dvs_1_ramp_down_seq)

	function new(string name="dvs_1_ramp_down_seq");
		super.new(name);
	endfunction
	
	task body();
				
		for(int i=15; i>=0; i--)begin
			ldo1_seq_item tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1 = i[3:0];
			finish_item(tx);
			#100_000ns;
		end
	endtask
endclass
//-------------------------------------------------------------------//
class disable_en_seq extends ldo1_base_seq;
	`uvm_object_utils(disable_en_seq)

	function new(string name="disable_en_seq");
		super.new(name);
	endfunction
	
	task body();
		begin	
			ldo1_seq_item tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			//pre_cfg(tx);
			tx.DISCHG_LDO1 = 0;
			tx.VDD_LDO1 = 3.65;
			tx.VDD_IO_LDO1 = 1.8;
			tx.GND_LDO1 = 0;
			tx.PBKG = 0;
			tx.VREF_OP85V_LDO1 = 0.85;
			tx.RESET_LDO1 = 0;
			tx.EN_LDO1 = 0;
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1 = 8;
			finish_item(tx);
			#5ms;
		end
	endtask
endclass
//-------------------------------------------------------------------//
class vdd_out_of_range_seq extends ldo1_base_seq;
	`uvm_object_utils(vdd_out_of_range_seq)

	function new(string name="vdd_out_of_range_seq");
		super.new(name);
	endfunction
	
	task body();
				
		for(int i=15; i>=0; i--)begin
			ldo1_seq_item tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.VDD_LDO1 = 1;
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1 = i[3:0];
			finish_item(tx);
			#100_000ns;
		end
	endtask
endclass
//-------------------------------------------------------------------//
class reset_seq extends ldo1_base_seq;
	`uvm_object_utils(reset_seq)

	function new(string name="reset_seq");
		super.new(name);
	endfunction
	
	task body();
				
		for(int i=15; i>=0; i--)begin
			ldo1_seq_item tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.RESET_LDO1 = 1.8;
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1 = i[3:0];
			finish_item(tx);
			#100_000ns;
		end
	endtask
endclass
//-------------------------------------------------------------------//
class discharge_seq extends ldo1_base_seq;
	`uvm_object_utils(discharge_seq)

	function new(string name="discharge_seq");
		super.new(name);
	endfunction
	
	task body();
				
		for(int i=15; i>=0; i--)begin
			ldo1_seq_item tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DISCHG_LDO1 = 1.8;
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1 = i[3:0];
			finish_item(tx);
			#100_000ns;
		end
	endtask
endclass
//-------------------------------------------------------------------//
class dvs_0_ramp_up_imd_seq extends ldo1_base_seq;
	`uvm_object_utils(dvs_0_ramp_up_imd_seq)

	function new(string name="dvs_0_ramp_up_imd_seq");
		super.new(name);
	endfunction
	
	task body();
		begin	
			ldo1_seq_item tx;
			
			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 0;
			tx.VSEL_LDO1[3:0] = 3;
			finish_item(tx);
			#100_000ns;

			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 0;
			tx.VSEL_LDO1[3:0] = 8;
			finish_item(tx);
			#100_000ns;

			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 0;
			tx.VSEL_LDO1[3:0] = 15;
			finish_item(tx);
			#100_000ns;

		end
	endtask
endclass
//-------------------------------------------------------------------//
class dvs_1_ramp_up_imd_seq extends ldo1_base_seq;
	`uvm_object_utils(dvs_1_ramp_up_imd_seq)

	function new(string name="dvs_1_ramp_up_imd_seq");
		super.new(name);
	endfunction
	
	task body();
		begin	
			ldo1_seq_item tx;
			
			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1[3:0] = 3;
			finish_item(tx);
			#2ms;

			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1[3:0] = 5;
			finish_item(tx);
			#2ms;

			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1[3:0] = 15;
			finish_item(tx);
			#2ms;

		end
	endtask
endclass
//-------------------------------------------------------------------//
class dvs_0_ramp_down_imd_seq extends ldo1_base_seq;
	`uvm_object_utils(dvs_0_ramp_down_imd_seq)

	function new(string name="dvs_0_ramp_down_imd_seq");
		super.new(name);
	endfunction
	
	task body();
		begin	
			ldo1_seq_item tx;
			
			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 0;
			tx.VSEL_LDO1[3:0] = 15;
			finish_item(tx);
			#100_000ns;

			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 0;
			tx.VSEL_LDO1[3:0] = 8;
			finish_item(tx);
			#100_000ns;

			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 0;
			tx.VSEL_LDO1[3:0] = 2;
			finish_item(tx);
			#100_000ns;

		end
	endtask
endclass
//-------------------------------------------------------------------//
class dvs_1_ramp_down_imd_seq extends ldo1_base_seq;
	`uvm_object_utils(dvs_1_ramp_down_imd_seq)

	function new(string name="dvs_1_ramp_down_imd_seq");
		super.new(name);
	endfunction
	
	task body();
		begin	
			ldo1_seq_item tx;
			
			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1[3:0] = 15;
			finish_item(tx);
			#2ms;

			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1[3:0] = 5;
			finish_item(tx);
			#2ms;

			tx = ldo1_seq_item::type_id::create("tx");
			start_item(tx);
			pre_cfg(tx);
			tx.DVS_ON_LDO1 = 3;
			tx.VSEL_LDO1[3:0] = 2;
			finish_item(tx);
			#2ms;

		end
	endtask
endclass
//-------------------------------------------------------------------//
