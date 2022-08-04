/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/12/2021
	Alunos: Fernando Veizaga e Alanis Castro
*/

module regn(R, Rin, Clock, Q);
	parameter n = 16;
	input [n-1:0] R;
	input Rin, Clock;
	output [n-1:0] Q;
	reg [n-1:0] Q;
	
	initial begin
		Q <= 16'b0;
	end
	
	always @(posedge Clock)
		if (Rin)
		Q <= R;
endmodule
