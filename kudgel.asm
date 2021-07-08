;Written by H4v0c21
;Derived from https://github.com/FredYeye/Unveiled K. Rool Script
;Original asm file by FredYeye and emptysys
;7/8/21

math pri on : math round off : hirom

macro goto(offset)
	;jumps to a specified command address
	;goto 0 is a special case and jumps to the current pattern's starting point
	dw $0002, <offset>
endmacro

macro unk1(a, b)
	dw $000B, <a>, <b>
endmacro

macro goto_if(a)
	;jumps to a specified command address if a condition is met
	dw $000D, <a>
endmacro

macro wait(timer)
	;wait x amount of frames
	dw $0028, <timer>
endmacro

macro spawn_item(item, x, y, sub, gas_x, gas_y)
	;spawn item. item is an offset to an item definition in bank FF.
	;x,y is the position
	;sub is a subroutine to call. should probably leave this as is
	;gas_x,gas_y is where the puff of smoke appears relative to the item
	dw $002E, <item>, <x>, <y>, <sub>, <gas_x>, <gas_y>
endmacro

macro fall(player_distance, delay, speeda, speedb, acceleration)
	;player_distance is the distance kudgel will fall relative to the player 0 makes him fall on top of the player
	;delay is how long to wait in frames before falling
	;speeda is the initial speed of kudgel when he falls
	;speedb is the final speed of kudgel when he falls
	;acceleration is the speed at which kudgel's speed transitions from a to b
	dw $003A, <player_distance>, <delay>, <speeda>, <speedb>, <acceleration>
endmacro

macro rise(height, speeda, speedb, acceleration)
	;height that kudgel will rise to
	;speeda is the initial speed of kudgel when he rises
	;speedb is the final speed of kudgel when he rises
	;acceleration is the speed at which kudgel's speed transitions from a to b
	dw $003B, <height>, <speeda>, <speedb>, <acceleration>
endmacro

macro melee()
	dw $003C
endmacro

macro stun_player(a)
	dw $003E, <a>
endmacro

macro unk3()
	dw $003F
endmacro

macro unk9(a, b, c)
	dw $0040, <a>, <b>, <c>
endmacro

macro unk5(a, b)
	dw $0041, <a>, <b>
endmacro

macro unk6()
	dw $0042
endmacro

macro unk7()
	dw $0043
endmacro

macro jump(a, speeda, speedb, acceleration)
	;speeda is the initial speed of kudgel when he jumps
	;speedb is the final speed of kudgel when he jumps
	;acceleration is the speed at which kudgel's speed transitions from a to b
	dw $0044, <a>, <speeda>, <speedb>, <acceleration>
endmacro

namespace kudgel

;objects
!tnt_barrel = $1D8A

org $B684D4

pattern1:
	%wait(60)
	%fall(464, 50, 1024, 2304, 6)
	%unk1(592, 4096)
	%wait(30)
	%melee()
	%wait(20)
	%rise(336, -2048, -1024, 3)
	%wait(30)
	.loop:
		%fall(0, 50, 1024, 1664, 6)
		%unk3()
		%unk1(592, 4096)
		%stun_player(7)
		%wait(20)
		%rise(336, -2048, -1024, 3)
		%wait(35)
		%fall(0, 50, 1024, 1664, 6)
		%unk1(592, 4096)
		%stun_player(7)
		%wait(20)
		%rise(336, -2048, -1024, 3)
		%wait(35)
		%fall(0, 50, 1024, 1664, 6)
		%unk1(592, 4096)
		%stun_player(7)
		%wait(45)
		%melee()
		%goto_if(pattern1_wait)
		%goto(phase_tnt_drop)
		dw phase_tnt_drop

pattern1_wait:
	%wait(1)
	%fall(448, 149, 1024, 1664, 6)
	%unk1(0, 1024)
	%unk6()
	%unk5($001E, $012C)
	%unk7()
	%rise(336, -2048, -1024, 3)
	%wait(35)
	%goto(pattern1_loop)
	dw pattern1_loop

pattern2:
	%rise(336, -2048, -1024, 3)
	%wait(15)
	.loop:
		%fall(0, 35, 1024, 1920, 6)
		%unk3()
		%unk1(592, 4096)
		%stun_player(7)
		%wait(20)
		%rise(336, -2048, -1024, 3)
		%wait(15)
		%fall(0, 35, 1024, 1920, 6)
		%unk1(592, 4096)
		%stun_player(7)
		%wait(20)
		%rise(336, -2048, -1024, 3)
		%wait(15)
		%fall(0, 35, 1024, 1920, 6)
		%unk1(592, 4096)
		%stun_player(7)
		%wait(25)
		%melee()
		%goto_if(pattern2_wait)
		%goto(phase_tnt_drop)
		dw phase_tnt_drop

pattern2_wait:
	%wait(1)
	%fall(448, 89, 1024, 1920, 6)
	%unk1(0, 1024)
	%unk6()
	%unk5(20, $00B4)
	%unk7()
	%rise(336, -2048, -1024, 3)
	%wait(15)
	%goto(pattern2_loop)
	dw pattern2_loop

pattern3:
	%rise(336, -2048, -1024, 3)
	%wait(2)
	.loop:
		%fall(0, 20, 1024, 2176, 6)
		%unk3()
		%unk1(592, 4096)
		%stun_player(7)
		%wait(20)
		%rise(336, -2048, -1024, 3)
		%wait(2)
		%fall(0, 20, 1024, 2176, 6)
		%unk1(592, 4096)
		%stun_player(7)
		%wait(20)
		%rise(336, -2048, -1024, 3)
		%wait(2)
		%fall(0, 20, 1024, 2176, 6)
		%unk1(592, 4096)
		%stun_player(7)
		%wait(10)
		%melee()
		%goto_if(pattern3_wait)
		%goto(phase_tnt_drop)
		dw phase_tnt_drop

pattern3_wait:
	%wait(1)
	%fall(448, 49, 1024, 2176, 6)
	%unk1(0, 1024)
	%unk6()
	%unk5(20, 120)
	%unk7()
	%rise(336, -2048, -1024, 3)
	%wait(2)
	%goto(pattern3_loop)
	dw pattern3_loop

pattern4:
	%rise(336, -2048, -1024, 3)
	%wait(2)
	.loop:
		%fall(0, 20, 1024, 2176, 6)
		%unk3()
		%unk1(592, 4096)
		%stun_player(7)
		%wait(20)
		%rise(336, -2048, -1024, 3)
		%wait($2)
		%fall(0, 20, 1024, 2176, 6)
		%unk1(592, 4096)
		%stun_player(7)
		%wait(20)
		%rise(336, -2048, -1024, 3)
		%wait(2)
		%fall(0, 20, 1024, 2176, 6)
		%unk1(592, 4096)
		%stun_player(7)
		%wait(10)
		%melee()
		%goto_if(pattern4_wait)
		%goto(phase_tnt_drop)
		dw phase_tnt_drop

pattern4_wait:
	%wait(1)
	%fall(448, 44, 1024, 2176, 6)
	%unk1(0, 1024)
	%unk6()
	%unk5(20, 120)
	%unk7()
	%rise(336, -2048, -1024, 3)
	%wait(2)
	%goto(pattern4_loop)
	dw pattern4_loop

pattern5:
	%rise(336, -2048, -1024, 3)
	%wait(18)
	.loop:
		%fall(0, 20, 1024, 2304, 6)
		%wait(20)
		%jump(384, -1792, 2048, 2)
		%unk3()
		%unk1(592, 4096)
		%stun_player(15)
		%wait(18)
		%jump(384, -1792, 2048, 2)
		%unk1(592, 4096)
		%stun_player(15)
		%wait(18)
		%jump(384, -1792, 2048, 2)
		%unk1(592, 4096)
		%stun_player(15)
		%goto_if(pattern5_wait)
		%goto(phase_tnt_drop)
		dw phase_tnt_drop

pattern5_wait:
	%wait(1)
	%fall(448, 59, 1536, 2304, 6)
	%unk1(592, 4096)
	%unk6()
	%unk5(20, 150)
	%unk7()
	%rise(336, -2048, -1024, 3)
	%wait(18)
	%goto(pattern5_loop)
	dw pattern5_loop

pattern6:
	%rise(336, -2048, -1024, 3)
	%wait(10)
	.loop:
		%fall(0, 20, 1024, 2304, 6)
		%wait(20)
		%jump(416, -2176, 3072, 2)
		%unk3()
		%unk1(592, 4096)
		%stun_player(15)
		%wait(10)
		%jump(416, -2176, 3072, 2)
		%unk1(592, 4096)
		%stun_player(15)
		%wait(10)
		%jump(416, -2176, 3072, 2)
		%unk1(592, 4096)
		%stun_player(15)
		%wait(10)
		%goto_if(pattern6_wait)
		%goto(phase_tnt_drop)
		dw phase_tnt_drop

pattern6_wait:
	%wait(1)
	%fall(448, 44, 1024, 2304, 6)
	%unk1(592, 4096)
	%unk6()
	%unk5(20, 120)
	%unk7()
	%rise(336, -2048, -1024, 3)
	%wait(10)
	%goto(pattern6_loop)
	dw $888C

pattern7:
	%rise(336, -2048, -1024, 3)
	%wait(10)
	.loop:
		%fall(0, 20, 1024, 2304, 6)
		%wait(20)
		%jump(448, -2560, 4352, 2)
		%unk3()
		%unk1(592, 4096)
		%stun_player(15)
		%wait(10)
		%jump(448, -2560, 4352, 2)
		%unk1(592, 4096)
		%stun_player(15)
		%wait(10)
		%jump(448, -2560, 4352, 2)
		%unk1(592, 4096)
		%stun_player(15)
		%wait(10)
		%goto_if(pattern7_wait)
		%goto(phase_tnt_drop)
		dw phase_tnt_drop

pattern7_wait:
	%wait(1)
	%fall(448, 29, 1024, 2304, 6)
	%unk1(592, 4096)
	%unk6()
	%unk5(20, 90)
	%unk7()
	%rise(336, -2048, -1024, 3)
	%wait(10)
	%goto(pattern7_loop)
	dw $8932

phase_tnt_drop:
	%unk9(-1792, 2048, 5)
	%unk1(0, 1024)
	%spawn_item(!tnt_barrel, 448, 384, $8D37, 0, -22)
	%wait(20)
	%rise(336, -2048, -1024, 3)
	%goto(0)

namespace off
