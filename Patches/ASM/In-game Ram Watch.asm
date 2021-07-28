
bank_address = $0102

hirom

org $BEC69C
jsl oam_value_init	;hijack for oam dma
nop
nop


org $808A05
jsl checkinput		;hijack for input check

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
	phy
	
	jsr upload_gfx
	
	lda $2c		;global frame counter
	and #$0007	;this is lazy code to restrict the frequency at which the player input for the patch is read (basically slow down how fast the buttons repeat)
	cmp #$0000
	bne exit_jump
	
	lda $502
	and #$0010
	cmp #$0010	;check for R press
	bne check_next_input
	jsr add_address
	jmp exit
	
	check_next_input:
	
	lda $502
	and #$0020
	cmp #$0020	;check for L press
	bne exit_jump
	jsr sub_address
	exit_jump:
	jmp exit
	
	
	
	add_address:		;adds to the $0100 number at $100 if R is pressed
		lda $502
		and #$2000
		cmp #$2000	;check for Select press
		bne no_select_r
		lda $0100
		clc
		adc #$0100
		sta $0100
		jmp exit_r
		
		no_select_r:
		lda $502
		and	#$0040
		cmp #$0040
		bne no_x_r
		lda $0100
		clc
		adc #$0010
		sta $0100
		jmp exit_r
		
		no_x_r:
		lda $502
		and	#$0080
		cmp #$0080
		bne no_a_r
		inc $0102
		jmp exit_r
		
		no_a_r:
		inc $0100
		inc $0100
		exit_r:
	rts
	
	sub_address:		;subtracts the $0100 number at $100 if L is pressed
		lda $502
		and #$2000
		cmp #$2000	;check for Select press
		bne no_select_l
		lda $0100
		sec
		sbc #$0100
		sta $0100
		jmp exit_l
		
		no_select_l:
		lda $502
		and	#$0040
		cmp #$0040
		bne no_x_l
		lda $0100
		sec
		sbc #$0010
		sta $0100
		jmp exit_l
		
		no_x_l:
		lda $502
		and	#$0080
		cmp #$0080
		bne no_a_l
		dec $0102
		jmp exit_l
		
		no_a_l:
		dec $0100
		dec $0100
		exit_l:
	rts
	
	upload_gfx:
		LDA #$0000			;vram $0100
		STA $2116
		LDA #$FD00			;rom $0100
		LDX #$00b3			;rom bank
		LDY #$0200			;data size
		JSL $80895F
	rts
	
	exit:
	
	ply
	plx
	pla
	plp
	
	LDA $0502
	STA $050E
	LDA $0506
	
rtl



	oam_value_init:	
	
		php
		pha
		phx
		phy
		phb

		lda $0102
		xba
		pha
		plb
		plb

		ldy #$d00f			;sprite position
		
		lda $0100
		tax
		lda 0000,x
		
		and #$f000
		clc
		rol
		rol
		rol
		rol
		rol
		jsr oam_value_upload

		lda $0100
		tax
		lda 0000,x

		and #$0f00
		xba
		and #$000f
		jsr oam_value_upload

		lda $0100
		tax
		lda 0000,x

		and #$00f0
		lsr
		lsr
		lsr
		lsr
		jsr oam_value_upload

		lda $0100
		tax
		lda 0000,x

		and #$000f
		jsr oam_value_upload
		jmp oam_address_init
			
		oam_overflow:
		rts
		
		oam_value_upload:
		
			clc
			ldx $0070		;next free oam slot
			CPX #$0400
			BCS oam_overflow	;oam overflow check
			
			adc #$3000
			
			sta $0002,x		;upload sprite tile info
			tya
			sta $0000,x		;upload sprite position
			
			adc #$000a
			tay
			
			inc $0070
			inc $0070
			inc $0070
			inc $0070
			
		rts

		
		oam_address_init:
		
			ldy #$c00f			;sprite position
			
			lda $0100
			and #$f000
			clc
			rol
			rol
			rol
			rol
			rol
			jsr oam_value_upload
			
			lda $0100
			and #$0f00
			xba
			and #$000f
			jsr oam_value_upload
			
			lda $0100
			and #$00f0
			lsr
			lsr
			lsr
			lsr
			jsr oam_value_upload
			
			lda $0100
			and #$000f
			jsr oam_value_upload
			jmp oam_bank_init
				
		oam_exit:
		
			plb
			ply
			plx
			pla
			plp
			
			LDA $0D2C
			AND #$0E00
			
		rtl
	
	
	
	
		oam_bank_init:
			
			ldy #$b00f			;sprite position
			
			lda bank_address
			and #$00f0
			lsr
			lsr
			lsr
			lsr
			jsr oam_value_upload
			
			lda bank_address
			and #$000f
			jsr oam_value_upload
			
			jmp oam_exit
	
	
	
	
org $b3FD00

DATA_TEXT:
db $3C, $00, $42, $00, $99, $00, $91, $00, $89, $00, $99, $00, $42, $00, $3C, $00, $00, $00, $3C, $00, $66, $00, $6E, $00, $76, $00, $66, $00, $3C, $00, $00, $00, $18, $00, $24, $00, $44, $00, $24, $00, $24, $00, $24, $00, $42, $00, $3C, $00, $00, $00, $18, $00, $38, $00, $18, $00, $18, $00, $18, $00, $3C, $00, $00, $00, $3C, $00, $42, $00, $99, $00, $79, $00, $43, $01, $9E, $01, $81, $00, $7E, $00, $00, $00, $3C, $00, $66, $00, $06, $00, $3C, $00, $60, $00, $7E, $00, $00, $00, $3C, $00, $42, $00, $99, $00, $72, $00, $79, $00, $99, $00, $42, $00, $3C, $00, $00, $00, $3C, $00, $66, $00, $0C, $00, $06, $00, $66, $00, $3C, $00, $00, $00, $60, $00, $9C, $00, $92, $00, $92, $00, $81, $00, $72, $00, $12, $00, $0C, $00, $00, $00, $60, $00, $6C, $00, $6C, $00, $7E, $00, $0C, $00, $0C, $00, $00, $00, $7E, $00, $81, $00, $BE, $00, $82, $00, $79, $00, $19, $00, $42, $00, $3C, $00, $00, $00, $7E, $00, $40, $00, $7C, $00, $06, $00, $66, $00, $3C, $00, $00, $00, $3C, $00, $42, $00, $9C, $00, $82, $00, $99, $00, $99, $00, $42, $00, $3C, $00, $00, $00, $3C, $00, $60, $00, $7C, $00, $66, $00, $66, $00, $3C, $00, $00, $00, $7E, $00, $81, $00, $72, $00, $12, $00, $24, $00, $24, $00, $24, $00, $18, $00, $00, $00, $7E, $00, $0C, $00, $0C, $00, $18, $00, $18, $00, $18, $00, $00, $00, $3C, $00, $42, $00, $99, $00, $42, $00, $99, $00, $99, $00, $42, $00, $3C, $00, $00, $00, $3C, $00, $66, $00, $3C, $00, $66, $00, $66, $00, $3C, $00, $00, $00, $3C, $00, $42, $00, $99, $00, $99, $00, $41, $00, $39, $00, $42, $00, $3C, $00, $00, $00, $3C, $00, $66, $00, $66, $00, $3E, $00, $06, $00, $3C, $00, $00, $00, $3C, $00, $42, $00, $99, $00, $99, $00, $81, $00, $99, $00, $99, $00, $66, $00, $00, $00, $3C, $00, $66, $00, $66, $00, $7E, $00, $66, $00, $66, $00, $00, $00, $7C, $00, $82, $00, $99, $00, $82, $00, $99, $00, $99, $00, $82, $00, $7C, $00, $00, $00, $7C, $00, $66, $00, $7C, $00, $66, $00, $66, $00, $7C, $00, $00, $00, $3C, $00, $42, $00, $99, $00, $96, $00, $96, $00, $99, $00, $C2, $00, $7C, $00, $00, $00, $3C, $00, $66, $00, $60, $00, $60, $00, $66, $00, $3C, $00, $00, $00, $7C, $00, $82, $00, $99, $00, $99, $00, $99, $00, $99, $00, $82, $00, $7C, $00, $00, $00, $7C, $00, $66, $00, $66, $00, $66, $00, $66, $00, $7C, $00, $00, $00, $7E, $00, $81, $00, $9E, $00, $84, $00, $98, $00, $9E, $00, $81, $00, $7E, $00, $00, $00, $7E, $00, $60, $00, $78, $00, $60, $00, $60, $00, $7E, $00, $00, $00, $7E, $00, $81, $00, $9E, $00, $84, $00, $98, $00, $90, $00, $90, $00, $60, $00, $00, $00, $7E, $00, $60, $00, $78, $00, $60, $00, $60, $00, $60, $00, $00, $00