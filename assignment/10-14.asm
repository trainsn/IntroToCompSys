		LDI		R0,KBDR
		LDI		R1,NEX;pointer
		LD 		R2,NA
		ADD		R2,R1,R2
		BRz		FULL
		STR		R0,R1,#0
		ADD		R1,R1,#1
		STI		R1,NEX
		BR		DONE
FULL	LEA		R0,STRI
		TRAP	x22
DONE	RTI
KBDR 	.FILL	xFE02
STA		.FILL	x4000 
NEX		.FILL	x40FF	
NA		.FILL	xBF01;-x40FF
STRI	.STRINGZ	"Character cannot be accepted;input buffer full."


