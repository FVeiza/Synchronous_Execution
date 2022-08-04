/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/12/2021
	Alunos: Fernando Veizaga e Alanis Castro
*/

module regir(R, Rin, Clock, Q, reset);
	parameter n = 10;
	input [n-1:0] R;
	input Rin, Clock, reset;
	output [n-1:0] Q;
	reg [n-1:0] Q;
	
	initial begin
		Q <= 10'b0;
	end
	
	always @(posedge Clock)
		if(reset == 1'b1)
		begin
			Q <= 10'b0;
		end
		
		else if (Rin)
		begin
			Q <= R;
		end
endmodule