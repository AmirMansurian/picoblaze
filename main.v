`timescale 1ps/1ps

module main (out, input_a, input_b, input_c, input_d, clk);

input clk;
input [1:0] input_a, input_b, input_c, input_d;
output reg [7:0] out;

wire [17:0] instruction;
wire [11:0] address;
wire [7:0] port_id;
wire [7:0] out_port;
wire write_strobe;
reg [7:0] in_port;
wire rst;
wire bram_enable;



kcpsm6 picoblaze (
			.address(address),
			.instruction (instruction),
			.port_id(port_id),
			.write_strobe(write_strobe),
			.bram_enable(),
			.out_port(out_port),
			.read_strobe(),
			.in_port(in_port),
			.interrupt(0),
			.interrupt_ack(),
			.reset(rst),
			.clk(clk)
						);



mul multiplier (
			.address(address),
			.instruction(instruction),
			.clk(clk),
			.enable(1), 
			.rdl(rst)
						);
	
always @(posedge clk) begin
	if(port_id == 1)
		in_port = input_a;
	else if(port_id == 2)
		in_port = input_b;
	else if(port_id == 5)
		out = out_port;
end	
//assign in_port= (port_id==1) ? input_a :
//					 (port_id==2) ? input_b :
////					 (port_id==3) ? input_c : input_d;
//
//always @ (posedge clk)
//	begin
////		if (rst==1)
////			out<=0;
//
//		if (write_strobe==1)
//			if (port_id==5)
//				out<=out_port;
//	end
//		
//
//
endmodule
			
