.macro exit
li $v0,10
syscall
.end_macro

.macro scan(%d)
li $v0,5
syscall
move %d,$v0
.end_macro

.macro printInt(%d)
move $a0,%d
li $v0,1
syscall
.end_macro

.macro printSpace
la $a0,space
li $v0,4
syscall
.end_macro

.macro printEnter
la $a0,enter
li $v0,4
syscall
.end_macro

.macro cal(%s,%i,%j,%n)
mult %i,%n
mflo %s
add %s,%s,%j
sll %s,%s,2
.end_macro

.data
m1 : .space 256#m1[8][8]
m2 : .space 256#m2[8][8]
m3 : .space 256#m3[8][8]结果矩阵
space : .asciiz " "
enter : .asciiz "\n"

.text
scan($s0)#s0存放n
li $t0,0#t0为i
li $t1,0#t1为j
loop_1_begin:
	beq $t0,$s0,loop_1_end
		loop_2_begin:
			beq $t1,$s0,loop_2_end
			scan($t2)
			cal($t3,$t0,$t1,$s0)
			sw $t2,m1($t3)
			addi $t1,$t1,1
			j loop_2_begin
		loop_2_end:
	li $t1,0
	addi $t0,$t0,1
	j loop_1_begin
loop_1_end:
li $t0,0#t0为i
li $t1,0#t1为j
loop_3_begin:
	beq $t0,$s0,loop_3_end
		loop_4_begin:
			beq $t1,$s0,loop_4_end
			scan($t2)
			cal($t3,$t0,$t1,$s0)
			sw $t2,m2($t3)
			addi $t1,$t1,1
			j loop_4_begin
		loop_4_end:
	li $t1,0
	addi $t0,$t0,1
	j loop_3_begin
loop_3_end:

li $t0,0#t0为i
li $t1,0#t1为j
li $t2,0#t2为k
li $t3,0#t3为sum
loop_5_begin:#for (i = 0; i < n; i++)
	beq $t0,$s0,loop_5_end#i<n
	li $t2,0#k=0
	loop_6_begin:#for(k=0;k<n;k++)
		beq $t2,$s0,loop_6_end#k<n
		li $t1,0#j=0
		loop_7_begin:#for (j = 0; j < n; j++)
			beq $t1,$s0,loop_7_end#j<n
			cal($t6,$t0,$t1,$s0)
			lw $t4,m1($t6)#读出m1[i][j]
			cal($t6,$t1,$t2,$s0)
			lw $t5,m2($t6)#读出m2[j][k]
			mult $t4,$t5
			mflo $t6
			add $t3,$t3,$t6#sum+=m1[i][j]*m2[j][k]
			addi $t1,$t1,1#j++
			j loop_7_begin
		loop_7_end:
		cal($t6,$t0,$t2,$s0)
		sw $t3,m3($t6)#m3[i][k]=sum
		li $t3,0#sum=0
		addi $t2,$t2,1#k++
		j loop_6_begin
	loop_6_end:
	addi $t0,$t0,1#i++
	j loop_5_begin
loop_5_end:

li $t0,0
li $t1,0
loop_8_begin:
	beq $t0,$s0,loop_8_end
	li $t1,0
	loop_9_begin:
		beq $t1,$s0,loop_9_end
		cal($t6,$t0,$t1,$s0)
		lw $t5,m3($t6)
		printInt($t5)
		printSpace
		addi $t1,$t1,1
		j loop_9_begin
	loop_9_end:
	addi $t0,$t0,1
	printEnter
	j loop_8_begin
loop_8_end:
exit





