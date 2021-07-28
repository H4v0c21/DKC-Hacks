;Edited by H4v0c21
;Derived from https://github.com/FredYeye/Unveiled K. Rool Script
;Original asm file by FredYeye and emptysys
;7/5/21

math pri on : math round off : hirom

;---------- k rool script macros

macro goto(offset)
	;jumps to specified offset/label
	;goto 0 is a special case and jumps to the current pattern's starting point
	dw $0002, <offset>
endmacro

macro wait(timer)
	;wait x amount of frames
	dw $0028, <timer>
endmacro

macro dash(speed, acceleration)
	;dash. speed is specified as a decimal number, with a decimal sign if desired
	;acceleration should be within 1-6
	dw $0029, <speed>*256, <acceleration>
endmacro

macro shoot()
	;shoot the current shot sequence
	dw $002A
endmacro

macro vacuum()
	;vacuum the player
	dw $002B
endmacro

macro retract_spikes()
	;retrack spikes of cannon ball
	dw $002C
endmacro

macro goto_if(offset)
	;goto offset if 0x0735 in RAM is clear. not sure what the purpose of this is yet
	dw $002D, <offset>
endmacro

macro spawn_item(item, x, y, sub, gas_x, gas_y)
	;spawn item. item is an offset to an item definition in bank FF.
	;x,y is the position
	;sub is a subroutine to call. should probably leave this as is
	;gas_x,gas_y is where the puff of smoke appears relative to the item
	dw $002E, <item>, <x>, <y>, <sub>, <gas_x>, <gas_y>
endmacro

macro shoot_red_gas()
	;shoots 3 red gas
	dw $002F
endmacro

macro clear_gas_effect()
	;clears gas effect on player
	dw $0030
endmacro

macro visibility(state) ;todo
	;$0000 = invisible
	;$1000 = transparent
	;$2000 = fully visible
	dw $0033, <state>
endmacro

macro teleport(player_distance)
	;teleports k. rool a certain distance from the player
	dw $0034, <player_distance>
endmacro

macro vacuum2(timer)
	;vacuums for a specific amount of time
	dw $0035, <timer>
endmacro

macro wait_if_gas_hit(timer)
	;wait x amount of frames if the player is affected by any of the 3 gas types
	dw $0036, <timer>
endmacro

macro fade(a, b, timer)
	;no idea what a and b are supposed to be. timer is how long each fade step takes
	dw $0037, <a>, <b>, <timer>
endmacro

macro disable_damage()
	;disables player damage when touching k. rool. note he can still melee the player
	dw $0038
endmacro

macro enable_damage()
	;re-enable player damage when touching k. rool
	dw $0039
endmacro

macro dk_intro(a, b, c, d, e, f)
	;has something to do with starting and stopping the intro cutscene. all parameters are unknown
	dw $0045, <a>, <b>, <c>, <d>, <e>, <f>
endmacro

macro melee_dk()
	;plays animation for k. rool beating dk during the intro cutscene
	dw $0046
endmacro

macro shoot_dk()
	;plays animation for k. rool shooting dk during the intro cutscene
	dw $0047
endmacro

macro todo48(a, b)
	dw $0048, <a>, <b>
endmacro

macro shoot_fish()
	;shoots fish
	dw $0049
endmacro

;---------- object defines

!DK_barrel = $2212
!cannonball = $1F86
!blue_gas = $1FBC
!red_gas = $1FCE
!purple_gas = $1FE0

;---------- k rool 1 script

namespace krool1

org $B6908D : script_1_entry: ;0x36908D
	%wait(100)
	%goto(pattern1)
	
	dw pattern1 ;leftover data?

intro: ;intro cutscene
	%dk_intro(3,0,0,0,0,0)
	%wait(60)
	%melee_dk()
	%wait(40)
	%melee_dk()
	%wait(40)
	%melee_dk()
	%wait(95)
	%shoot_dk()
	%wait(20)
	%shoot_dk()
	%wait(30)
	%shoot_dk()
	%wait(130)
	%dk_intro(2,0,0,0,0,0)

pattern1: ;1 cannonball
	%shoot()
	%wait(240)
	%dash(5.0, 3)
	%wait(50)
	%vacuum()
.loop:
	%wait(50)
	%shoot()
	%wait(80)
	%dash(5.0, 4)
	%wait(50)
	%vacuum()
	%goto(.loop)

	dw .loop ;leftover data?

pattern2: ;1 spiked cannon ball
	%wait(50)
	%shoot()
	%wait(120)
	%dash(5.0, 6)
	%wait(10)
	%dash(5.0, 6)
	%retract_spikes()
	%wait(50)
	%vacuum()
	%goto(0) ;pattern2

pattern3: ;2 spiked cannon balls
	%wait(60)
	%shoot()
	%wait(80)
	%dash(5.25, 6)
	%wait(10)
	%dash(5.25, 6)
	%wait(10)
	%dash(5.25, 6)
	%wait(40)
	%retract_spikes()
	%wait(80)
	%vacuum()
	%goto(0) ;pattern3

pattern4: ;straight spiked cannon balls
	%spawn_item(!DK_barrel, 456, 368, $ADB7, 0, -22)
.loop:
	%wait(80)
	%shoot()
	%wait(90)
	%goto_if(.loop)
	%vacuum()
	%goto(.loop)

	dw .loop ;leftover data?

pattern5: ;bouncing spiked cannon balls
	%wait(80)
	%dash(5.5, 6)
.loop:
	%wait(40)
	%shoot()
	%wait(140)
	%goto_if(.loop)
	%vacuum()
	%goto(.loop)

	dw .loop ;leftover data?

pattern6: ;orbiting spiked cannon balls
	%wait(40)
	%dash(5.75, 6)
.loop:
	%wait(40)
	%shoot()
	%wait(180)
	%goto_if(.loop)
	%vacuum()
	%goto(.loop)

	dw .loop ;leftover data?

pattern7: ;blue gas
	%spawn_item(!DK_barrel, 456, 368, $ADB7, 0, -22)
	%wait(50)
	%dash(6.0, 6)
.loop:
	%wait(40)
	%shoot()
	%wait(90)
	%wait_if_gas_hit(120)
	%dash(1.5, 6)
	%wait(34)
	%visibility($1000) ;3691F7
	%dash(5.0, 6)
	%wait(34)
	%fade($AE5F, $AE6B, 7)
	%visibility($0000)
	%dash(5.0, 6)
	%spawn_item(!cannonball, 456, 449, $ADA8, 0, -14)
	%visibility($1000)
	%fade($AE6B, $AE7B, 7)
	%wait(40)
	%visibility($2000)
	%vacuum()
	%goto(.loop)

	dw .loop ;leftover data?

pattern8: ;red gas
	%wait(40)
	%dash(6.25, 6)
	%wait(40)
	%shoot_red_gas()
	%wait(150)
	%wait_if_gas_hit(120)
	%shoot()
	%wait(100)
	%spawn_item(!cannonball, 456, 449, $ADA8, 0, -14)
	%clear_gas_effect()
	%wait(50)
	%vacuum()
	%goto(0)
	
pattern9: ;purple gas
	%wait(40)
	%dash(6.5, 6)
	%wait(40)
	%shoot()
	%wait(340)
	%wait_if_gas_hit(120)
	%visibility($1000)
	%vacuum2(100)
	%fade($AE5F, $AE6B, 7)
	%disable_damage()
	%visibility($0000)
	%wait(60)
	%teleport(96)
	%visibility($1000)
	%fade($AE6B, $AE7B, 7)
	%enable_damage()
	%vacuum2(100)
	%fade($AE5F, $AE6B, 7)
	%disable_damage()
	%visibility($0000)
	%wait(80)
	%teleport(96)
	%visibility($1000)
	%fade($AE6B, $AE7B, 7)
	%enable_damage()
	%vacuum2(100)
	%fade($AE5F, $AE6B, 7)
	%disable_damage()
	%visibility($0000)
	%wait(80)
	%teleport(96)
	%visibility($1000)
	%fade($AE6B, $AE7B, 7)
	%enable_damage()
	%vacuum2(100)
	%spawn_item(!cannonball, 456, 449, $ADA8, 0, -14)
	%clear_gas_effect()
	%fade($AE5F, $AE6B, 7)
	%disable_damage()
	%visibility($0000)
	%wait(120)
	%teleport(96)
	%visibility($1000)
	%fade($AE6B, $AE7B, 7)
	%enable_damage()
	%wait(7)
	%visibility($2000)
	%vacuum2(100)
	%goto(0)
	
;---------- k rool 1 pattern locations

;org $B6C2F9 : dw pattern9, pattern8, pattern7, pattern6, pattern5, pattern4, pattern3, pattern2, pattern1

	
namespace off


;---------- k rool 2 script

namespace krool2

org $B69355 : script_2_entry: ;0x369355
	%wait(500)
	%wait(30)
	%shoot_fish()
	%wait(120)
.loop:
	%wait(120)
	%todo48($003A, $C3D0)
	%wait(150)
	%goto_if(.loop)
	%wait(75)
	%vacuum2(360)
	%goto(.loop)

	dw .loop

namespace off

;---------- k rool cannon backfire speed definitions

macro krool_speeds(a, b, c, d, e, f, g, h, i)
	dw <i>*256, <h>*256, <g>*256, <f>*256, <e>*256, <d>*256, <c>*256, <b>*256, <a>*256
endmacro

org $B69385 : %krool_speeds(2.5, 3.5, 3.8125, 4.125, 4.4375, 4.75, 5.0625, 5.375, 5.6875)



;---------- k rool 1 projectile counts

macro shot_counts(a, b, c, d, e, f, g, h, i)
	db <i>, <h>, <g>, <f>, <e>, <d>, <c>, <b>, <a>
endmacro

org $BAAD39 : %shot_counts(1, 1, 2, 10, 10, 10, 3, 3, 3)

;---------- k rool 1 projectiles

org $BAA7E4

dw $0200, $0000, $0200, $0000, $0000, $0000, $0078, $0000 ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0032, $0010 ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $003C, $FFF0 ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $0028, $0000 ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $0032, $0000 ;straight spike ball
dw $0380, $0000, $0380, $0000, $0000, $0000, $002C, $0010 ;straight spike ball
dw $0380, $0000, $0380, $0000, $0000, $0000, $002C, $FFF0 ;straight spike ball
dw $0380, $0000, $0380, $0000, $0000, $0000, $002C, $0010 ;straight spike ball
dw $0380, $0000, $0380, $0000, $0000, $0000, $0032, $FFF0 ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $003C, $0000 ;straight cannon ball barrel

dw $0200, $0000, $0200, $0400, $0000, $0005, $FC00, $0400, $0078 ;bouncing spike ball
dw $0200, $0000, $0200, $0400, $0000, $0004, $F880, $0780, $003C ;bouncing spike ball
dw $0200, $0000, $0200, $0400, $0000, $0005, $FC00, $0400, $003C ;bouncing spike ball
dw $0200, $0000, $0200, $0400, $0000, $0004, $F880, $0780, $003C ;bouncing spike ball
dw $0200, $0000, $0200, $0400, $0000, $0003, $F500, $0A00, $003A ;bouncing spike ball
dw $0200, $0000, $0200, $0400, $0000, $0004, $F880, $0780, $003A ;bouncing spike ball
dw $0200, $0000, $0200, $0400, $0000, $0003, $F500, $0A00, $0032 ;bouncing spike ball
dw $0200, $0000, $0200, $0400, $0000, $0004, $F880, $0780, $0032 ;bouncing spike ball
dw $0200, $0000, $0200, $0400, $0000, $0003, $F500, $0A00, $004B ;bouncing spike ball
dw $0200, $0000, $0200, $0400, $0000, $0004, $F880, $0780, $003C ;bouncing cannon ball barrel

dw $0100, $0000, $0100, $0000, $0909, $FC00, $1500, $00B4, $FFF6 ;orbiting spike ball
dw $0100, $0000, $0100, $0000, $0909, $FCC0, $2250, $00B4, $FFE8 ;orbiting spike ball
dw $0100, $0000, $0100, $0000, $0909, $FD80, $3000, $00B4, $FFDA ;orbiting spike ball
dw $0100, $0000, $0100, $0000, $0909, $FC00, $1500, $001C, $FFF6 ;orbiting spike ball
dw $0100, $0000, $0100, $0000, $0909, $FC00, $1500, $00B4, $FFF6 ;orbiting spike ball
dw $0100, $0000, $0100, $0000, $0909, $FCC0, $2250, $001A, $FFE8 ;orbiting spike ball
dw $0100, $0000, $0100, $0000, $0909, $FCC0, $2250, $00B4, $FFE8 ;orbiting spike ball
dw $0100, $0000, $0100, $0000, $0909, $FD80, $3000, $001E, $FFDA ;orbiting spike ball
dw $0100, $0000, $0100, $0000, $0909, $FD80, $3000, $00F0, $FFDA ;orbiting spike ball
dw $0100, $0000, $0100, $0000, $0909, $FC00, $1500, $00B4, $FFF6 ;orbiting cannon ball barrel

dw $0200, $0000, $0200, $0000, $0000, $0000, $0020, $0000 ;straight blue gas
dw $0200, $0000, $0200, $0000, $0000, $0000, $0020, $0000 ;straight blue gas
dw $0200, $0000, $0200, $0000, $0000, $0000, $0020, $0000 ;straight blue gas

dw $0280, $0000, $0280, $0900, $0000, $0006, $FA00, $0800, $001C ;bouncing red gas
dw $0280, $0000, $0280, $0900, $0000, $0006, $FA00, $0800, $001C ;bouncing red gas
dw $0280, $0000, $0280, $0900, $0000, $0006, $FA00, $0800, $001C ;bouncing red gas

dw $0200, $0000, $0200, $0000, $0000, $0000, $0039, $0000, $0014 ;straight spike ball
dw $0200, $0000, $0200, $0000, $0000, $0000, $0039, $0000, $0014 ;straight spike ball
dw $0200, $0000, $0200, $0000, $0000, $0000, $0039, $0000, $0014 ;straight spike ball

dw $0100, $0000, $0100, $0000, $0909, $FC80, $1500, $004B, $FFF6 ;orbiting purple gas
dw $0100, $0000, $0100, $0000, $0909, $FC80, $1500, $004B, $FFF6 ;orbiting purple gas
dw $0100, $0000, $0100, $0000, $0909, $FC80, $1500, $004B, $FFF6 ;orbiting purple gas

;---------- k rool 2 projectiles

org $BAC3D2

dw $0200, $0000, $0200, $0000, $0000, $0000, $0078, $0000, $95ED ;purple gas

dw $0280, $0000, $0280, $0000, $0000, $0000, $0046, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0041, $0000, $95ED ;straight spike ball
dw $02C0, $0000, $02C0, $0000, $0000, $0000, $003C, $0010, $95ED ;straight spike ball
dw $02C0, $0000, $02C0, $0000, $0000, $0000, $0037, $FFF0, $95ED ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $0032, $0010, $95ED ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $002D, $FFF0, $95ED ;straight spike ball
dw $0340, $0000, $0340, $0000, $0000, $0000, $0096, $0000, $99A8 ;straight spike ball

dw $0280, $0000, $0280, $0000, $0000, $0000, $0032, $000C, $99A8 ;straight purple gas
dw $0280, $0000, $0280, $0000, $0000, $0000, $0078, $FFF0, $95ED ;straight purple gas

dw $0300, $0000, $0300, $0000, $0000, $0000, $002D, $0010, $95ED ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $0028, $FFF0, $95ED ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $0028, $0010, $95ED ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $0023, $FFF0, $95ED ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $0023, $0010, $95ED ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $001E, $FFF0, $95ED ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $001B, $0010, $95ED ;straight spike ball
dw $0300, $0000, $0300, $0000, $0000, $0000, $0096, $FFF0, $99A8 ;straight spike ball

dw $0280, $0000, $0280, $0000, $0000, $0000, $002D, $0000, $99A8 ;straight purple gas
dw $0280, $0000, $0280, $0000, $0000, $0000, $002D, $0000, $99A8 ;straight purple gas
dw $0280, $0000, $0280, $0000, $0000, $0000, $0078, $0000, $95ED ;straight purple gas

dw $0280, $0000, $0280, $0000, $0000, $0000, $0032, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0028, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0028, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0023, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0023, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $001E, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $001E, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $00D2, $0000, $99A8 ;straight spike ball

dw $0180, $0000, $0180, $0000, $0000, $0000, $003C, $0000, $99A8 ;straight purple gas
dw $0380, $0000, $0380, $0000, $0000, $0000, $005A, $0000, $95ED ;straight purple gas

dw $01C0, $0000, $01C0, $0000, $0000, $0000, $002D, $0000, $95ED ;straight spike ball
dw $0480, $0000, $0480, $0000, $0000, $0000, $00A0, $0000, $95ED ;straight spike ball

dw $01A0, $0000, $01A0, $0000, $0000, $0000, $001E, $0000, $95ED ;straight spike ball
dw $0480, $0000, $0480, $0000, $0000, $0000, $002D, $0000, $95ED ;straight spike ball
dw $0480, $0000, $0480, $0000, $0000, $0000, $00A0, $0000, $95ED ;straight spike ball

dw $0180, $0000, $0180, $0000, $0000, $0000, $001E, $0000, $95ED ;straight spike ball
dw $0480, $0000, $0480, $0000, $0000, $0000, $002D, $0000, $95ED ;straight spike ball
dw $0480, $0000, $0480, $0000, $0000, $0000, $002D, $0000, $95ED ;straight spike ball
dw $0480, $0000, $0480, $0000, $0000, $0000, $00B4, $0000, $99A8 ;straight spike ball

dw $0280, $0000, $0280, $0000, $0000, $0000, $000F, $0010, $99A8 ;straight purple gas
dw $0280, $0000, $0280, $0000, $0000, $0000, $000F, $0000, $99A8 ;straight purple gas
dw $0280, $0000, $0280, $0000, $0000, $0000, $0078, $FFF0, $95ED ;straight purple gas

dw $0280, $0000, $0280, $0000, $0000, $0000, $0014, $0010, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0014, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0069, $FFF0, $95ED ;straight spike ball

dw $0280, $0000, $0280, $0000, $0000, $0000, $0014, $FFF0, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0014, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0069, $0010, $95ED ;straight spike ball

dw $0280, $0000, $0280, $0000, $0000, $0000, $0012, $0010, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0012, $0008, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0024, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0069, $FFF0, $95ED ;straight spike ball

dw $0280, $0000, $0280, $0000, $0000, $0000, $0012, $FFF0, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0012, $FFF8, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0024, $0000, $95ED ;straight spike ball
dw $0280, $0000, $0280, $0000, $0000, $0000, $0096, $0010, $95ED ;straight spike ball

dw $01C0, $0000, $01C0, $0000, $0000, $0000, $0258, $0000, $E820 ;straight cannon ball barrel
;----------
