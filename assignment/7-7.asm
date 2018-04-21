		.ORIG	x3000
		AND		R1,R1,#0
		LD		R2,number
loop1	AND		R3,R0,R2
		BRz		a
		ADD 	R1,R1,#1
a		ADD		R0,R0,R0
		BRz		stop
		BR		loop1
stop	TRAP 	x25
number	.FILL	x8000
		.END