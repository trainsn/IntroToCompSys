		.ORIG	x3000
		LD		R0,number
		LD		R1,time
loop	TRAP	x21
		ADD		R1,R1,#-1
		BRp		loop
		TRAP	x25
number	.FILL	x5A
time	.FILL	#100		
		.END