	org 0
	jmp start
	
	org 3
	jmp mirror
	
	org 30h
start:	mov sp, #0FAH
	clr it0
	clr it1
	setb ie.0
	setb ex1
	setb ea

	;обычные цифры
	mov 30h,#11000000b ;0
	mov 31h,#11111001b ;1
	mov 32h,#10100100b ;2
	mov 33h,#10110000b ;3
	mov 34h,#10011001b ;4
	mov 35h,#10010010b ;5
	mov 36h,#10000010b ;6
	mov 37h,#11111000b ;7
	mov 38h,#10000000b ;8
	mov 39h,#10010000b ;9
	mov 3ah,#10001000b ;a
	mov 3bh,#10000011b ;b
	mov 3ch,#11000110b ;c
	mov 3dh,#10100001b ;d

	;отзеркаленные цифры
	mov 40h,#11000000b ;0
	mov 41h,#11001111b ;1
	mov 42h,#10010010b ;2
	mov 43h,#10000110b ;3
	mov 44h,#10001101b ;4
	mov 45h,#10100100b ;5
	mov 46h,#10100000b ;6
	mov 47h,#11001110b ;7
	mov 48h,#10000000b ;8
	mov 49h,#10000100b ;9
	mov 4ah,#10001000b ;a
	mov 4bh,#10000011b ;b
	mov 4ch,#11000110b ;c
	mov 4dh,#10100001b ;d

	clr f0
	mov 60h,#0
	mov r4, #5

	;обработка нажатий матричной клавиатуры
keypad:	djnz r4, keypad
	mov p1, #11101111b
	mov a, p1
	jnb acc.0, kn1
	jnb acc.1, kn4
	jnb acc.2, kn7

	mov p1,#11011111b
	mov a,p1
	jnb acc.0, kn2
	jnb acc.1, kn5
	jnb acc.2, kn8
	jnb acc.3, kn0

	mov p1,#10111111b
	mov a,p1
	jnb acc.0, kn3
	jnb acc.1, kn6
	jnb acc.2, kn9

	mov p1, #01111111b
	mov a, p1
	jnb acc.0, knA
	jnb acc.1, knB
	jnb acc.2, knC
	jnb acc.3, knD

	mov r4, #5
	
	jmp keypad

kn0:	mov r2,#0
	jmp print1

kn1:	mov r2, #1
	jmp print1

kn2:	mov r2, #2
	jmp print1

kn3:	mov r2,#3
	jmp print1

kn4:	mov r2, #4
	jmp print1

kn5:	mov r2, #5
	jmp print1

kn6:	mov r2, #6
	jmp print1

kn7:	mov r2, #7
	jmp print1

kn8:	mov r2, #8
	jmp print1

kn9:	mov r2, #9
	jmp print1

knA:	mov r2, #0Ah
	jmp print1

knB:	mov r2, #0Bh
	jmp print1

knC:	mov r2, #0Ch
	jmp print1

knD:	mov r2, #0Dh
	jmp print1

print1:	mov r4, #5
	jnb f0, print2
	mov p0, 60h
	mov a, r2
	add a, #30h
	mov r0, a
	mov p2, @r0
	clr f0
	jmp keypad

print2:	mov a, r2
	xch a,r3
	mov a, r2
	add a, #30h
	mov r0, a
	mov p2, @r0
	mov 60h, @r0
	setb f0
	jmp keypad


mirror:	push psw
	push acc
	mov r7, #5

wts:	nop
	djnz r7, wts
	jb p3.2, i_end
	mov a,r2
	add a,#40h
	mov r0,a
	mov p0,@r0
	mov a,r3
	add a,#40h
	mov r1,a
	mov p2,@r1

i_end:	pop acc
	pop psw
	clr ie0
	reti
	end