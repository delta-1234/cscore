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

.macro printStr(%str)
la $a0,%str
li $v0,4
syscall
.end_macro

.macro push(%src)
sw %src, 0($sp)
subi $sp, $sp, 4
.end_macro

.macro pop(%des)
addi $sp, $sp, 4
lw %des, 0($sp) 
.end_macro

.macro cal(%ans,%a,%b)
mult %a,$s0
mflo %ans
add %ans,%ans,%b
sll %ans,%ans,2
.end_macro

.data
G:.space 256#G[8][8]
book:.space 32#book[8]

.text
#main
scanInt($s0)#将n存在s0中
scanInt($s1)#将m存在s1中
li $t0,0#t0为循环变量i
li $t1,0#t1为x
li $t2,0#t2为y
li $s2,1#存常数1
loop_begin:
	beq $t0,$s1,loop_end
	scanInt($t1)
	scanInt($t2)
	addi $t1,$t1,-1
	addi $t2,$t2,-1
	cal($t3,$t1,$t2)
	sw $s2,G($t3)#G[x-1][y-1]=1
	cal($t3,$t2,$t1)
	sw $s2,G($t3)#G[y-1][x-1]=1
	addi $t0,$t0,1
	j loop_begin
loop_end:
#dfs(0)
li $v0,0#初始化v0
li $t0,0#初始化t0
li $a0,0#传参
jal dfs
move $s3,$v0
#输出
printInt($s3)
exit
#main结束

dfs:
	#入栈
	push($ra)
	push($t0)
	#传参
	move $t0,$a0
	sll $t1,$t0,2
	sw $s2,book($t1)#book[x]=1
	li $t1,1#flag
	li $t2,0#i
	loop_1_begin:
		beq $t2,$s0,loop_1_end
		sll $t4,$t2,2
		lw $t3,book($t4)#取出book[i]
		and $t1,$t1,$t3
		addi $t2,$t2,1
		j loop_1_begin
	loop_1_end:
	if:
		beq $t1,$0,if_else
		cal($t3,$t0,$0)
		lw $t4,G($t3)
		beq $t4,$0,if_else
		li $v0,1#ans=1
	if_else:
		li $t2,0#i=0
		loop_2_begin:
			beq $t2,$s0,loop_2_end
			if2:
				sll $t4,$t2,2
				lw $t3,book($t4)#book[i]
				beq $t3,$s2,if2_else
				cal($t3,$t0,$t2)
				lw $t4,G($t3)#G[x][i]
				beq $t4,$0,if2_else
				push($t2)
				#dfs[i]
				move $a0,$t2
				jal dfs
				#恢复循环参数
				pop($t2)
				addi $t2,$t2,1
				j loop_2_begin
			if2_else:
				addi $t2,$t2,1
				j loop_2_begin
		loop_2_end:
		sll $t1,$t0,2
		sw $0,book($t1)#book[x]=0
		pop($t0)
		pop($ra)
		jr $ra
end_dfs:
	








