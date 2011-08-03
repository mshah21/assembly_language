*-----------------------------------------------------------
* Program    : ECE 441 SPRING 2010 PROJECT
* Written by : MALAV SHAH
* Date       : 
* Description:
*-----------------------------------------------------------
	ORG	$2000
	
	               * clear all data and address register
BEGIN	CLR.L	D0
	CLR.L	D1
	CLR.L	D2
	CLR.L	D3
	CLR.L	D4
	CLR.L	D5
	CLR.L	D6
	CLR.L	D7
	MOVEA.L	#$0,A0
	MOVEA.L	#$0,A1
	MOVEA.L	#$0,A2
	MOVEA.L	#$0,A3
	MOVEA.L	#$0,A4
	MOVEA.L	#$0,A5
	MOVEA.L	#$0,A6	

        LEA CMDPROMPT,A1 * display CMDPROMPT ECE 441 PROJECT>
        MOVE.B #14,D0
        TRAP #15

 	MOVE.B #5,D0     * enter space after CMDPROMPT
 	TRAP #15
 	MOVE.B #$20,D2   * check if space is entered or not 
 	CMP  D2,D1
 	BEQ  IN          * if space entered , input command
ERR2    LEA  ERROR2,A1   * else error : Command start with space 
        MOVE.B #14,D0
        TRAP #15
        BRA BEGIN       * CMDPROMPT again user 
         
IN      LEA INPUT,A1    * input command
        LEA INPUTEND,A3
        MOVE.B #2,D0
        TRAP #15
         
CMLNT   MOVE.B #25,D4  * check if commnad lenght inluding commnadline is more than 25 char
        CMP    D4,D1
        BGT    ERR3
ERR     MOVEA.L A1,A2   * copy inputbuffer address to A2
        CMPI.B #$00,(A2) * if byte at input buffer is 00 (no command entered)
        BEQ   ERR1     * dispaly error
        CLR.L	D5
        
******* GET COMMAND FROM INPUT BUFFER ***********        
PLINE	MOVE.B	(A2)+,D5 ; move ascii code of command from input buffer to D5
	CMPI.B	#NULL,(A2) ; is it equal to NULL
	BEQ	ALLCMD  ; if equal go to label ALLCMD
	CMPI.B	#SPACE,(A2) ; if not comapre with SPACE
	BEQ	ALLCMD ; if equal go to label ALLCMD
	ROL.L	#8,D5 ; rotate D5.L to get ASCII code of next command
	CMPA.L	A2,A3 ; if command address  greater than end of command address
	BGE	PLINE ; back to PLINE to get next ASCII code of command


ERR3    LEA    ERROR3,A1 * Dispaly Error Message if command lenght is more tahn 25
        MOVE.B  #14,D0
        TRAP  #15       
        BRA   BEGIN
         
         
ALLCMD	CMPI.L 	#HELPUPPERCASE,D5 ; Check if command is HELP
        BEQ      HELP             ; jump to HELP subroutine
        CMPI.L  #helplowercase,D5 
	BEQ	HELP
	CMPI.L 	#MEMDISPLAY,D5    ; Check if command is MDSY
	BEQ	MDSY              ; jump to MDSY subroutine
	CMPI.L  #mdisplylower,D5
	BEQ     MDSY 
	CMPI.L 	#HEXDEC,D5   	 ; check if command is DECI
	BEQ	HDEC          	; jump to HDEC subroutine
	CMPI.L  #hexdeclower,D5
	BEQ     HDEC
	CMPI.L 	#SORT,D5          ; check if it is SORT 
	BEQ	SORTNUMBER
	CMPI.L  #sortlower,D5
	BEQ     SORTNUMBER
	CMPI.L 	#BFILL,D5         ; check if it is BFILL 
	BEQ	BFIL
	CMPI.L  #bfilllower,D5
	BEQ     BFIL
	CMPI.L 	#MEMCHAGE,D5      ; check if it is MEMCHANGE
	BEQ	MEMORYCHG
	CMPI.L  #changelower,D5
	BEQ     MEMORYCHG
	CMPI.L 	#BMOVE,D5        ; checj if it is MOVE
	BEQ	MOVE
	CMPI.L  #movelower,D5
	BEQ     MOVE
	CMPI.L 	#QUITPROG,D5    ; check if it QUITPROG
	BEQ	EXIT
	CMPI.L  #quitlowercase,D5
	BEQ     EXIT
	CMPI.L 	#GOCMD,D5       ; check if it is GOCMD
	BEQ	GOTO
	CMPI.L  #golower,D5
	BEQ     GOTO
	BRA ERR1           ; if not match any command error1
         
         
         

ERR1     LEA   ERROR1,A1
         MOVE.B #14,D0
         TRAP #15
         BRA  BEGIN    

************* HELP SUBROUTINE ************

HELP	LEA   CLF,A1
        MOVE.B   #14,D0
        TRAP     #15
	
	LEA	HELPALL,A1
	MOVE.B	#14,D0
	TRAP	#15 
	
	LEA     NONECASE,A1
	MOVE.B  #14,D0
	TRAP    #15
	
	LEA     CMDLIST1,A1
	MOVE.B  #14,D0
	TRAP    #15
	
	LEA     CMDLIST2,A1
	MOVE.B  #14,D0
        TRAP    #15 
        
        LEA	MDISPLAY,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	HEXTODEC,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	SORT1,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	SORT2,A1
	MOVE.B	#14,D0
	TRAP	#15
				
	LEA	CHANGE,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	CHANGE1,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	CHANGE2,A1
	MOVE.B	#14,D0
	TRAP	#15


	LEA	BLOCKFILL,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	QUIT,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	GOCOMMAND,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	BLOCKMOVE,A1
	MOVE.B	#14,D0
	TRAP	#15

	
	BRA	BEGIN	
	
*********** EXIT PROGRAM ***********
EXIT    MOVE.B #9,D0
        TRAP #15	
        
************* Memory Display ****************

	
MDSY	BSR	GETADDRESS
	MOVE.L	D0,A4 
	MOVE.W  A4,A0
	BSR     ADDRESSCOMPARE
	BSR	GETADDRESS
	MOVE.L	D0,A5 
        MOVE.W  A5,A0 
        BSR 	ADDRESSCOMPARE 
DIS	MOVE.L	A4,D0 

        
	LEA	BMDIS,A3 
	BSR	PNT4HX
	
	MOVE.B	(A4),D0  
	LEA	BMDA,A3
	BSR	PNT2HX
	
	 LEA BMDIS,A1
	 MOVE.B #14,D0
	 TRAP #15
	 
	LEA	BMDA,A1
	LEA	BEMDA,A3
	MOVE.B	#18,D0
	TRAP	#15
	
	ADDA.L	#1,A4
	CMPA.L	A4,A5
	BGE	DIS

	BRA	BEGIN
	

************ GO SUBROUTINE ***********
GOTO	BSR 	GETADDRESS
	MOVEA.L	D0,A0
	BSR     ADDRESSCOMPARE
	JMP 	(A0)
	
	
************ MEMORY ADDRESS SUBROUTINE************		
       
GETADDRESS 	CLR.L	D4
		CMPI.B	#SPACE,(A2)+
		CMPI.B	#DOLLARSIGN,(A2)+
		BEQ	CONT4
		BRA	ERR1	
		
		CLR.L	D4
CONT4		MOVE.B	(A2)+,D4
		CMPI.B	#NULL,(A2)
		BEQ	CHG4
		CMPI.B	#SPACE,(A2)
		BEQ	CHG4
		CMPI.B	#$3B,(A2)
		BEQ	CHG4	
		ROL.L	#8,D4
		CMPA.L	A2,A3
		BGE	CONT4
	
CHG4		CLR.L	D0
		CLR.L	D1
		CLR.L	D2
		MOVE.L  D4,D1
        	MOVE.W  #3,D0
LOOP4		ROL.L   #8,D1
		BSR     ASCIITOHEX
    		DBF	D0,LOOP4
        	MOVE.L D2,D0
	
		RTS

********** ASCII TABLE **********


ASCIITOHEX CMPI.B #NULL,D1
        BEQ    NOTZERO
	CMPI.B #AZERO,D1
        BEQ    ZERO
        CMPI.B #AONE,D1
        BEQ    ONE
        CMPI.B #ATWO,D1
        BEQ    TWO
        CMPI.B #ATHREE,D1
        BEQ    THRE
        CMPI.B #AFOUR,D1
        BEQ    FOUR
        CMPI.B #AFIVE,D1
        BEQ    FIVE
        CMPI.B #ASIX,D1
        BEQ    SIX
        CMPI.B #ASEVEN,D1
        BEQ    SEV
        CMPI.B #AEIGHT,D1
        BEQ    OCT
        CMPI.B #ANINE,D1
        BEQ    NINE
        CMPI.B #ATEN,D1
        BEQ    TEN
        CMPI.B #AELEVEN,D1
        BEQ    ELE
        CMPI.B #ATWELVE,D1
        BEQ    TEW
        CMPI.B #ATHIRTEEN,D1
        BEQ    THRT
        CMPI.B #AFOURTEEN,D1
        BEQ    FORT
        CMPI.B #AFIFTEEN,D1
        BEQ    FIVT

NOTZERO	RTS

ZERO    ROL.L     #4,D2
        ADDI.L    #$00,D2
        RTS
ONE     ROL.L     #4,D2
        ADDI.L    #$01,D2
        RTS
TWO     ROL.L     #4,D2
        ADDI.L    #$02,D2
        RTS
THRE    ROL.L     #4,D2   
        ADDI.L    #$03,D2
        RTS
FOUR    ROL.L     #4,D2   
        ADDI.L    #$04,D2
        RTS
FIVE    ROL.L     #4,D2
        ADDI.L    #$05,D2
        RTS
SIX     ROL.L     #4,D2
        ADDI.L    #$06,D2
        RTS
SEV     ROL.L     #4,D2
        ADDI.L    #$07,D2
        RTS
OCT     ROL.L     #4,D2
        ADDI.L    #$08,D2
        RTS
NINE    ROL.L     #4,D2
        ADDI.L    #$09,D2
        RTS
TEN     ROL.L     #4,D2
        ADDI.L    #$A,D2
        RTS
ELE     ROL.L     #4,D2
        ADDI.L    #$B,D2
        RTS
TEW     ROL.L     #4,D2
        ADDI.L    #$C,D2
        RTS
THRT    ROL.L     #4,D2
        ADDI.L    #$D,D2
        RTS
FORT    ROL.L     #4,D2
        ADDI.L    #$E,D2
        RTS
FIVT    ROL.L     #4,D2
        ADDI.L    #$F,D2
        RTS
        
        
 *********************************
*
*  PRINT HEX ROUTINES
*
*
**********************************
*
PNT8HX   SWAP    D0             ;FLIP REG HALVES
         BSR.S   PNT4HX         ;DO TOP WORD
         SWAP    D0             ;NOW DO LOWER WORD
         BRA.S   PNT4HX

PNT6HX   SWAP    D0             ;FLIP REGISTER HALVES
         BSR.S   PNT2HX
         SWAP    D0             ;FLIP BACK REG HALVES

PNT4HX   MOVE.W  D0,D1          ;SAVE IN TEMP
         ROR.W   #8,D0          ;GET BITS 15-8 INTO LOWER BYTE
         BSR.S   PNT2HX         ;PRINT IT
         MOVE.W  D1,D0          ;PULL IT BACK

PNT2HX   MOVE.W  D0,D2          ;SAVE IN TEMP REG
         ROXR.W  #4,D0          ;FORM UPPER NIBBLE
         BSR.S   PUTHEX         ;PUT ASCII INTO PRINT BUFFER
         MOVE.W  D2,D0          ;GET BACK FROM TEMP


PUTHEX   ANDI.B  #$0F,D0        ;SAVE LOWER NIBBLE
         ORI.B   #$30,D0        ;CONVERT TO ASCII
         CMPI.B  #$39,D0        ;SEE IF IT IS>9
         BLE.S   SAVHEX
         ADD     #7,D0          ;ADD TO MAKE 10=>A
SAVHEX   MOVE.B  D0,(A3)+   * CHANGE    ;PUT IT IN PRINT BUFFER
	 RTS
	 
	 
	 
*********HEXTODEC SUBROUTINE********
HDEC  	CMPI.B	#$20,(A2)+
	CMPI.B	#DOLLARSIGN,(A2)+
	BEQ	CONT3
	BRA	ERR1

	CLR.L	D4
CONT3	MOVE.B	(A2)+,D4
	CMPI.B	#NULL,(A2)
	BEQ	CHG3
	CMPI.B	#SPACE,(A2)
	BEQ	CHG3
	ROL.L	#8,D4
	CMPA.L	A2,A3
	BGE	CONT3
	
CHG3	CLR.L	D0
	CLR.L	D1
	CLR.L	D2
	MOVE.B	#$00,(HEXNUMBER)
	MOVE.B	#$00,(HEXNUMBER+1)
	MOVE.B	#$00,(HEXNUMBER+2)
	MOVE.L  D4,D1
	MOVE.W	D4,(HIN)
        MOVE.W  #3,D0 
LOOP3	ROL.L   #8,D1
	BSR     ASCIITOHEX
    	DBF	D0,LOOP3
        MOVE.L D2,D6

	LEA	HEXNUMBER,A1	
	BSR	DECIMAL
        CLR.L   D1
        LEA	HEXNUMBER,A1
	MOVE.B	#18,D0
	TRAP	#15
	BRA   BEGIN


DECIMAL	CLR.L 	D0				;CLEAR D0, D1, D2
	CLR.L	D1				 
	CLR.L	D2
        
	LEA	HEXNUMBER,A4			;MOVE STARING ADDRESS OF NUM A4
	MOVE.B	D6,D0				;MOVE D6 TO D0
	MOVE.B	D6,D1				;MOVE D6 TO D1
	
	DIVU.W	#100,D0				;DIVIDE D0 BY 100 AND STORE IN D0
	MOVE.B	D0,(A4)+			;MOVE D0 TO (A4) AND INCERMENT
						
	MULS.W	#100,D0				;TIMES D0 BY 100 AND STORE IN D0
	SUB.W	D0,D1				;SUBTRACT D1 BY D0
	MOVE.B	D1,D2				;MOVE D1 TO D2
	DIVU.W	#10,D1				;DIVIDE D1 BY 10
	MOVE.B	D1,(A4)+			;MOVE D1 TO (A4) AND INCERMENT
						
	MULS.W	#10,D1				;TIMES D1 BY TEN
	SUB.W	D1,D2				;SUBTRACT D2 BY D1
	MOVE.B	D2,(A4)+			;MOVE D2 IN (A4) AND INCERMENT
						
DEC2ASC	LEA	HEXNUMBER,A4				;MOVE THE ADDRESS OF NUM TO A1
	ADDI.B	#$30,(A4)+			;ADD $30 TO (A4) AND INCERMENT
	ADDI.B	#$30,(A4)+			;ADD $30 TO (A4) AND INCERMENT
	ADDI.B	#$30,(A4)+

	RTS	
*************BLOCK MOVE SOUBROUTINE ******************************
MOVE	BSR	GETADDRESS
	MOVE.L	D0,A4
	BSR	GETADDRESS
	MOVE.L	D0,A5
	BSR	GETADDRESS
	MOVE.L	D0,A6

	MOVE.L	A4,D0
	MOVE.L	A5,D1
         MOVE.B  (A4),(A6)
        CMPA   A4,A5
        BEQ    BACK1
BACK    ADD.L #$1,A4
        ADD.L #$1,A6 
        MOVE.B (A4),(A6)
        CMPA    A4,A5
        BEQ      BACK1
        JMP     BACK
	
BACK1	BRA     BEGIN
	
******** BLOCKFILL SUBROUTINE ****************************
BFIL	BSR	GETADDRESS
	MOVE.L	D0,A0
	MOVE.W  D0,D3
	BSR     ADDRESSCOMPARE
	   
	BSR	GETADDRESS
	MOVE.L	D0,A1
	MOVE.W  A1,A0
        BSR     ADDRESSCOMPARE
        MOVE.W  D3,A0 

	CLR.L	D4
	CMPI.B	#$20,(A2)+
CONT6	MOVE.B	(A2)+,D4
	CMPI.B	#$00,(A2)
	BEQ	CHG5
	CMPI.B	#$20,(A2)
	BEQ	CHG5
	CMPI.B	#$3B,(A2)
	BEQ	CHG5	
	ROL.L	#8,D4
	CMPA.L	A2,A3
	BGE	CONT6

CHG5	CLR.L	D0
	CLR.L	D1
	CLR.L	D2
	MOVE.L  D4,D1
        MOVE.W  #3,D0
LOOP9	ROL.L   #8,D1
	BSR     ASCIITOHEX
    	DBF	D0,LOOP9
        MOVE.L 	D2,D0

BFLOOP	MOVE.W	D0,(A0)+
	CMPA.L	A0,A1
	BGE	BFLOOP
	BRA	BEGIN
	
	
	
********* SORTING SUBROUTINE****************************
SORTNUMBER BSR 	GETADDRESS
	MOVEA.L	D0,A0
	BSR	GETADDRESS
	MOVEA.L	D0,A1
	MOVE.L	A0,D0
	MOVE.L	A1,D1
	CMPI.B 	#$20,(A2)+
	BNE	DSEND
	CMPI.B	#$3B,(A2)+
	BNE	DSEND
	CMPI.B	#$41,(A2)+
	BEQ	ASSEND

DSEND	SUB.L	D0,D1
	DIVU	#2,D1
	MOVE.L	D1,D0
	ADD.L	#4,D0
	SUB.L	#1,D1
	MOVE.L	D1,D4
	MOVEA.L	A1,A4
	MOVEA.L	A1,A5
	
	MOVE.L	A1,A6
	BRA	CAMP
SONEXT	MOVE.L	D4,D1	
	MOVEA.L	A5,A6
	MOVEA.L	A5,A1
	SUBA.L	#2,A6

CAMP	MOVE.W	(A1),D2
	MOVE.W	(A6),D3
	CMP.W	D2,D3
	BLE	SWAP
	SUBA.L	#2,A6
	SUBA.L	#2,A1
	
MAYBE	DBF	D1,CAMP

	
	DBF	D0,SONEXT
	
	BRA	BEGIN
		
SWAP	MOVE	D3,(A1)
	MOVE	D2,(A6)
	BRA	MAYBE
	
ASSEND	SUB.L	D0,D1
	DIVU	#2,D1
	MOVE.L	D1,D0
	ADD.L	#4,D0
	SUB.L	#1,D1
	MOVE.L	D1,D4
	MOVEA.L	A1,A4
	MOVEA.L	A1,A5
	
	MOVE.L	A1,A6
	BRA	CAMPA
SANEXT	MOVE.L	D4,D1	
	MOVEA.L	A5,A6
	MOVEA.L	A5,A1
	SUBA.L	#2,A6

CAMPA	MOVE.W	(A1),D2
	MOVE.W	(A6),D3
	CMP.W	D2,D3
	BGE	SWAPA
	SUBA.L	#2,A6
	SUBA.L	#2,A1
	
MAYBEA	DBF	D1,CAMPA

	
	DBF	D0,SANEXT
	
	BRA	BEGIN
	
SWAPA	MOVE	D3,(A1)
	MOVE	D2,(A6)
	BRA	MAYBEA

********* ADDRESS COMAPRE SUBROUTINE ************
ADDRESSCOMPARE CLR.L D6
               MOVE.W #$3000,D6
               CMPA   D6,A0
               BLE    BFILERR
               RTS
BFILERR        LEA   BFERR,A1
               MOVE.B #14,D0
               TRAP  #15
               BRA   BEGIN  
               
               

************MEMORY CHANGE SUBROUTINE***********************

MEMORYCHG BSR GETADDRESS
	MOVEA.L D0,A0
	
	CMPI.B	#$3B,(A2)+
	CMPI.B	#$57,(A2)
	BEQ	WORD
	CMPI.B	#$4C,(A2)
	BEQ	LONG

			
REPB	MOVE.L	#$0,(BMCIN)
	MOVE.L	#$0,(BMCIN1)
	MOVE.L 	A0,D0
	MOVE.L	A0,D6
	LEA	BAMC,A3
	BSR	PNT4HX
	MOVE.B	(A0)+,D0
	
	LEA	BBMC,A3
	BSR	PNT2HX

	LEA	BAMC,A1 
	MOVE.B	#18,D0
	TRAP	#15
	
	LEA	BSPACE,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	BBMC,A1
	MOVE.B	#18,D0
	TRAP	#15
	

	LEA	BFOR,A1
	MOVE.B	#14,D0
	TRAP	#15
	
	
	LEA	BMCIN,A1
	MOVE.B	#2,D0
	TRAP	#15
         
   
	CMPI.L	#$2E000000,(BMCIN)
	BNE	CHGB
	BRA 	BEGIN
	
CHGB	CLR.L	D0
	CLR.L	D1
	CLR.L	D2
	MOVE.W	(BMCIN),D1
        MOVE.W  #3,D0
LOOP5	ROL.L   #8,D1
	BSR     ASCIITOHEX
    	DBF	D0,LOOP5
        MOVE.L 	D2,D0
	MOVEA.L	D6,A1
	MOVE.B	D0,(A1)
	BRA 	REPB

WORD	MOVE.L	$0,(BMCIN)
	MOVE.L	$0,(BMCIN1)
	MOVE.L 	A0,D0
	MOVE.L	A0,D6
	LEA	BAMC,A3
	BSR	PNT4HX
	MOVE.W	(A0)+,D0
	
	LEA	BWMC,A3
	BSR	PNT4HX

	LEA	BAMC,A1
	MOVE.B	#18,D0
	TRAP	#15
	
	LEA	BSPACE,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	BWMC,A1
	MOVE.B	#18,D0
	TRAP	#15
	

	LEA	BFOR,A1
	MOVE.B	#14,D0
	TRAP	#15
	
	LEA	BMCIN,A1
	MOVE.B	#2,D0
	TRAP	#15

	CMPI.L	#$2E000000,(BMCIN)
	BNE	CHGW
	BRA 	BEGIN
	
CHGW	CLR.L	D0
	CLR.L	D1
	CLR.L	D2
	MOVE.L	(BMCIN),D1
        MOVE.W  #3,D0
LOOP6	ROL.L   #8,D1
	BSR     ASCIITOHEX
    	DBF	D0,LOOP6
        MOVE.L 	D2,D0
	MOVEA.L	D6,A1
	MOVE.W	D0,(A1)
	BRA 	WORD




LONG	MOVE.L	$0,(BMCIN)
	MOVE.L	$0,(BMCIN1)
	MOVE.L 	A0,D0
	MOVE.L	A0,D6
	LEA	BAMC,A3
	BSR	PNT4HX
	MOVE.L	(A0)+,D0
	
	LEA	BLMC,A3
	BSR	PNT8HX

	LEA	BAMC,A1
	MOVE.B	#18,D0
	TRAP	#15
	
	LEA	BSPACE,A1
	MOVE.B	#14,D0
	TRAP	#15

	LEA	BLMC,A1
	MOVE.B	#18,D0
	TRAP	#15
	

	LEA	BFOR,A1
	MOVE.B	#14,D0
	TRAP	#15
	
	
	LEA	BMCIN,A1
	MOVE.B	#2,D0
	TRAP	#15

	CMPI.L	#$2E000000,(BMCIN)
	BNE	CHGL
	BRA 	BEGIN
	
CHGL	CLR.L	D5
	CLR.L	D0
	CLR.L	D1
	CLR.L	D2
	MOVE.L	(BMCIN),D1
        MOVE.W  #3,D0
LOOP7	ROL.L   #8,D1
	BSR     ASCIITOHEX
    	DBF	D0,LOOP7
        MOVE.L 	D2,D0
	MOVE.W	D0,D5
	SWAP.W  D5

	CLR.L	D0
	CLR.L	D1
	CLR.L	D2
	MOVE.L	(BMCIN),D1
        MOVE.W  #3,D0
LOOP8	ROL.L   #8,D1
	BSR     ASCIITOHEX
    	DBF	D0,LOOP8
        MOVE.L 	D2,D0
	MOVE.W	D0,D5
	MOVEA.L	D6,A1
	MOVE.L	D5,(A1)
	BRA 	LONG               
               
*
               
********* LOOKUP TABLE **************

		ORG $1000
         
STACK 		EQU $3000
STACKA0         EQU $3050
CR    		EQU $0D
SPACESIGN	EQU $20
LF    		EQU $0A
SPACE           EQU $20 
DOLLARSIGN      EQU $24

************ COMMAND TABLE **********

HELPUPPERCASE  	EQU $48454C50
helplowercase   EQU $68656C70
MEMDISPLAY   	EQU $4D445359
mdisplylower    EQU $6D647379 
HEXDEC       	EQU $44454349
hexdeclower     EQU $64656369 
QUITPROG     	EQU $51554954
quitlowercase   EQU $71756974
GOCMD           EQU $474F544F
golower         EQU $676F746F 
BMOVE  		EQU $4D4F5645
movelower       EQU $6D6F7665   
BFILL           EQU $46494C4C
bfilllower      EQU $66696C6C 
SORT            EQU $534F5254
sortlower       EQU $736F7274 
MEMCHAGE        EQU $4D434847
changelower     EQU $6D636867  

AZERO           EQU $30
AONE		EQU $31
ATWO		EQU $32
ATHREE     	EQU $33
AFOUR     	EQU $34
AFIVE       	EQU $35
ASIX      	EQU $36
ASEVEN    	EQU $37
AEIGHT   	EQU $38
ANINE     	EQU $39
ATEN       	EQU $41
AELEVEN	   	EQU $42
ATWELVE    	EQU $43
ATHIRTEEN  	EQU $44
AFOURTEEN  	EQU $45
AFIFTEEN   	EQU $46
ADDRESSERR	EQU $0C
ILLIGLEINSTERR	EQU $10
BSERR		EQU $08
DIVIDEZEROERR	EQU $14
PRIVIOERR	EQU $20
LINEAERR	EQU $28
LINEFERR	EQU $2C
NULL            EQU $00 
           

CMDPROMPT   	DC.B     'ECE 441 Project>',0  
ERROR1    	DC.B     'AHA! Wrong Command',CR,LF,0 
ERROR2  	DC.B     'Command BEGIN with space',CR,LF,0
ERROR3   	DC.B     'Hmm! You reached maximum command lenght',CR,LF,0
BFERR           DC.B     'You are accessing program area',CR,LF,0
INPUT		DS.B 	50
INPUTEND 	DC.B    $00
CMDBUF		DS.B 	10

CLF             DC.B     CR,LF,0
NONECASE        DC.B    'ALL COMMANDS ARE NOT CASE SENSITIVE',CR,LF,0
CMDLIST1	DC.B	'HELP MDSY SORT MOVE ',CR,LF,0
CMDLIST2	DC.B	'FILL  MCHG  DECI QUIT  GOTO',CR,LF,0
HELPALL		DC.B	'HELP-DISPLAYS ALL COMMANDS',CR,LF,0
MDISPLAY	DC.B	'MDSY $<BEGIN ADD> $<END ADD> DISPLAY MEM CONTENT',CR,LF,0
HEXTODEC        DC.B    'DECI $<HEX NO> CONVERT HEX TO DEC (0-255)',CR,LF,0
SORT1		DC.B	'SORTNUMBER $<BEGIN ADD> $<END ADD> ;X  -here X = A OR D',CR,LF,0
SORT2		DC.B	'SORTS WORDS IF X=A IN ASCENDING ORDER AND DESCENDING BY DEFAULT',CR,LF,0
CHANGE		DC.B	'MCHG <BEGIN ADD>;X - here X = W or L Or NOTHING',CR,LF,0
CHANGE1		DC.B	'MEMEORY CHANGE, IF X=W CHANGE BY WORD IF X=L CHANGE BY LONGWORD',CR,LF,0
CHANGE2		DC.B	'CHANGE BY BYTE DEFAULT',CR,LF,0
BLOCKFILL	DC.B	'FILL $<BEGIN ADD> $<END ADD> $<WORD> FILL BLOCK WITH WORD',CR,LF,0
QUIT		DC.B	'QUIT- EXIT THE PROGRAM ',CR,LF,0
GOCOMMAND	DC.B	'GOTO $<BEGIN PROG ADD> EXECUTION OF PROGRAMS',CR,LF,0
BLOCKMOVE 	DC.B	'MOVE $<STA ADD> $<END ADD> $<MOVE INI ADD>',CR,LF,0
ABUF		DS.W	2
ABUFE		DC.B	$00

ADDERR		DC.B	'ADDRESS ERROR EXCEPTION',0
BUSERR		DC.B	'BUS ERROR EXCEPTION',0
ILLERR		DC.B	'ILLEGAL INSTRUCTION EXCEPTION',0
PRIVERR		DC.B	'PRIVILEGE VIOLATION ECEPTION',0
DZEROERR	DC.B	'DIVIDE BY ZERO EXCEPTION',0
LAERR		DC.B	'LINE A EMULATOR',0
LFERR		DC.B	'LINE F EMULATOR',0


*******************************
*MDIS - Memory Display
*******************************

BMDIS	DS.W	2
BEMDIS	DC.B	'|'
BMDA	DC.W	1
BEMDA	DC.B	$00




******************************
*HDEC - Hex to Decimal
******************************
HIN		DS.W	1 
HEXNUMBER	DS.B	3 
HEXNUMBERE	DC.B	$00
HHEX		DS.W	4



*
*MCHG
*
BAMC	DS.B	4
BAMCE	DC.B	$00

BBMC	DS.B	2	
BBMCE	DC.B	$0

BWMC	DS.W	2
BWMCE	DC.B	$00

BLMC	DS.L	2
BLMCE	DC.B	$00

BFOR	DC.B	' ? '
BFORE	DC.B	$00

BMCIN	DS.L	1
BMCIN1	DS.L	1
BMCINE	DC.B	$00
BSPACE	DC.B	' '
BSPACEE	DC.B	$00

	

	END	BEGIN		; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~8~
