module main (out, input_a, input_b, input_c, input_d, clk, rst);

input clk, rst;
input [1:0] input_a, input_b, input_c, input_d;
output reg [7:0] out;

wire [17:0] instruction;
wire [11:0] address;
wire [7:0] port_id;
wire [7:0] out_port;
wire write_strobe;
wire [7:0] in_port;
wire bram_enable ;

kcpsm6 picoblaze (
			.address(address),
			.instruction (instruction),
			.port_id(port_id),
			.write_strobe(write_strobe),
			.out_port(out_port),
			.read_strobe(),
			.in_port(in_port),
			.interrupt(),
			.intrrupt_ack(),
			.reset(rst),
			.clk(clk),
			.bram_enable(bram_enable)
						);



mul multiplier (
			.address(address),
			.instruction(instruction),
			.rdl(1'b0),
			.enable(bram_enable)			
						);

always @ (posedge clk or posedge rst)
	begin
		if (rst==1)
			out<=0;

		if (write_strobe && port_id==5)
			out<=out_port;
	end
		


endmodule
			
