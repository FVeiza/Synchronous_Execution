/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/12/2021
	Alunos: Fernando Veizaga e Alanis Castro
*/

module ula(A, bus, G, controle);

	input[2:0] controle;
	input [15:0] A, bus;
	output reg [15:0] G;
	
	always@(*)
	begin
	
		case(controle) 
			3'b000: begin	G <= A + bus; end		//add					
			3'b001: begin	G <= A - bus; end		//sub					
			3'b010: begin	G <= A & bus; end		//and		
			3'b011: begin								//slt			
							if(A < bus)
							begin
								G <= 16'b1;
							end
							
							else
							begin
								G <= 16'b0;
							end
					   end
			3'b100: begin G <= A << bus; end		//sll					
			3'b101: begin G <= A >> bus; end		//srl		
		endcase
		
	end
	
endmodule
