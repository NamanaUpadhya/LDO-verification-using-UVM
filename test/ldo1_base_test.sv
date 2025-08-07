class ldo1_base_test extends uvm_test;
	
	`uvm_component_utils(ldo1_base_test)

	ldo1_env env;
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		env = ldo1_env::type_id::create("env",this);
	endfunction	

endclass
//--------------------------------------------------------------------//
class dvs_0_ramp_up_test extends ldo1_base_test;
	
	`uvm_component_utils(dvs_0_ramp_up_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		dvs_0_ramp_up_seq seq = dvs_0_ramp_up_seq::type_id::create("seq",this);
		phase.raise_objection(this);
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);
	endtask

endclass
//--------------------------------------------------------------------//
class dvs_1_ramp_up_test extends ldo1_base_test;
	
	`uvm_component_utils(dvs_1_ramp_up_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		
		dvs_1_ramp_up_seq seq = dvs_1_ramp_up_seq::type_id::create("seq",this);
		sanity_seq san_seq = sanity_seq::type_id::create("san_seq",this);

		phase.raise_objection(this);
		san_seq.start(env.agnt.sqr);
		#1ms;
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);

	endtask

endclass
//--------------------------------------------------------------------//
class dvs_0_ramp_down_test extends ldo1_base_test;
	
	`uvm_component_utils(dvs_0_ramp_down_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		dvs_0_ramp_down_seq seq = dvs_0_ramp_down_seq::type_id::create("seq",this);
		phase.raise_objection(this);
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);
	endtask

endclass
//--------------------------------------------------------------------//
class dvs_1_ramp_down_test extends ldo1_base_test;
	
	`uvm_component_utils(dvs_1_ramp_down_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		
		dvs_1_ramp_down_seq seq = dvs_1_ramp_down_seq::type_id::create("seq",this);
		sanity_seq san_seq = sanity_seq::type_id::create("san_seq",this);

		phase.raise_objection(this);
		san_seq.start(env.agnt.sqr);
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);

	endtask

endclass
//--------------------------------------------------------------------//
class disable_en_test extends ldo1_base_test;
	
	`uvm_component_utils(disable_en_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		
		disable_en_seq seq = disable_en_seq::type_id::create("seq",this);
		sanity_seq san_seq = sanity_seq::type_id::create("san_seq",this);

		phase.raise_objection(this);
		san_seq.start(env.agnt.sqr);
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);

	endtask

endclass
//--------------------------------------------------------------------//
class vdd_out_of_range_test extends ldo1_base_test;
	
	`uvm_component_utils(vdd_out_of_range_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		
		vdd_out_of_range_seq seq = vdd_out_of_range_seq::type_id::create("seq",this);
		sanity_seq san_seq = sanity_seq::type_id::create("san_seq",this);

		phase.raise_objection(this);
		san_seq.start(env.agnt.sqr);
		seq.start(env.agnt.sqr);
		#5ms;
		phase.drop_objection(this);

	endtask

endclass
//--------------------------------------------------------------------//
class reset_test extends ldo1_base_test;
	
	`uvm_component_utils(reset_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		
		reset_seq seq = reset_seq::type_id::create("seq",this);
		sanity_seq san_seq = sanity_seq::type_id::create("san_seq",this);

		phase.raise_objection(this);
		san_seq.start(env.agnt.sqr);
		seq.start(env.agnt.sqr);
		#5ms;
		phase.drop_objection(this);

	endtask

endclass
//--------------------------------------------------------------------//
class discharge_test extends ldo1_base_test;
	
	`uvm_component_utils(discharge_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		
		discharge_seq seq = discharge_seq::type_id::create("seq",this);
		sanity_seq san_seq = sanity_seq::type_id::create("san_seq",this);

		phase.raise_objection(this);
		san_seq.start(env.agnt.sqr);
		seq.start(env.agnt.sqr);
		#5ms;
		phase.drop_objection(this);

	endtask

endclass
//--------------------------------------------------------------------//
class dvs_0_ramp_up_imd_test extends ldo1_base_test;
	
	`uvm_component_utils(dvs_0_ramp_up_imd_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		dvs_0_ramp_up_imd_seq seq = dvs_0_ramp_up_imd_seq::type_id::create("seq",this);
		phase.raise_objection(this);
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);
	endtask

endclass
//--------------------------------------------------------------------//
class dvs_1_ramp_up_imd_test extends ldo1_base_test;
	
	`uvm_component_utils(dvs_1_ramp_up_imd_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		
		dvs_1_ramp_up_imd_seq seq = dvs_1_ramp_up_imd_seq::type_id::create("seq",this);
		sanity_seq san_seq = sanity_seq::type_id::create("san_seq",this);

		phase.raise_objection(this);
		san_seq.start(env.agnt.sqr);
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);

	endtask

endclass
//--------------------------------------------------------------------//
class dvs_0_ramp_down_imd_test extends ldo1_base_test;
	
	`uvm_component_utils(dvs_0_ramp_down_imd_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		dvs_0_ramp_down_imd_seq seq = dvs_0_ramp_down_imd_seq::type_id::create("seq",this);
		phase.raise_objection(this);
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);
	endtask

endclass
//--------------------------------------------------------------------//
class dvs_1_ramp_down_imd_test extends ldo1_base_test;
	
	`uvm_component_utils(dvs_1_ramp_down_imd_test)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	task run_phase(uvm_phase phase);
		
		dvs_1_ramp_down_imd_seq seq = dvs_1_ramp_down_imd_seq::type_id::create("seq",this);
		sanity_seq san_seq = sanity_seq::type_id::create("san_seq",this);

		phase.raise_objection(this);
		san_seq.start(env.agnt.sqr);
		seq.start(env.agnt.sqr);
		phase.drop_objection(this);

	endtask

endclass
//--------------------------------------------------------------------//

