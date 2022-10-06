.macro exit
li $v0,10
syscall
.end_macro

.macro scan
li $v0,5
syscall
.end_macro

.macro printInt(%d)
move $a0,%d
li $v0,1
syscall
.end_macro

.macro printStr(%str)
la $a0,%str
li $v0,4
syscall
.end_macro

.macro cal(%ans,%a,%b)
mult %a,$s1
mflo %ans
add %ans,%ans,%b
mult %ans,$s2
mflo %ans
.end_macro

.data
arry: .space 10000
space:.asciiz " "
enter:.asciiz "\n"
.text
input:
	li $s2,4
	scan
	move $s0,$v0#s0保存n
	scan
	move $s1,$v0#s1保存m
	li $t0,0#循环变量i（行）
	li $t1,0#循环变量j（列）
	loop_1_begin:
		beq $t0,$s0,loop_1_end#i==n时退出循环
		nop
		loop_2_begin:
			beq $t1,$s1,loop_2_end#j==m时退出循环
			nop
			scan#输入aij
			move $t2,$v0
			cal($t3,$t0,$t1)
			sw $t2,arry($t3)#存入数组
			addi $t1,$t1,1#j++
			j loop_2_begin
			nop
		loop_2_end:
		addi $t0,$t0,1#i++
		li $t1,0#j=0
		j loop_1_begin
		nop
	loop_1_end:

output:
	addi $t0,$s0,-1#i=n-1
	addi $t1,$s1,-1#j=m-1
	loop_3_begin:
		bltz $t0,loop_3_end#i<0跳转
		loop_4_begin:
			bltz $t1,loop_4_end#j<0跳转
			cal($t3,$t0,$t1)
			lw $t2,arry($t3)
			beq $t2,$0,if_else#aij==0跳转
			addi $t4,$t0,1
			addi $t5,$t1,1
			printInt($t4)
			printStr(space)
			printInt($t5)
			printStr(space)
			printInt($t2)
			printStr(enter)
			addi $t1,$t1,-1#j--
			j loop_4_begin
			nop
			if_else:
			addi $t1,$t1,-1#j--
			j loop_4_begin
			nop			
		loop_4_end:
		addi $t0,$t0,-1#i--
		addi $t1,$s1,-1#j=m-1
		j loop_3_begin
		nop
	loop_3_end:
exit			

