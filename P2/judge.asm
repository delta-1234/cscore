.macro exit
li $v0,10
syscall
.end_macro

.macro scanInt(%d)
li $v0,5
syscall
move %d,$v0
.end_macro

.macro scanChar(%c)
li $v0,12
syscall
move %c,$v0
.end_macro

.macro printInt(%d)
move $a0,%d
li $v0,1
syscall
.end_macro

.data
str: .space 40

.text
scanInt($s0)
li $s1,0#flag
li $t0,0#i
loop_1_begin:
	beq $t0,$s0,loop_1_end
	scanChar($t1)
	sb $t1,str($t0)
	addi $t0,$t0,1
	j loop_1_begin
loop_1_end:

li $t0,0
loop_2_begin:
	beq $t0,$s0,loop_2_end
	lb $t1,str($t0)
	sub $t2,$s0,$t0
	subi $t2,$t2,1
	lb $t3,str($t2)
	addi $t0,$t0,1
	beq $t1,$t3,loop_2_begin
	li $s1,0
	printInt($s1)
	exit
loop_2_end:
li $s1,1
printInt($s1)
exit




