/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/12/2021
	Alunos: Fernando Veizaga e Alanis Castro
*/

module r7counter(data, PCen, wren, Clock, PC, reset);
	input [5:0] data;
	input PCen, Clock, wren, reset;
	output reg [5:0] PC;
	
	initial begin
		PC <= 6'b0;
	end
	
	always @(posedge Clock)
		if(reset == 1'b1)
		begin
			PC <= 6'b0;
		end
		
		else if (wren == 1'b1)
		begin
			PC <= data;
		end
		
		else if(PCen == 1'b1)
		begin
			PC <= PC + 6'b000001;
		end
endmodule
