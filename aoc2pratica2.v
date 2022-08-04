/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/12/2021
	Alunos: Fernando Veizaga e Alanis Castro
*/

module aoc2pratica2 (clock, run, reset);

	input clock, run, reset;
	
	wire [15:0] DIN, BusWires, address, dataout, memout, write;
	wire [5:0] pc;
	wire Done;
	wire [1:0] Tstep;
	wire [9:0] IR;
	wire [15:0] r0, r1, r2, r3, r4, r5;
	
	romlpm rom (pc, clock, DIN);
	ramlpm ram (address[6:0], clock, dataout, write[0], memout);
	proc processador (DIN, memout, reset, clock, run, Done, BusWires, write, pc, address, dataout, IR, Tstep, r0, r1, r2, r3, r4, r5);
	
endmodule
