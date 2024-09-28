module cla4 (
	c0,
	a,
	b,
	c4,
	sout,
	pg,
	gg
);
	input wire c0;
	input wire [3:0] a;
	input wire [3:0] b;
	output wire c4;
	output wire [3:0] sout;
	output wire pg;
	output wire gg;
	wire c_wires [3:0];
	wire prop_wires [3:0];
	wire gen_wires [3:0];
	assign c_wires[0] = c0;
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < 4; _gv_i_1 = _gv_i_1 + 1) begin : genblk1
			localparam i = _gv_i_1;
			full_adder_cp fa(
				.a(a[i]),
				.b(b[i]),
				.cin(c_wires[i]),
				.prop(prop_wires[i]),
				.gen(gen_wires[i]),
				.sout(sout[i])
			);
			if (i != 0) begin : genblk1
				assign c_wires[i] = gen_wires[i - 1] | (prop_wires[i - 1] & c_wires[i - 1]);
			end
		end
	endgenerate
	assign pg = ((prop_wires[3] & prop_wires[2]) & prop_wires[1]) & prop_wires[0];
	assign gg = ((gen_wires[3] | (gen_wires[2] & prop_wires[3])) | ((gen_wires[1] & prop_wires[3]) & prop_wires[2])) | (((gen_wires[0] & prop_wires[3]) & prop_wires[2]) & prop_wires[1]);
	assign c4 = gen_wires[3] | (prop_wires[3] & c_wires[3]);
endmodule
