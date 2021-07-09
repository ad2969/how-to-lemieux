`define START 4'b0000

`define PDRAW1 4'b0001
`define PDRAW2 4'b0010
`define PDRAW3 4'b0011

`define DDRAW1 4'b0100
`define DDRAW2 4'b0101
`define DDRAW3 4'b0110

`define DECIDE 4'b1000
`define COMPUTE 4'b1001
`define WAIT 4'b1111

module statemachine(input slow_clock, input resetb,
                    input [3:0] dscore, input [3:0] pscore, input [3:0] pcard3,
                    output load_pcard1, output load_pcard2,output load_pcard3,
                    output load_dcard1, output load_dcard2, output load_dcard3,
                    output player_win_light, output dealer_win_light);

// The code describing your state machine will go here.  Remember that
// a state machine consists of next state logic, output logic, and the 
// registers that hold the state.  You will want to review your notes from
// CPEN 211 or equivalent if you have forgotten how to write a state machine.

  // Wire declarations
  reg load_p1, load_p2, load_p3;
  reg load_d1, load_d2, load_d3;
  reg p_win, d_win;

  reg [3:0] state, next_state;

  // Connecting outputs to reg wires
  assign load_pcard1 = load_p1;
  assign load_pcard2 = load_p2;
  assign load_pcard3 = load_p3;
  assign load_dcard1 = load_d1;
  assign load_dcard2 = load_d2;
  assign load_dcard3 = load_d3;
  assign player_win_light = p_win;
  assign dealer_win_light = d_win;

  // Finite state machine always block (sequential)
  always @(posedge slow_clock, negedge resetb) begin
	if(!resetb) begin
	  next_state = `PDRAW1;
	  load_p1 = 1'b0;
	  load_p2 = 1'b0;
	  load_p3 = 1'b0;
	  load_d1 = 1'b0;
	  load_d2 = 1'b0;
	  load_d3 = 1'b0;
	  p_win = 1'b0;
	  d_win = 1'b0;
	end
	else begin
	case(state)

	  `START: begin
		next_state = `PDRAW1;
	  end
	  `PDRAW1: begin
		next_state = `DDRAW1;
		load_p1 = 1'b1;
	  end
	  `DDRAW1: begin
		next_state = `PDRAW2;
		load_p1 = 1'b0;
		load_d1 = 1'b1;
	  end
	  `PDRAW2: begin
		next_state = `DDRAW2;
		load_d1 = 1'b0;
		load_p2 = 1'b1;
	  end
	  `DDRAW2: begin
		next_state = `DECIDE;
		load_p2 = 1'b0;
		load_d2 = 1'b1;
	  end
	  `DECIDE: begin
		load_d2 = 1'b0;
		if((dscore == 4'b1000) || (dscore == 4'b1001)) next_state = `COMPUTE;
		else begin
		casex(pscore)
		  4'b100x: next_state = `COMPUTE;
		  4'b011x: begin
			if(dscore < 4'b0101) begin
			  next_state = `DDRAW3;
			  load_d3 = 1'b1;
			end
			else next_state = `COMPUTE;
		  end
		  default: begin
			next_state = `PDRAW3;
			load_p3 = 1'b1;
		  end
		endcase
		end
	  end
	  `PDRAW3: begin
		load_p3 = 1'b0;
		casex({dscore, pcard3})
		  8'b0111xxxx: next_state = `COMPUTE;
		  8'b0110011x: begin
			next_state = `DDRAW3;
			load_d3 = 1'b1;
		  end
		  8'b010101xx: begin
			next_state = `DDRAW3;
			load_d3 = 1'b1;
		  end
		  8'b010001xx: begin
			next_state = `DDRAW3;
			load_d3 = 1'b1;
		  end
		  8'b0100001x: begin
			next_state = `DDRAW3;
			load_d3 = 1'b1;
		  end
		  8'b00110xxx: begin
			next_state = `DDRAW3;
			load_d3 = 1'b1;
		  end
		  8'b0010xxxx: begin
			next_state = `DDRAW3;
			load_d3 = 1'b1;
		  end
		  8'b000xxxxx: begin
			next_state = `DDRAW3;
			load_d3 = 1'b1;
		  end
		  default: next_state = `COMPUTE;
		endcase
	  end
	  `DDRAW3: begin
		load_d3 = 1'b0;
		next_state = `COMPUTE;
	  end
	  `COMPUTE: begin
		load_p3 = 1'b0;
		load_d3 = 1'b0;
		if(pscore == dscore) begin
		  p_win = 1'b1;
		  d_win = 1'b1;
		end
		else if(pscore > dscore) p_win = 1'b1;
		else if(dscore > pscore) d_win = 1'b1;
		else begin
		  p_win = 1'b0;
		  d_win = 1'b0;
		end
		next_state = `WAIT;
	  end
	  `WAIT: begin
		next_state = `WAIT;
	  end
	  default: begin
		next_state = `WAIT;
	  end

	endcase
	end
	
	state <= next_state;
  end

endmodule

