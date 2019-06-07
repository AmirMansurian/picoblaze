`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:51 06/01/2019 
// Design Name: 
// Module Name:    main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module main(out, input_a, input_b, input_c, input_d, clk);

input [1:0] input_a, input_b, input_c, input_d;
input clk;
output reg [7:0] out;

wire	[11:0]	address;
wire	[17:0]	instruction;
wire			bram_enable;
wire	[7:0]		port_id;
wire	[7:0]		out_port;
reg	[7:0]		in_port;
wire			write_strobe;
wire			k_write_strobe;
wire			read_strobe;
wire			interrupt;            //See note above
wire			interrupt_ack;
wire			kcpsm6_sleep;         //See note above
wire			rdl;


  kcpsm6 pico (
	.address 		(address),
	.instruction 	(instruction),
	.bram_enable 	(bram_enable),
	.port_id 		(port_id),
	.write_strobe 	(write_strobe),
	.k_write_strobe 	(k_write_strobe),
	.out_port 		(out_port),
	.read_strobe 	(read_strobe),
	.in_port 		(in_port),
	.interrupt 		(interrupt),
	.interrupt_ack 	(interrupt_ack),
	.reset 		(rdl),
	.sleep		(kcpsm6_sleep),
	.clk 			(clk)); 


  assign kcpsm6_sleep = 1'b0;
  assign interrupt = 1'b0;

  
  MUL_TEST m (    				//Name to match your PSM file
 	.rdl 			(rdl),
	.enable 		(bram_enable),
	.address 		(address),
	.instruction 	(instruction),
	.clk 			(clk));

	
 
  
  
 
 always @(posedge clk)
 begin
			if(port_id==1)
				in_port=input_a;
				
			else if (port_id==2)
				in_port = input_b;
			
			else if (port_id==3)
				in_port = input_c;
				
			else if (port_id==4)
				in_port = input_d;
			
			else if(port_id == 5 && write_strobe)
				 out = out_port; 
			
 end


endmodule
