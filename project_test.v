module test();

	wire [7:0] out;
	reg [1:0] a, b, c, d;
	reg clk, rst;

	main m (out, a, b, c, d, clk, rst);

	always
	#200 clk=~clk;


	initial begin
	clk=0;
	rst=0;
	#500 a=0;b=0;c=0;d=0;

	end

endmodule
