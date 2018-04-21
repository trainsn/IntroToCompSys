		.ORIG	x3000
;output "Type a room number and press Enter:"
		LEA		R0,inst
		TRAP	x22
;input
		LD		R3,address
loop1	TRAP 	x20	
		TRAP	x21	 
		ADD		R1,R0,#-10;tell the current input is 'entry' or not 		
		BRz		match		
		STR 	R0,R3,#0;store the input to memory
		ADD 	R3,R3,#1		
		BRnzp	loop1
;match
match	AND		R0,R0,#0
		STR		R0,R3,#0	
		LD 		R2,stp;x3300
		LDR		R2,R2,#0;R2<-pointer of the linked list
		LDR		R4,R2,#1;R4<-pointer of the room 
		LDR		R5,R4,#0;R5<-one digit of the room
		LDR		R0,R2,#2;R0<-pointer of the name
		
		LD		R3,address;R3<-input address
		LDR		R1,R3,#0;R1<-one digit of the input
		
loop2	NOT		R1,R1
		ADD 	R1,R1,#1
		ADD		R1,R1,R5;to tell whether the current digit of the input is equal to the current digit of the room number in the linked list  		
		BRnp	Reg2;if these two are not equal,then prepare to compare with the next one in the linked list
		AND 	R5,R5,R5
		BRz		success;if the digit is the sentinel x0000,then prepare to do the success output		
		ADD		R4,R4,#1
		LDR		R5,R4,#0;change to the next digit
		ADD		R3,R3,#1
		LDR		R1,R3,#0;change to the next digit
		BRnzp	loop2
	;prepare to compare with the next one in the linked list
Reg2	LDR		R2,R2,#0;to the next node
		BRz		fail;if the pointer in the linked list is 0 which means there is no room in the linked list, do the fail output
		LDR		R4,R2,#1
		LDR		R5,R4,#0
		LDR		R0,R2,#2
		
		LD		R3,address
		LDR		R1,R3,#0
		BRnzp	loop2
;output
success	TRAP	x22
		BRnzp	stop
fail	LEA		R0,outstr	
		TRAP	x22
;stop
stop	TRAP	x25
address	.BLKW	#15	 
stp		.FILL	x3300	
inst	.STRINGZ	"Type a room number and press Enter:\n"
outstr	.STRINGZ	"No Entry"
		.END
