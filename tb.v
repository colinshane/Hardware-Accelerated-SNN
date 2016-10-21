`timescale 1ns / 1ps

module tb;

	// Inputs to Top_Module
	reg clk;
	reg rst;
	reg valid_board;
	reg [255:0]ips;

	// Outputs from Top Module
	wire [2:0]ops;
	wire TU_incre;
	wire done;

	// Instantiate the Unit Under Test (UUT)
	top_module uut (
		.clk(clk), 
		.rst(rst), 
		.valid_board(valid_board), 
		.ips(ips), 
		.ops(ops), 
		.TU_incre(TU_incre),
		.done(done)
	);

	always begin
		#10 clk=~clk;
	end
	
	//file reading
	integer 		f1,file;
	reg[255:0]	str;
	reg			ini_send;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		valid_board = 0;
		ips = 0;
		ini_send = 1;
		str = 0;
		f1 = 0; file = 0;
		file = $fopen("C:/Users/Arpan Vyas/Desktop/My/FPGA/Spiking_Neural_Network/input_spikes.txt","r");
		#10;
		rst = 0;
	end
	
	always@(posedge clk, posedge rst)
	begin
		if (rst) begin
			valid_board<=1'b0;
			ips<=0;
		end else if (TU_incre||ini_send) begin
			f1 	=	$fscanf(file,"%b\n", str[255:0]);
			ips	=	str;
			valid_board <= 1'b1;
			ini_send <= 0;
		end else if (done) begin
			$fclose(file);
		end else begin
			valid_board <= 1'b0;
		end
	end
	
      
endmodule

