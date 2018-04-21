		.ORIG	x3000
		AND 	R1,R1,#0
		AND		R2,R2,R2
		BRp		po
		BR		sec
po		AND		R3,R3,R3
		BRnz	outp1
sec		AND		R2,R2,R2
		BRn		na
		BR		tri
na		AND		R3,R3,R3
		BRzp	outp2
tri		NOT		R4,R3
		ADD		R4,R4,#1
		ADD		R5,R2,R4
		BRn		outp2
		BRp		outp1
outp1	ADD		R1,R1,R2
		BR		stop
outp2	ADD		R1,R1,R3
		BR		stop		
stop	TRAP	x25	
		.END
		