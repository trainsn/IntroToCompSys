		.ORIG	x3000
		LDI		R2,cur;counter
		AND		R1,R1,#0
		ADD		R1,R1,1
loop	ADD		R1,R1,R1
		ADD		R2,R2,#-1
		BRz		work
		BR		loop
work	LDI		R3,a
		NOT		R3,R3
		NOT		R1,R1
		AND		R1,R1,R3
		NOT		R1,R1
		STI		R1,a
		TRAP	x25		
cur		.FILL	x4000
a		.FILL 	x4001
		.END