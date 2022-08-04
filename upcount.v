/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/12/2021
	Alunos: Fernando Veizaga e Alanis Castro
*/

module upcount(Clear, Clock, Q);
	integer control;
	input Clear, Clock;
	output [1:0] Q;
	reg [1:0] Q;
	
	initial begin
		Q <= 2'b0;
		control = 1;
	end
	
	always @(posedge Clock)
		if (Clear)
		begin
			Q <= 2'b0;
		end
		
		else if(control == 1)
		begin
			Q <= Q + 1'b1;
		end
endmodule
