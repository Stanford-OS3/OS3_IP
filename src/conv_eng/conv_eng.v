module conv_eng (
	nums_to_multiply,
	weights,
	clk,
	rstn_,
	en,
	result
);
	input wire [71:0] nums_to_multiply;
	input wire [71:0] weights;
	input wire clk;
	input wire rstn_;
	input wire en;
	output wire [15:0] result;
	reg [15:0] out_reg;
	wire [15:0] mul_result [8:0];
	wire [15:0] add_s0 [3:0];
	wire [15:0] add_s1 [1:0];
	wire [15:0] add_s2;
	wire [15:0] final_val;
	always @(posedge clk)
		if (~rstn_)
			out_reg <= 0;
		else if (en)
			out_reg <= final_val;
	genvar _gv_i_1;
	generate
		for (_gv_i_1 = 0; _gv_i_1 < 9; _gv_i_1 = _gv_i_1 + 1) begin : genblk1
			localparam i = _gv_i_1;
			assign mul_result[i] = nums_to_multiply[i * 8+:8] * weights[i * 8+:8];
		end
		for (_gv_i_1 = 0; _gv_i_1 < 4; _gv_i_1 = _gv_i_1 + 1) begin : genblk2
			localparam i = _gv_i_1;
			lcu16 cla_s0(
				.a(mul_result[2 * i]),
				.b(mul_result[(2 * i) + 1]),
				.sout(add_s0[i])
			);
		end
		for (_gv_i_1 = 0; _gv_i_1 < 2; _gv_i_1 = _gv_i_1 + 1) begin : genblk3
			localparam i = _gv_i_1;
			lcu16 cla_s1(
				.a(add_s0[2 * i]),
				.b(add_s0[(2 * i) + 1]),
				.sout(add_s1[i])
			);
		end
	endgenerate
	lcu16 cla_s2(
		.a(add_s1[0]),
		.b(add_s1[1]),
		.sout(add_s2)
	);
	lcu16 cla_s3(
		.a(add_s2),
		.b(mul_result[8]),
		.sout(final_val)
	);
	assign result = out_reg;
endmodule
