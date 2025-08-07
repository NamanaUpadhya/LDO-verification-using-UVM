class ldo1_agnt extends uvm_agent;
	ldo1_drv drv;
	ldo1_mon mon;
	uvm_sequencer #(ldo1_seq_item) sqr;

	`uvm_component_utils(ldo1_agnt)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sqr = uvm_sequencer#(ldo1_seq_item)::type_id::create("sqr",this);
		drv = ldo1_drv::type_id::create("drv",this);
		mon = ldo1_mon::type_id::create("mon",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction

endclass
