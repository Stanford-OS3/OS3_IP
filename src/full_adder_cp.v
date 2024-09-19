module full_adder_cp (
	a,
	b,
	cin,
	prop,
	gen,
	sout
);
	input wire a;
	input wire b;
	input wire cin;
	output wire prop;
	output wire gen;
	output wire sout;
	assign sout = (a ^ b) ^ cin;
	assign prop = a | b;
	assign gen = a & b;
endmodule
