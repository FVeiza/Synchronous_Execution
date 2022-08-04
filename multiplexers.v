/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/12/2021
	Alunos: Fernando Veizaga e Alanis Castro
*/

module multiplexers(din, r0, r1, r2, r3, r4, r5, r6, r7, memdata, controle, g, out);

	input [15:0] din, r0, r1, r2, r3, r4, r5, r6, g, memdata;
	input [5:0] r7;
	input [10:0] controle;
	output reg [15:0] out;
	
	always@(*)
	begin
		case(controle)
				11'b10000000000: begin out = {5'b0, r7-6'b000001}; end		//10000000 0 0 0
				11'b01000000000: begin out = r6; end				//01000000 0 0 0
				11'b00100000000: begin out = r5;	end				//00100000 0 0 0
				11'b00010000000: begin out = r4;	end				//00010000 0 0 0
				11'b00001000000: begin out = r3;	end				//00001000 0 0 0
				11'b00000100000: begin out = r2;	end				//00000100 0 0 0
				11'b00000010000: begin out = r1;	end				//00000010 0 0 0
				11'b00000001000: begin out = r0;	end				//00000001 0 0 0
				11'b00000000100: begin out = din; end				//00000000 1 0 0 
				11'b00000000010: begin out = g; end					//00000000 0 1 0
				11'b00000000001: begin out = memdata; end			//00000000 0 0 1
			endcase
	end

endmodule
