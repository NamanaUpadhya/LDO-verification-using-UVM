class ldo1_env extends uvm_env;
	
	ldo1_agnt agnt;
	ldo1_scb scb;

	`uvm_component_utils(ldo1_env)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agnt = ldo1_agnt::type_id::create("agnt",this);
		scb = ldo1_scb::type_id::create("scb",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		agnt.mon.mon_ap.connect(scb.scb_ap);
	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
	endfunction
	

endclass
