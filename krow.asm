;Written by H4v0c21
;Derived from https://github.com/FredYeye/Unveiled K. Rool Script
;Original asm file by FredYeye and emptysys
;7/8/21

math pri on : math round off : hirom

macro fly_to(x, y, speed)
	;makes krow fly to a specific location at a given speed
	dw $0000, <x>, <y>, <speed>
endmacro

macro goto(offset)
	;jumps to a specified command address
	;goto 0 is a special case and jumps to the current pattern's starting point
	dw $0002, <offset>
endmacro

macro krow_layer_priority(layer_value)
	;layer values:
	;$1000 below bg
	;$2000 below fg
	;$3000 above fg
	;sets which layers krow is drawn over
	dw $0004, <layer_value>
endmacro

macro animation(a, b)
	dw $0005, <a>, <b>
endmacro

macro grab_egg()
	;give krow an egg to drop
	dw $0006
endmacro

macro drop_egg(a)
	;drops the egg held by krow
	dw $0007, <a>
endmacro

macro wait_for_egg(a)
	dw $0008, <a>
endmacro

macro lock_camera()
	;prevents the camera from scrolling
	dw $0009
endmacro

macro unknowna()
	dw $000A
endmacro

macro shake_screen(a, b)
	;shakes the screen
	dw $000B, <a>, <b>
endmacro

macro fly_to_drop_location(speed)
	;makes krow fly to a drop location at a given speed (needs more research)
	dw $000C, <speed>
endmacro

macro goto_if(a)
	;jumps to a specified command address if a condition is met
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

macro face(direction, b, c)
	;faces krow in a direction. b and c are unknown
	;$FFFF face left
	;$0001 face right
	dw $0012, <direction>, <b>, <c>
endmacro

macro unknown13()
	;changes which side krow drops from?
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

macro wait(a, b)
	dw $001A, <a>, <b>
endmacro

macro egg_layer_priority(a)
	;sets which layers the egg carried by krow is drawn over
	dw $001B, <a>
endmacro

macro unknown1c()
	dw $001C
endmacro

namespace krow

org $B6F9CD

%wait($003C, $0200)
%animation($0201, $025D)
%wait($003C, $0201)
%animation($0200, $0000)
%goto_if(pattern2)	;pattern2
%unknown13()
%fly_to($01B0, $0130, $0003)
%krow_layer_priority($2000)
%fly_to($01B0, $0158, $0002)
%unknown18()
%grab_egg()
%fly_to($01B0, $0115, $0002)
%unknown1c()
%krow_layer_priority($3000)
%egg_layer_priority($3000)
%lock_camera()
%fly_to_drop_location($0000)
%unknowna()
%face($FFFF, $0001, $0001)
%wait($0014, $0200)
%drop_egg($0000)
%wait_for_egg($0200)
%wait($0032, $0200)
%fly_to($025D, $017F, $0002)
%fly_to($025E, $018D, $0002)
%animation($0200, $0000)
%fly_to($025E, $0199, $0002)
%fly_to($025E, $01B4, $0003)
%fly_to($025E, $01CD, $0003)
%animation($0201, $0000)
%fly_to($0250, $01D2, $0003)
%fly_to($0240, $01D5, $0003)
%fly_to($0230, $01D7, $0003)
%fly_to($0204, $01D8, $0003)
%fly_to($015C, $01D8, $0003)
%fly_to($0147, $01D3, $0003)
%fly_to($0129, $01B9, $0002)
%fly_to($0119, $018C, $0002)
%fly_to($0115, $0157, $0002)
%fly_to($012B, $014B, $0002)
%animation($0200, $0000)
%goto(0)

pattern2:
%goto_if($F9E5)
%unknown13()
%fly_to($01B0, $0130, $0003)
%unknown1c()
%krow_layer_priority($2000)
%fly_to($01B0, $0158, $0002)
%unknown18()
%grab_egg()
%fly_to($01B0, $0115, $0002)
%krow_layer_priority($3000)
%egg_layer_priority($3000)
%lock_camera()
%fly_to_drop_location($0000)
%unknowna()
%face($0001, $0001, $0001)
%wait($0014, $0200)
%drop_egg($0001)
%wait_for_egg($0200)
%wait($0032, $0200)
%fly_to($0123, $017F, $0002)
%fly_to($0122, $018D, $0002)
%animation($0200, $0000)
%fly_to($0122, $0199, $0002)
%fly_to($0122, $01B4, $0003)
%fly_to($0122, $01CD, $0003)
%animation($0201, $0000)
%fly_to($0130, $01D2, $0003)
%fly_to($0140, $01D5, $0003)
%fly_to($0150, $01D7, $0003)
%fly_to($017C, $01D8, $0003)
%fly_to($0224, $01D8, $0003)
%fly_to($0239, $01D3, $0003)
%fly_to($0257, $01B9, $0002)
%fly_to($0267, $018C, $0002)
%fly_to($026B, $0157, $0002)
%fly_to($0255, $014B, $0002)
%animation($0200, $0000)
%goto(0)

%unknown13()
%fly_to($01B0, $0162, $0002)
%unknown1c()
%fly_to($0200, $0162, $0001)
%fly_to($0206, $0164, $0001)
%fly_to($0210, $0167, $0002)
%fly_to($0225, $0176, $0002)
%fly_to($022A, $017C, $0002)
%fly_to($022D, $0181, $0002)
%fly_to($022A, $0184, $0002)
%fly_to($0225, $018B, $0002)
%fly_to($0210, $0199, $0003)
%fly_to($0206, $019D, $0003)
%fly_to($0200, $019F, $0003)
%fly_to($01D3, $019F, $0004)
%goto_if($FC4D)
%shake_screen($1000, $0400)
%unknown15($FFEC, $FFEC)
%unknown16()
%animation($0200, $0209)
%unknowne()
%unknown10()
%fly_to($01F0, $019F, $0002)
%fly_to($0200, $019F, $0001)
%unknown11()
%unknownf($0200)
%unknown19($AF04, $AF34)
%fly_to($01B0, $019F, $0002)
%fly_to($0160, $019F, $0002)
%fly_to($0157, $019D, $0002)
%fly_to($014D, $0199, $0002)
%fly_to($0138, $018B, $0002)
%fly_to($0133, $0184, $0002)
%fly_to($0130, $0181, $0002)
%fly_to($0133, $017C, $0002)
%fly_to($0138, $0176, $0002)
%fly_to($014D, $0167, $0002)
%fly_to($0157, $0164, $0002)
%fly_to($0160, $0162, $0002)
%fly_to($01B0, $0162, $0002)
%fly_to($0200, $0162, $0002)
%fly_to($0206, $0164, $0002)
%fly_to($0210, $0167, $0002)
%fly_to($0225, $0176, $0002)
%fly_to($022A, $017C, $0002)
%fly_to($022D, $0181, $0002)
%fly_to($022A, $0184, $0002)
%fly_to($0225, $018B, $0002)
%fly_to($0210, $0199, $0002)
%fly_to($0206, $019D, $0002)
%fly_to($0200, $019F, $0002)
%goto(0)

%unknown13()
%fly_to($01B0, $0162, $0002)
%unknown1c()
%fly_to($0160, $0162, $0001)
%fly_to($0157, $0164, $0001)
%fly_to($014D, $0167, $0002)
%fly_to($0138, $0176, $0002)
%fly_to($0133, $017C, $0002)
%fly_to($0130, $0181, $0002)
%fly_to($0133, $0184, $0002)
%fly_to($0138, $018B, $0002)
%fly_to($014D, $0199, $0003)
%fly_to($0157, $019D, $0003)
%fly_to($0160, $019F, $0003)
%fly_to($018D, $019F, $0004)
%goto_if($FDB5)
%shake_screen($1000, $0400)
%unknown15($0014, $FFEC)
%unknown16()
%animation($0200, $0209)
%unknowne()
%unknown10()
%fly_to($0170, $019F, $0002)
%fly_to($0160, $019F, $0001)
%unknown11()
%unknownf($0200)
%unknown19($AF04, $AF34)
%fly_to($0200, $019F, $0002)
%fly_to($0206, $019D, $0002)
%fly_to($0210, $0199, $0002)
%fly_to($0225, $018B, $0002)
%fly_to($022A, $0184, $0002)
%fly_to($022D, $0181, $0002)
%fly_to($022A, $017C, $0002)
%fly_to($0225, $0176, $0002)
%fly_to($0210, $0167, $0002)
%fly_to($0206, $0164, $0002)
%fly_to($0200, $0162, $0002)
%fly_to($01B0, $0162, $0002)
%fly_to($0160, $0162, $0002)
%fly_to($0157, $0164, $0002)
%fly_to($014D, $0167, $0002)
%fly_to($0138, $0176, $0002)
%fly_to($0133, $017C, $0002)
%fly_to($0130, $0181, $0002)
%fly_to($0133, $0184, $0002)
%fly_to($0138, $018B, $0002)
%fly_to($014D, $0199, $0002)
%fly_to($0157, $019D, $0002)
%fly_to($0160, $019F, $0002)
%fly_to($01B0, $019F, $0002)
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
