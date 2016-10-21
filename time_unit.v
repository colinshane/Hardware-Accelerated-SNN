module time_unit(
	input		clk,rst,
	
	input		valid_board,
	input		valid_ips,
	input		valid_pp	,
	input		valid_ops,
	input		valid_li,
	input		valid_wp,
	
	output	start_ips,
	output	start_pp,
	output	start_ops,
	output	start_li,
	output	start_wp,
	output[15:0]	TU,
	output	TU_incre
    );
	 
//input output declaration
wire		clk,rst;

wire		valid_board;
wire		valid_ips;
wire		valid_pp;
wire		valid_ops;
wire		valid_li;
wire		valid_wp;

reg		start_ips;
reg		start_pp;
reg		start_ops;
reg		start_li;
reg		start_wp;

reg[15:0]		TU;
reg				TU_incre;


localparam	[2:0]	idle = 3'b000,
						ips = 3'b001,
						pp   = 3'b010,
						ops = 3'b011,
						li   = 3'b100,
						wp   = 3'b101,
						s6   = 3'b110,
						s7   = 3'b111;
						
reg		state_reg,next_reg;


always @(posedge clk,posedge rst)
begin
	if (rst) begin
		state_reg <= idle;
		TU			 <= 16'b0000000000000000;
	end else begin
		state_reg <= next_reg;
		if (valid_wp) begin
			TU <= TU + 1;
		end
	end
end

always@*
begin
	start_ips 	<= 1'b0;
	start_pp  	<= 1'b0;
	start_ops	<= 1'b0;
	start_li		<= 1'b0;
	start_wp		<= 1'b0;
	TU_incre		<= 1'b0;

	case (state_reg)
		idle: begin
					if (valid_board) begin
						next_reg <= ips;
						start_ips <= 1'b1;
					end else begin
						next_reg <= idle;
					end
				end
		ips: begin
					if (valid_ips) begin
						next_reg <= pp;
						start_pp <= 1'b1;
					end else begin
						next_reg <= ips;
					end
				end
		pp:  begin
					if (valid_pp) begin
						next_reg <= ops;
						start_ops <= 1'b1;
					end else begin
						next_reg <= pp;
					end
				end
		ops: begin
					if (valid_ops) begin
						next_reg <= li;
						start_li   <= 1'b1;
					end else begin
						next_reg <= ops;
					end
				end
		li:	begin
					if (valid_li) begin
						next_reg <= wp;
						start_wp <= 1'b1;
					end else begin
						next_reg <= li;
					end
				end
		wp:	begin
					if (valid_wp) begin
						next_reg <= idle;
						TU_incre   <= 1'b1;
					end else begin
						next_reg <= wp;
					end
				end
		default: begin
				next_reg <= idle;
				end
		endcase
end


endmodule
