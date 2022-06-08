hirom
org $80d6fb
jsl $3BC8F0

org $80d70c
jsl $3BC8F0

org $80d71d
jsl $3BC8F0

org $3BC8F0
clc
phy
ldy $0032
stx $0032		;current offset for reading palette value?

lda $0a8e		;current level palette address
and #$ff00
adc #$00d0
adc $0032

tax

lda $fd0000,x	;instead of lda $fd22d0

ldx $0032
sty $0032
ply
rtl