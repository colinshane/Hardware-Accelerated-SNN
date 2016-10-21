module top_module(
		input				clk,rst,
		input				valid_board,
		input[255:0]	ips,
		output[2:0]		ops,
		output			TU_incre,
		output			done
     );

//Input Output Decleration
wire			clk,rst;
wire			valid_board;
wire[255:0] ips;
reg[2:0]		ops;
reg			done;


//Time Unit Declerations
reg		valid_ips;
reg		valid_pp;
reg		valid_ops;
reg		valid_li;
reg		valid_wp;

wire			start_ips;
wire			start_pp;
wire			start_ops;
wire			start_li;
wire			start_wp;
wire[15:0]	TU;
wire			TU_incre;

time_unit  tu(
	.clk(clk), 
	.rst(rst),
	.valid_board(valid_board),
	.valid_ips(valid_ips),
	.valid_pp(valid_pp),
	.valid_ops(valid_ops),
	.valid_li(valid_li),
	.valid_wp(valid_wp),	
	
	.start_ips(start_ips),
	.start_pp(start_pp),
	.start_li(start_li),
	.start_wp(start_wp),
	.TU(TU),
	.TU_incre(TU_incre)
);


endmodule

