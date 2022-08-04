/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/12/2021
	Alunos: Fernando Veizaga e Alanis Castro
*/

module proc (DIN, memin, Resetn, Clock, Run, Done, BusWires, WriteEn, pc, addtomem, datatomem, debugIR, debugTstep, r0, r1, r2, r3, r4, r5);
	input [15:0] DIN, memin;
	input Resetn, Clock, Run;
	output reg Done;
	output [15:0] BusWires, addtomem, datatomem;
	output [5:0] pc;
	output [15:0] WriteEn;
	output reg [1:0] debugTstep;
	output reg [9:0] debugIR;
	output reg [15:0] r0, r1, r2, r3, r4, r5;
	
	
	reg dinout, pcen, memout, Ain, Gin, Gout, IRin, addrin, dataoutin;
	reg [2:0] ulaop;
	reg [7:0] regsout, regsin, regaux;
	reg [15:0] writein;
	
	wire [7:0] Xreg, Yreg, Rin, Rout;
	wire [15:0] R0, R1, R2, R3, R4, R5, R6, A, G;
	wire [15:0] ulares;
	wire [3:0] I;
	wire [9:0] IR;
	wire [1:0] Tstep_Q; 
	wire Clear = Resetn | Done;
	
	upcount Tstep (Clear, Clock, Tstep_Q);
	
	assign I = IR[9:6];
	
	dec3to8 decX (IR[5:3], 1'b1, Xreg);
	dec3to8 decY (IR[2:0], 1'b1, Yreg);
	
	always @(Tstep_Q or I or Xreg or Yreg)
	begin
		
		debugIR = IR;
		debugTstep = Tstep_Q;
		r0 = R0;
		r1 = R1;
		r2 = R2;
		r3 = R3;
		r4 = R4;
		r5 = R5;
		dinout = 1'b0;
		pcen = 1'b0;
		memout = 1'b0;
		Ain = 1'b0;
		Gin = 1'b0;
		Gout = 1'b0;
		IRin = 1'b0;
		addrin = 1'b0;
		dataoutin = 1'b0;
		writein = 1'b0;
		ulaop[2:0] = 3'b000;
		regsout[7:0] = 8'b0;
		regsin[7:0] = 8'b0;
		Done = 1'b0;
	
		if(Run == 1'b1)
		begin
		
			case (Tstep_Q)
				2'b00: // store DIN in IR in time step 0
				begin
					IRin = 1'b1;
					pcen = 1'b1;//
				end
				
				2'b01: //define signals in time step 1
				begin
					case (I)
						4'b0000:					//mv
						begin
							regsout = Yreg;
							regsin = Xreg;
							Done = 1'b1;
						end
						
						4'b0001:					//mvi
						begin
							pcen = 1'b1;//
						end
						
						4'b0010:					//mvnz
						begin
							if(G != 15'b0)
							begin
								regsin = Xreg;
								regsout = Yreg;
							end
							Done = 1'b1;
						end
						
						4'b0011:					//st
						begin
							regsout = Xreg;
							dataoutin = 1'b1;
						end
						
						4'b0100:					//ld
						begin
							regsout = Yreg;
							addrin = 1'b1;
						end
						
						4'b0101:					//add
						begin
							regsout = Xreg;
							Ain = 1'b1;
						end
						
						4'b0110:					//sub
						begin
							regsout = Xreg;
							Ain = 1'b1;
						end
						
						4'b0111:					//and
						begin
							regsout = Xreg;
							Ain = 1'b1;
						end
						
						4'b1000:					//slt
						begin
							regsout = Xreg;
							Ain = 1'b1;
						end
						
						4'b1001:					//sll
						begin
							regsout = Xreg;
							Ain = 1'b1;
						end
						
						4'b1010:					//srl
						begin
							regsout = Xreg;
							Ain = 1'b1;
						end
						
					endcase
				end
				
				2'b10: //define signals in time step 2
				begin
					if(I >= 4'b0101)
					begin
						Gin = 1'b1;
						regsout = Yreg;
						case (I)
							4'b0101: ulaop = 3'b000;		//add
							4'b0110: ulaop = 3'b001;		//sub
							4'b0111: ulaop = 3'b010;		//and
							4'b1000: ulaop = 3'b011;		//slt
							4'b1001: ulaop = 3'b100;		//sll
							4'b1010: ulaop = 3'b101;		//srl
						endcase
					end
					
					else begin
						if(I == 4'b0001)					//mvi
						begin
							regsin = Xreg;
							dinout = 1'b1;
							Done = 1'b1;
						end
						
						if(I == 4'b0011)					//st
						begin
							regsout = Yreg;
							writein = 16'b0000000000000001;
							addrin = 1'b1;
							Done = 1'b1;
						end
					end
				end
				
				2'b11: //define signals in time step 3
				begin
					if(I >= 4'b0101)
					begin
						regsin = Xreg;
						Gout = 1'b1;
						Done = 1'b1;
					end
					
					else if(I == 4'b0100)			//ld
					begin
						regsin = Xreg;
						memout = 1'b1;
						Done = 1'b1;
					end
				end
			endcase
			
		end
	end
	
	regn reg_0 (BusWires, regsin[0], Clock, R0);
	regn reg_1 (BusWires, regsin[1], Clock, R1);
	regn reg_2 (BusWires, regsin[2], Clock, R2);
	regn reg_3 (BusWires, regsin[3], Clock, R3);
	regn reg_4 (BusWires, regsin[4], Clock, R4);
	regn reg_5 (BusWires, regsin[5], Clock, R5);
	regn reg_6 (BusWires, regsin[6], Clock, R6);	
	r7counter reg_7 (BusWires[5:0], pcen, regsin[7], Clock, pc, Resetn);
	regn regA (BusWires, Ain, Clock, A);
	regn regG (ulares, Gin, Clock, G);
	regir rIR (DIN[15:6], IRin, Clock, IR, Resetn);
	
	ula ulamod (A, BusWires, ulares, ulaop);
	
	multiplexers muxmod (DIN, R0, R1, R2, R3, R4, R5, R6, pc, memin, {regsout, dinout, Gout, memout}, G, BusWires);
	
	regn addr (BusWires, addrin, Clock, addtomem);
	regn dout (BusWires, dataoutin, Clock, datatomem);
	regn writer (writein, 1'b1, Clock, WriteEn);
	
	
endmodule
