		.ORIG	x2000
START	ST 		R1,SaveR1
		ST 		R3,SaveR3;The address of *
		ST 		R4,SaveR4;The address of #
		ADD		R5,R5,#1
INPUT	LDI		R1,KBSR
		BRzp	INPUT
		LDI		R3,KBDR
		
		AND 	R4,R4,#0
		ADD		R4,R4,#10;R4<-counter
OUTPUT	LDI		R1,DSR
		BRzp	OUTPUT
		STI		R3,DDR
		ADD		R4,R4,#-1
		BRp		OUTPUT
		LD		R3,NEWLINE
		STI		R3,DDR
;change pattern		
		AND 	R2,R2,R2
		BRz		GOWELL
		BRn		GOSTAR
NO		NOT		R2,R2
		BR		STOP
		
GOSTAR	LD		R0,SaveR3
		BR		NO
GOWELL	LD		R0,SaveR4		
		BR		NO
		
STOP	LD		R1,SaveR1
		LD		R3,SaveR3
		LD		R4,SaveR4
		RTI

KBSR	.FILL	xFE00
KBDR	.FILL	xFE02
DSR		.FILL	xFE04
DDR		.FILL	xFE06
NEWLINE	.FILL	x0A
SaveR1	.BLKW	1	
SaveR3	.BLKW	1
SaveR4	.BLKW	1		
		.END