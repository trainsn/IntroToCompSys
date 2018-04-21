		LDI		R0,KBDR
		
		LDI		R1,NUM;R1<-the number in the queue
		LD		R2,MAXNUM
		ADD		R2,R1,R2
		BRz		FULL	;Buffer is full
		
		ADD		R1,R1,#1
		STI		R1,NUM;update char count
			
		LDI		R1,NEX;R1<-pointer	
		STR		R0,R1,#0;store the char
		
		LD		R2,NA
		ADD		R2,R1,R2
		BRz		CIR;compare the current location with x40FC
					;if same,the next empty location turns to x4000
		ADD		R1,R1,#1;else just increment the pointer
		BR		STORE
		
CIR		LD		R1,STA
STORE	STI		R1,NEX;update next available empty buffer location pointer
		BR		DONE
FULL	LEA		R0,STRI
		TRAP 	x22
DONE	RTI		
		
KBDR	.FILL	xFE02
STA		.FILL	x4000
NUM		.FILL 	x40FD
MAXNUM	.FILL	xFF04;-x00FD
NEX		.FILL	x40FF
NA		.FIIL	xBF04;-x40FC
STRI	.STRINGZ	"Character cannot be accepted;input buffer full."
