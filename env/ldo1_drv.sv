class ldo1_drv extends uvm_driver #(ldo1_seq_item);
	
	virtual ldo1_intf vif;

	`uvm_component_utils(ldo1_drv)
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual ldo1_intf)::get(this,"","vif",vif))
			`uvm_fatal(get_type_name(),"Virtual intf not set");
	endfunction

	task run_phase(uvm_phase phase);
		forever begin
			ldo1_seq_item tx;
			tx = ldo1_seq_item::type_id::create("tx");
			seq_item_port.get_next_item(tx);
			
			vif.EN_LDO1 <= tx.EN_LDO1;
			vif.DVS_ON_LDO1 <= tx.DVS_ON_LDO1;
			vif.DISCHG_LDO1 <= tx.DISCHG_LDO1;
			vif.VSEL_LDO1 <= tx.VSEL_LDO1;
			vif.VREF_OP85V_LDO1 <= tx.VREF_OP85V_LDO1;
			vif.RESET_LDO1 <= tx.RESET_LDO1;
			vif.VDD_IO_LDO1 <= tx.VDD_IO_LDO1;
			vif.VDD_LDO1 <= tx.VDD_LDO1;
			vif.GND_LDO1 <= tx.GND_LDO1;
			vif.PBKG <= tx.PBKG;
			
			tx.PAD_LDO1 <= vif.PAD_LDO1;
			tx.PWROK_LDO1 <= vif.PWROK_LDO1;
			seq_item_port.item_done();
		end
	endtask
endclass
