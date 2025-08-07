`define VDD_IO_LDO1_min 1.65
`define VDD_IO_LDO1_max 3.3
`define VDD_min 2.9
`define VDD_max 3.65
class ldo1_scb extends uvm_component;
	
	uvm_analysis_imp #(ldo1_seq_item, ldo1_scb) scb_ap;

	`uvm_component_utils(ldo1_scb)
	
	int prev_vsel = -1;

	function new(string name, uvm_component parent);
		super.new(name,parent);
	    scb_ap = new("scb_ap",this);
	endfunction
	
	function real get_pad(input logic [3:0] vsel);
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

	function real fabs(real val);
		return (val<0) ? -val : val;
	endfunction

	function void write(ldo1_seq_item tx);
		
		real expected = get_pad(tx.VSEL_LDO1);
		int curr_vsel;
		curr_vsel = tx.VSEL_LDO1;

		if(tx.RESET_LDO1>= `VDD_IO_LDO1_min && tx.RESET_LDO1<= `VDD_IO_LDO1_max)begin
			if(tx.PAD_LDO1 == 0 && tx.PWROK_LDO1 == 0)
				`uvm_info("LDO1_SCB",$sformatf("-----------TEST PASSED LDO1 IS RESETTED---------"),UVM_MEDIUM)
			else
				`uvm_error("LDO1_SCB",$sformatf("RESET TEST FAILED Expected PAD and PWROK is 0 ,Got PAD=%0.3f | PWROK=%0.3f ", tx.PAD_LDO1,tx.PWROK_LDO1))
		end

		else if(tx.DISCHG_LDO1>= `VDD_IO_LDO1_min && tx.DISCHG_LDO1<= `VDD_IO_LDO1_max)begin
			if(tx.PAD_LDO1 == 0 && tx.PWROK_LDO1 == 0)
				`uvm_info("LDO1_SCB",$sformatf("-----------TEST PASSED LDO1 IS DISCHARGED---------"),UVM_MEDIUM)
			else
				`uvm_error("LDO1_SCB",$sformatf("DISCHARGE TEST FAILED Expected PAD and PWROK is 0 ,Got PAD=%0.3f | PWROK=%0.3f ", tx.PAD_LDO1,tx.PWROK_LDO1))
		end
		
		else if(!(tx.VDD_IO_LDO1 >= `VDD_IO_LDO1_min && tx.VDD_IO_LDO1 <= `VDD_IO_LDO1_max) || !(`VDD_min <= tx.VDD_LDO1&& tx.VDD_LDO1<= `VDD_max))begin
				if(tx.PAD_LDO1 == 0 && tx.PWROK_LDO1 == 0)
				`uvm_info("LDO1_SCB",$sformatf("-----------TEST PASSED VDD IS OUT OF RANGE---------"),UVM_MEDIUM)
			else
				`uvm_error("LDO1_SCB",$sformatf("VDD OUT OF RANGE TEST FAILED Expected PAD and PWROK is 0 ,Got PAD=%0.3f | PWROK=%0.3f ", tx.PAD_LDO1,tx.PWROK_LDO1))
		end

		else if((tx.EN_LDO1 >= `VDD_IO_LDO1_min && tx.EN_LDO1 <= `VDD_IO_LDO1_max))begin
			if(prev_vsel >= 0 && fabs(curr_vsel - prev_vsel) > 1)begin 
				if(fabs(tx.PAD_LDO1 - expected)> 0.2)begin
					`uvm_warning("LDO1_SCB",$sformatf("Waiting ramp expected: Got %0.3f, Expected %0.3f for VSEL %b", tx.PAD_LDO1,expected,tx.VSEL_LDO1))
				end
				else `uvm_info("LDO1_SCB",$sformatf("TEST PASSED after ramp VSEL=%0b | PAD=%0.3f | Expected=%0.3f | PWROK =%0.3f", tx.VSEL_LDO1, tx.PAD_LDO1,expected,tx.PWROK_LDO1),UVM_MEDIUM)
			end
			else begin
				if(fabs(tx.PAD_LDO1 - expected)> 0.2)begin
					`uvm_error("LDO1_SCB",$sformatf("PAD mismatch: Got %0.3f, Expected %0.3f for VSEL %b", tx.PAD_LDO1,expected,tx.VSEL_LDO1))
				end
				else `uvm_info("LDO1_SCB",$sformatf("TEST PASSED VSEL=%0b | PAD=%0.3f | Expected=%0.3f | PWROK =%0.3f", tx.VSEL_LDO1, tx.PAD_LDO1,expected,tx.PWROK_LDO1),UVM_MEDIUM)
			end
			prev_vsel = curr_vsel;
		end

		else begin
			//$display("SCB check EN disabled PAD=%0.3f, PWROK=%0.3f, EN=%0.3f",tx.PAD_LDO1,tx.PWROK_LDO1,tx.EN_LDO1);
			if(fabs(tx.PAD_LDO1)<0.01 && fabs(tx.PWROK_LDO1)<0.01)
				`uvm_info("LDO1_SCB",$sformatf("-----------TEST PASSED LDO1 EN IS DISABLED---------"),UVM_MEDIUM)
			else
				`uvm_error("LDO1_SCB",$sformatf("ENABLE TEST FAILED Expected PAD and PWROK is 0 ,Got PAD=%0.3f | PWROK=%0.3f | EN =%0.3f", tx.PAD_LDO1,tx.PWROK_LDO1,tx.EN_LDO1))
		end
	endfunction
endclass
