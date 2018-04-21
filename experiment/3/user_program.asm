		.ORIG	x3000
		LD		R6,SSP;initialize the stack pointer
		
		LD		R4,CON
		STI		R4,ENTRY;set up the keyboard interrupt vector table entry
		
		LDI		R2,KBSR
		NOT		R2,R2
		LD		R3,NUM1
		NOT		R3,R3
		AND		R2,R2,R3
		NOT		R2,R2
		STI		R2,KBSR;enable keyboard interrupts
		
		AND 	R2,R2,#0;whether it is star or well 0:STAR -1:WELL
		LEA		R3,STAR1
		LEA		R4,WELL1
		
PSTAR	AND		R5,R5,#0
		LEA		R0,STAR1
		AND		R2,R2,R2
		BRn		PWELL
		
		JSR		OFF
		PUTS
		JSR		ON
		JSR		DELAY
		
		LEA		R0,STAR2
		AND 	R2,R2,R2
		BRn		PWELL
		
		JSR		OFF
		PUTS
		JSR		ON
		JSR		DELAY
		
		BR		PSTAR
		
PWELL	AND		R5,R5,#0
		LEA		R0,WELL1
		AND		R2,R2,R2
		BRz		PSTAR
		
		JSR		OFF
		PUTS
		JSR		ON
		JSR 	DELAY
		
		LEA		R0,WELL2
		AND		R2,R2,R2
		BRz		PSTAR
		
		JSR		OFF
		PUTS
		JSR		ON
		JSR 	DELAY
		
BACK	BR		PWELL		
		
DELAY 	ST 		R1, SaveR1
		LD 		R1,COUNT
REP 	ADD 	R1, R1, #-1
		BRp 	REP
		LD 		R1, SaveR1
		RET
		
OFF		ST 		R1, SaveR1
		ST 		R3, SaveR3
		LD		R3,NUM2
		LDI		R1,KBSR
		AND 	R1,R1,R3
		STI		R1,KBSR
		LD 		R1, SaveR1
		LD 		R3, SaveR3
		RET
		
ON		ST 		R1, SaveR1
		ST 		R3, SaveR3
		LDI		R1,KBSR
		NOT		R1,R1
		LD		R3,NUM1
		NOT		R3,R3
		AND		R1,R1,R3
		NOT		R1,R1
		STI		R1,KBSR;enable keyboard interrupts
		LD 		R1, SaveR1
		LD 		R3, SaveR3
		RET
		
COUNT 	.FILL 	x7FFF
SaveR1 	.BLKW 	1	
SaveR2 	.BLKW 	2
SaveR3 	.BLKW 	3
	
SSP		.FILL	x3000
ENTRY	.FILL	x0180
CON		.FILL	x2000;starting address of the interrupt_service_routine
KBSR	.FILL	xFE00
NUM1	.FILL	x4000;for changing KBSR OR
NUM2	.FILL	xBFFF;for changing KBSR AND
STAR1	.STRINGZ	"**    **    **    **    **    **    **    **    \n"		
STAR2	.STRINGZ	"   **    **    **    **    **    **    **    \n"
WELL1	.STRINGZ	"##    ##    ##    ##    ##    ##    ##    ##    \n"
WELL2	.STRINGZ	"   ##    ##    ##    ##    ##    ##    ##    \n"
		.END