.macro exit
li $v0,10
syscall
.end_macro

.macro scanInt(%d)
li $v0,5
syscall
move %d,$v0
.end_macro

.macro printInt(%d)
move $a0,%d
li $v0,1
syscall
.end_macro

.data
str:.space 4000

.text
scanInt($s0)#n
addi $s0,$s0,1#n=n+1方便接下来的比较
li $s1,10#常数10
li $t0,1#i
li $t1,0#j
li $t2,1#num
li $t3,0#b
li $t4,0#c
sw $t2,str($0)#str[0]=1
loop_1_begin:
	beq $t0,$s0,loop_1_end
	li $t4,0
	li $t1,0
	loop_2_begin:
		sub $t3,$t1,$t2
		bgez $t3,or
		sll $t5,$t1,2
		lw $t3,str($t5)
		mult $t3,$t0
		mflo $t3
		add $t3,$t3,$t4#b=str[j]*i+c
		divu $t3,$s1
		mfhi $t6#保存余数
		sw $t6,str($t5)#str[j]=b%10
		mflo $t4#c保存商
		addi $t1,$t1,1
		j loop_2_begin
		or:beqz $t4,loop_2_end
		sll $t5,$t1,2
		lw $t3,str($t5)
		mult $t3,$t0
		mflo $t3
		add $t3,$t3,$t4#b=str[j]*i+c
		divu $t3,$s1
		mfhi $t6#保存余数
		sw $t6,str($t5)#str[j]=b%10
		mflo $t4#c保存商		
		addi $t1,$t1,1
		j loop_2_begin
	loop_2_end:	
	move $t2,$t1#num=j
	addi $t0,$t0,1
	j loop_1_begin
loop_1_end:

move $t0,$t2
subi $t0,$t0,1
loop_3_begin:
	bltz $t0,loop_3_end
	sll $t5,$t0,2
	lw $t6,str($t5)
	printInt($t6)
	subi $t0,$t0,1
	j loop_3_begin
loop_3_end:
exit



