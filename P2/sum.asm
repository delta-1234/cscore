.macro exit
li $v0,10
syscall
.end_macro

.macro scanInt(%d)
li $v0,5
syscall
move %d,$v0
.end_macro

.text
li $s0,0#sum
li $s1,0#n
li $t0,1#i
li $t1,1#s
scanInt($s1)
addi $s1,$s1,1
loop_begin:
	beq $t0,$s1,loop_end
	multu $t1,$t0
	mflo $t1
	addu $s0,$s0,$t1
	addi $t0,$t0,1
	j loop_begin
loop_end:
move $a0,$s0
li $v0,36
syscall
exit

