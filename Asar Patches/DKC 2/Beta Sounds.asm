hirom

org $35F92A
	lda #$0609	;replace banana bunch sound

org $38A90D
	jsr playbarrelsfx	;hijack code for playing dk barrel sound

org $38DD90
	playbarrelsfx:	;this will only be executed when setting the second kong flag via a dk barrel
	
	LDA #$0103		;sound to play (the higher byte seems to be which channel to play the sound on)
	JSL $B58003		;play sound subroutine
	
	LDA #$4000		;execute overwritten instruction before returning

	rts
	
	org $33E73E
	dw $F64A	;animal barrel code pointer
	
	org $33F64A
	
	JSR $EFCF
	LDX $64
	LDA $2A		;load global frame timer
	LSR
	BCS oddframe
	LDA $3A,X	;load barrel transform timer
	CMP #$003C	;check if barrel transform timer is 3C
	BNE nosound
	PHX 
	LDA #$0755	;sound to play (the higher byte seems to be which channel to play the sound on)
	JSL $B58003	;play sound subroutine
	PLX 
	
	nosound:	;dont play the sound
	DEC $3A,X	;decrement barrel transform timer
	BMI transformtimerzero
	
	oddframe:
	LDA $3A,X
	JSR $E5E9
	JSR $F0BC
	JML [$05A9]
	
	transformtimerzero:
	STZ $2C,X
	JMP $E999