;Written by H4v0c21
;Derived from https://github.com/FredYeye/Unveiled K. Rool Script
;Original asm file by FredYeye and emptysys
;7/7/21

math pri on : math round off : hirom

macro unknown0(a, b, c)
	dw $0000, <a>, <b>, <c>
endmacro

macro goto(offset)
	;jumps to specified address
	;goto 0 is a special case and jumps to the current pattern's starting point
	dw $0002, <offset>
endmacro

macro unknown4(a)
	dw $0004, <a>
endmacro

macro unknown5(a, b)
	dw $0005, <a>, <b>
endmacro

macro unknown6()
	dw $0006
endmacro

macro unknown7(a)
	dw $0007, <a>
endmacro

macro unknown8(a)
	dw $0008, <a>
endmacro

macro unknown9()
	dw $0009
endmacro

macro unknowna()
	dw $000A
endmacro

macro unknownb(a, b)
	dw $000B, <a>, <b>
endmacro

macro unknownc(a)
	dw $000C, <a>
endmacro

macro goto_if(a)
	;wait x amount of frames
	dw $000D, <a>
endmacro

macro unknowne()
	dw $000E
endmacro

macro unknownf(a)
	dw $000F, <a>
endmacro

macro unknown10()
	dw $0010
endmacro

macro unknown11()
	dw $0011
endmacro

macro unknown12(a, b, c)
	dw $0012, <a>, <b>, <c>
endmacro

macro unknown13()
	dw $0013
endmacro

macro unknown15(a, b)
	dw $0015, <a>, <b>
endmacro

macro unknown16()
	dw $0016
endmacro

macro unknown18()
	dw $0018
endmacro

macro unknown19(a, b)
	dw $0019, <a>, <b>
endmacro

macro unknown1a(a, b)
	dw $001A, <a>, <b>
endmacro

macro unknown1b(a)
	dw $001B, <a>
endmacro

macro unknown1c()
	dw $001C
endmacro

namespace krow

org $B6F9CD

%unknown1a($003C, $0200)
%unknown5($0201, $025D)
%unknown1a($003C, $0201)
%unknown5($0200, $0000)
%goto_if($FAC7)	;pattern2
%unknown13()
%unknown0($01B0, $0130, $0003)
%unknown4($2000)
%unknown0($01B0, $0158, $0002)
%unknown18()
%unknown6()
%unknown0($01B0, $0115, $0002)
%unknown1c()
%unknown4($3000)
%unknown1b($3000)
%unknown9()
%unknownc($0000)
%unknowna()
%unknown12($FFFF, $0001, $0001)
%unknown1a($0014, $0200)
%unknown7($0000)
%unknown8($0200)
%unknown1a($0032, $0200)
%unknown0($025D, $017F, $0002)
%unknown0($025E, $018D, $0002)
%unknown5($0200, $0000)
%unknown0($025E, $0199, $0002)
%unknown0($025E, $01B4, $0003)
%unknown0($025E, $01CD, $0003)
%unknown5($0201, $0000)
%unknown0($0250, $01D2, $0003)
%unknown0($0240, $01D5, $0003)
%unknown0($0230, $01D7, $0003)
%unknown0($0204, $01D8, $0003)
%unknown0($015C, $01D8, $0003)
%unknown0($0147, $01D3, $0003)
%unknown0($0129, $01B9, $0002)
%unknown0($0119, $018C, $0002)
%unknown0($0115, $0157, $0002)
%unknown0($012B, $014B, $0002)
%unknown5($0200, $0000)
%goto(0)

pattern2:
%goto_if($F9E5)
%unknown13()
%unknown0($01B0, $0130, $0003)
%unknown1c()
%unknown4($2000)
%unknown0($01B0, $0158, $0002)
%unknown18()
%unknown6()
%unknown0($01B0, $0115, $0002)
%unknown4($3000)
%unknown1b($3000)
%unknown9()
%unknownc($0000)
%unknowna()
%unknown12($0001, $0001, $0001)
%unknown1a($0014, $0200)
%unknown7($0001)
%unknown8($0200)
%unknown1a($0032, $0200)
%unknown0($0123, $017F, $0002)
%unknown0($0122, $018D, $0002)
%unknown5($0200, $0000)
%unknown0($0122, $0199, $0002)
%unknown0($0122, $01B4, $0003)
%unknown0($0122, $01CD, $0003)
%unknown5($0201, $0000)
%unknown0($0130, $01D2, $0003)
%unknown0($0140, $01D5, $0003)
%unknown0($0150, $01D7, $0003)
%unknown0($017C, $01D8, $0003)
%unknown0($0224, $01D8, $0003)
%unknown0($0239, $01D3, $0003)
%unknown0($0257, $01B9, $0002)
%unknown0($0267, $018C, $0002)
%unknown0($026B, $0157, $0002)
%unknown0($0255, $014B, $0002)
%unknown5($0200, $0000)
%goto(0)

%unknown13()
%unknown0($01B0, $0162, $0002)
%unknown1c()
%unknown0($0200, $0162, $0001)
%unknown0($0206, $0164, $0001)
%unknown0($0210, $0167, $0002)
%unknown0($0225, $0176, $0002)
%unknown0($022A, $017C, $0002)
%unknown0($022D, $0181, $0002)
%unknown0($022A, $0184, $0002)
%unknown0($0225, $018B, $0002)
%unknown0($0210, $0199, $0003)
%unknown0($0206, $019D, $0003)
%unknown0($0200, $019F, $0003)
%unknown0($01D3, $019F, $0004)
%goto_if($FC4D)
%unknownb($1000, $0400)
%unknown15($FFEC, $FFEC)
%unknown16()
%unknown5($0200, $0209)
%unknowne()
%unknown10()
%unknown0($01F0, $019F, $0002)
%unknown0($0200, $019F, $0001)
%unknown11()
%unknownf($0200)
%unknown19($AF04, $AF34)
%unknown0($01B0, $019F, $0002)
%unknown0($0160, $019F, $0002)
%unknown0($0157, $019D, $0002)
%unknown0($014D, $0199, $0002)
%unknown0($0138, $018B, $0002)
%unknown0($0133, $0184, $0002)
%unknown0($0130, $0181, $0002)
%unknown0($0133, $017C, $0002)
%unknown0($0138, $0176, $0002)
%unknown0($014D, $0167, $0002)
%unknown0($0157, $0164, $0002)
%unknown0($0160, $0162, $0002)
%unknown0($01B0, $0162, $0002)
%unknown0($0200, $0162, $0002)
%unknown0($0206, $0164, $0002)
%unknown0($0210, $0167, $0002)
%unknown0($0225, $0176, $0002)
%unknown0($022A, $017C, $0002)
%unknown0($022D, $0181, $0002)
%unknown0($022A, $0184, $0002)
%unknown0($0225, $018B, $0002)
%unknown0($0210, $0199, $0002)
%unknown0($0206, $019D, $0002)
%unknown0($0200, $019F, $0002)
%goto(0)

%unknown13()
%unknown0($01B0, $0162, $0002)
%unknown1c()
%unknown0($0160, $0162, $0001)
%unknown0($0157, $0164, $0001)
%unknown0($014D, $0167, $0002)
%unknown0($0138, $0176, $0002)
%unknown0($0133, $017C, $0002)
%unknown0($0130, $0181, $0002)
%unknown0($0133, $0184, $0002)
%unknown0($0138, $018B, $0002)
%unknown0($014D, $0199, $0003)
%unknown0($0157, $019D, $0003)
%unknown0($0160, $019F, $0003)
%unknown0($018D, $019F, $0004)
%goto_if($FDB5)
%unknownb($1000, $0400)
%unknown15($0014, $FFEC)
%unknown16()
%unknown5($0200, $0209)
%unknowne()
%unknown10()
%unknown0($0170, $019F, $0002)
%unknown0($0160, $019F, $0001)
%unknown11()
%unknownf($0200)
%unknown19($AF04, $AF34)
%unknown0($0200, $019F, $0002)
%unknown0($0206, $019D, $0002)
%unknown0($0210, $0199, $0002)
%unknown0($0225, $018B, $0002)
%unknown0($022A, $0184, $0002)
%unknown0($022D, $0181, $0002)
%unknown0($022A, $017C, $0002)
%unknown0($0225, $0176, $0002)
%unknown0($0210, $0167, $0002)
%unknown0($0206, $0164, $0002)
%unknown0($0200, $0162, $0002)
%unknown0($01B0, $0162, $0002)
%unknown0($0160, $0162, $0002)
%unknown0($0157, $0164, $0002)
%unknown0($014D, $0167, $0002)
%unknown0($0138, $0176, $0002)
%unknown0($0133, $017C, $0002)
%unknown0($0130, $0181, $0002)
%unknown0($0133, $0184, $0002)
%unknown0($0138, $018B, $0002)
%unknown0($014D, $0199, $0002)
%unknown0($0157, $019D, $0002)
%unknown0($0160, $019F, $0002)
%unknown0($01B0, $019F, $0002)
%goto(0)

namespace off

;??? (LE)
;1400 A9FB 11FD
;%goto(33FA)
;15FB
;0500 0002 0402
;1400 E5F9 C7FA
;%goto(0)
;0500 0002 0402
;1400 A9FB 11FD
;1800

;02 00 00 00 02 00 00 00 02 00 00 00 02 00 00 00 FE FF 00 00 FE FF 00 00 FE FF 00 00 00 00 C9 FE E5 FE 01 FF 1D FF 0A 00 64 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 50 00 78 00 01 00 00 00 0A 00 64 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 78 00 B4 00 01 00 00 00 2C 01 50 00 50 00 02 00 00 00 0E 00 00 00 00 00 C8 00 08 00 00 00 00 00 02 00 02 00 68 01 50 00 50 00 01 00 00 00 0C 00 00 00 00 00 C8 00 0A 00 00 00 00 00 02 00 02 00 20 3D FF 6B 22 D8 FE BC 22 C0 FE BC 22 10 A3 B3 A0 36 10 22 32 84 BB A6 64 60 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
