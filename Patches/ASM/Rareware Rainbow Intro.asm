hirom

org $8096CC	;white?
jsl hijack
nop
nop
nop

org $8096DE
jsl hijack
nop
nop
nop

org $8096F0
jsl hijack
nop
nop
nop

org $8096F7
jsl hijack
nop
nop
nop

org $2DE750
hijack:

	php

	lda $002A
	and #$0060
	cmp #$0060
	beq full_b

	lda $002A
	and #$0040
	cmp #$0040
	beq full_g
	
	lda $002A
	and #$0020
	cmp #$0020
	beq full_r
		;r to y
		lda $002A
		and #$001F
		asl
		asl
		asl
		asl
		asl
		
		adc #$001F
		and #$7FFF

		plp
		sta $7E8968,x
		rtl
		
	full_r:
		;y to g
		lda $002A
		and #$001F
		sta $0100
		
		lda #$03FF
		
		sec
		sbc $0100

		plp
		sta $7E8968,x
		rtl
	
	full_g:
		;g to c
		lda $002A
		and #$001F
		xba
		asl
		asl
		
		sta $0100
		
		lda #$03E0
		
		adc $0100


		plp
		sta $7E8968,x
		rtl
		
	full_b:
		;c to b
		lda $002A
		and #$001F
		asl
		asl
		asl
		asl
		asl

		sta $0100
		
		lda #$7FE0
		
		sec
		sbc $0100

		plp
		sta $7E8968,x
		rtl
