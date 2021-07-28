hirom

org $808A05
jsl checkinput

nop
nop
nop
nop
nop

org $b3F67A
checkinput:
	
	php
	pha
	phx
	
	lda $2c		;global frame counter
	and #$0007	;this is lazy code to restrict the frequency at which the player input for the patch is read (basically slow down how fast the buttons repeat)
	cmp #$0000
	bne exit
	
	ldx $502
	cpx #$0010	;check for R press
	beq addsfx
	cpx #$0020	;check for L press
	beq subsfx
	cpx #$2000	;check for Select press
	bne exit
	
	lda $0100	;load current sound from $100
	jsl $B58003	;play sound subroutine
	jmp exit
	
	addsfx:		;adds to the sound effect number at $100 if R is pressed
	inc $0100
	jmp exit
	
	subsfx:		;subtracts the sound effect number at $100 if L is pressed
	dec $0100
	
	exit:		;clean up before returning to base game code
	plx
	pla
	plp
	
	LDA $0502
	STA $050E
	LDA $0506
	
rtl