module lcu16 (
	c0,
	a,
	b,
	c16,
	sout,
	pg,
	gg
);
	input wire c0;
	input wire [15:0] a;
	input wire [15:0] b;
	output wire c16;
	output wire [15:0] sout;
	output wire pg;
	output wire gg;
	wire c_wires [3:0];
	wire c_out [3:0];
	wire prop_wires [3:0];
	wire gen_wires [3:0];
	assign c_wires[0] = c0;
	genvar _gv_i_2;
	generate
		for (_gv_i_2 = 0; _gv_i_2 < 4; _gv_i_2 = _gv_i_2 + 1) begin : genblk1
			localparam i = _gv_i_2;
			cla4 cla(
				.c0(c_wires[i]),
				.a(a[(i * 4) + 3:i * 4]),
				.b(b[(i * 4) + 3:i * 4]),
				.c4(c_out[i]),
				.sout(sout[(i * 4) + 3:i * 4]),
				.pg(prop_wires[i]),
				.gg(gen_wires[i])
			);
			if (i != 0) begin : genblk1
				assign c_wires[i] = gen_wires[i - 1] | (prop_wires[i - 1] & c_out[i - 1]);
			end
		end
	endgenerate
	assign pg = ((prop_wires[3] & prop_wires[2]) & prop_wires[1]) & prop_wires[0];
	assign gg = ((gen_wires[3] | (gen_wires[2] & prop_wires[3])) | ((gen_wires[1] & prop_wires[3]) & prop_wires[2])) | (((gen_wires[0] & prop_wires[3]) & prop_wires[2]) & prop_wires[1]);
	assign c16 = gen_wires[3] | (prop_wires[3] & c_wires[3]);
endmodule
