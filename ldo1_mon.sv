`define VDD_IO_LDO1_min 1.65
`define VDD_IO_LDO1_max 3.3

class ldo1_mon extends uvm_component;
	
	virtual ldo1_intf vif;
	uvm_analysis_port #(ldo1_seq_item) mon_ap;

	`uvm_component_utils(ldo1_mon)


	real prev_EN,prev_DVS,prev_DISCHG,prev_RESET,prev_VDD;
	logic [3:0]prev_VSEL;

	function new(string name, uvm_component parent);
		super.new(name,parent);
		mon_ap = new("mon_ap",this);
		//set prev values
		prev_VSEL = 4'bxxxx;
		prev_VDD = 1.0/0.0;
		prev_RESET = 1.0/0.0;
		prev_DISCHG = 1.0/0.0;
		prev_DVS = 1.0/0.0;
		prev_EN = 1.0/0.0;

	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual ldo1_intf)::get(this,"","vif",vif))
			`uvm_fatal(get_type_name(),"Virtual intf not set");
	endfunction

	//to check prev and curr values are different
	function bit real_changd(real a,real b, real tol = 1e-6);
		if(a !== a || b!==b)
			return 1'b1;
		return ((a-b)>tol) || ((b-a)>tol);
	endfunction
	
	//to check 2 values are equal or not
	function real fabs(real val);
		return (val<0) ? -val : val;
	endfunction

	function real get_expt_pad(logic [3:0] vsel);
		case(vsel)
			4'b0000: return 2.55;
			4'b0001: return 2.60;
			4'b0010: return 2.65;
			4'b0011: return 2.70;
			4'b0100: return 2.75;
			4'b0101: return 2.80;
			4'b0110: return 2.85;
			4'b0111: return 2.90;
			4'b1000: return 2.95;
			4'b1001: return 3.00;
			4'b1010: return 3.05;
			4'b1011: return 3.10;
			4'b1100: return 3.15;
			4'b1101: return 3.20;
			4'b1110: return 3.25;
			4'b1111: return 3.30;
			default: return 2.55;
		endcase
	endfunction
					

	task run_phase(uvm_phase phase);
		ldo1_seq_item tx;
		real expected;
		real pad,prev_pad;
		int stable_cycles,max_cycles;
		bit wait_for_ramp;

		forever begin
			@(posedge vif.clk);
			if( real_changd(vif.EN_LDO1,prev_EN) ||
				real_changd(vif.DISCHG_LDO1,prev_DISCHG) ||
				real_changd(vif.RESET_LDO1,prev_RESET) ||
				real_changd(vif.VDD_LDO1,prev_VDD) ||
				real_changd(vif.DVS_ON_LDO1,prev_DVS) ||
				(vif.VSEL_LDO1 !== prev_VSEL))begin
					
				if((vif.EN_LDO1 >= `VDD_IO_LDO1_min && vif.EN_LDO1 <= `VDD_IO_LDO1_max) && (vif.VDD_IO_LDO1 >= `VDD_IO_LDO1_min && vif.VDD_IO_LDO1 <= `VDD_IO_LDO1_max) && (`VDD_min <= vif.VDD_LDO1&& vif.VDD_LDO1<= `VDD_max) && !(vif.RESET_LDO1>= `VDD_IO_LDO1_min && vif.RESET_LDO1<= `VDD_IO_LDO1_max) && !(vif.DISCHG_LDO1>= `VDD_IO_LDO1_min && vif.DISCHG_LDO1<= `VDD_IO_LDO1_max))begin
					expected = get_expt_pad(vif.VSEL_LDO1);//expected pad val
					pad = vif.PAD_LDO1;//current pad val

					wait_for_ramp = (fabs(pad - expected) > 0.05);//if cur and expected pad are diff it will be 1
					`uvm_info("LDO1_MON",$sformatf("Sampled VSEL = %0b, PAD=%0.3f, EN=%0.3f, DISCHG=%0.3f, RESET=%0.3f, VDD=%0.3f, DVS=%0.3f",vif.VSEL_LDO1,vif.PAD_LDO1,vif.EN_LDO1,vif.DISCHG_LDO1,vif.RESET_LDO1,vif.VDD_LDO1,vif.DVS_ON_LDO1),UVM_MEDIUM)

					//monitor pad settling
				    stable_cycles = 0;
					max_cycles = 16000000;//giving sufficient delay so that ramp happens properly
					prev_pad = pad;

					//logic to wait until ramp is done
					if(wait_for_ramp)begin
						for(int i=0; i < max_cycles; i++)begin
							@(posedge vif.clk);
							pad = vif.PAD_LDO1;

							if(fabs(pad - prev_pad) < 0.005)
								stable_cycles++;
							else
								stable_cycles = 0;

							if((fabs(pad - expected) < 0.05) && stable_cycles >= 10)
								break;

							prev_pad = pad;
						end
					end
					else begin
						pad = vif.PAD_LDO1;//no wait no ramp
					end

					tx = ldo1_seq_item::type_id::create("tx");
					
					tx.EN_LDO1 = vif.EN_LDO1;
					tx.DVS_ON_LDO1 = vif.DVS_ON_LDO1;
					tx.DISCHG_LDO1 = vif.DISCHG_LDO1;
					tx.VREF_OP85V_LDO1 = vif.VREF_OP85V_LDO1;
					tx.RESET_LDO1 = vif.RESET_LDO1;
					tx.VDD_IO_LDO1 = vif.VDD_IO_LDO1;
					tx.VDD_LDO1 = vif.VDD_LDO1;
					tx.GND_LDO1 = vif.GND_LDO1;
					tx.PBKG = vif.PBKG;
					tx.VSEL_LDO1 = vif.VSEL_LDO1;
					tx.PAD_LDO1 = pad;
					tx.PWROK_LDO1 = vif.PWROK_LDO1;
						
					`uvm_info("LDO1_MON",$sformatf("Sampled VSEL = %0b, PAD=%0.3f, EN=%0.3f",tx.VSEL_LDO1,tx.PAD_LDO1,tx.EN_LDO1),UVM_MEDIUM)

					mon_ap.write(tx);//writing to scb

					//save prev values
					prev_EN = vif.EN_LDO1;
					prev_DISCHG = vif.DISCHG_LDO1;
					prev_RESET = vif.RESET_LDO1;
					prev_VDD = vif.VDD_LDO1;
					prev_DVS = vif.DVS_ON_LDO1;
					prev_VSEL = vif.VSEL_LDO1;
			end
			else begin
				tx = ldo1_seq_item::type_id::create("tx");
					
					tx.EN_LDO1 = vif.EN_LDO1;
					tx.DVS_ON_LDO1 = vif.DVS_ON_LDO1;
					tx.DISCHG_LDO1 = vif.DISCHG_LDO1;
					tx.VREF_OP85V_LDO1 = vif.VREF_OP85V_LDO1;
					tx.RESET_LDO1 = vif.RESET_LDO1;
					tx.VDD_IO_LDO1 = vif.VDD_IO_LDO1;
					tx.VDD_LDO1 = vif.VDD_LDO1;
					tx.GND_LDO1 = vif.GND_LDO1;
					tx.PBKG = vif.PBKG;
					tx.VSEL_LDO1 = vif.VSEL_LDO1;
					tx.PAD_LDO1 = vif.PAD_LDO1;
					tx.PWROK_LDO1 = vif.PWROK_LDO1;
						
					`uvm_info("LDO1_MON",$sformatf("Sampled VSEL = %0b, PAD=%0.3f, EN=%0.3f",tx.VSEL_LDO1,tx.PAD_LDO1,tx.EN_LDO1),UVM_MEDIUM)

					mon_ap.write(tx);//writing to scb
					//save prev values
					prev_EN = vif.EN_LDO1;
					prev_DISCHG = vif.DISCHG_LDO1;
					prev_RESET = vif.RESET_LDO1;
					prev_VDD = vif.VDD_LDO1;
					prev_DVS = vif.DVS_ON_LDO1;
					prev_VSEL = vif.VSEL_LDO1;
			end
		end
	 end
	endtask

endclass
