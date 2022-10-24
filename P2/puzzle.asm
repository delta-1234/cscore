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

.macro push(%src)
sw %src,0($sp)
subiu $sp,$sp,4
.end_macro

.macro pop(%des)
addi $sp, $sp, 4
lw %des, 0($sp) 
.end_macro

.macro cal(%s,%i,%j,%m)
mult %i,%m
mflo %s
add %s,%s,%j
sll %s,%s,2
.end_macro

.data
map:.space 400
visit:.space 400

.text
li $s0,0#way_count
li $s1,0#start_i
li $s2,0#start_j
li $s3,0#end_i
li $s4,0#end_j
li $s5,0#n
li $s6,0#m

#main
scanInt($s5)
scanInt($s6)
addi $t5,$s5,1#n+1方便比较
addi $t6,$s6,1#m+1方便比较
addi $s7,$s6,2#保存一行元素个数
li $t0,1#i=1
loop_1_begin:
	beq $t0,$t5,loop_1_end#i<=n
	li $t1,1#j=1
	loop_2_begin:
		beq $t1,$t6,loop_2_end
		scanInt($t2)
		cal($t3,$t0,$t1,$s7)#注意因为从1开始存，最后有一个初始化1，所以一行有m+2个元素
		sw $t2,map($t3)#scanf(" %d", &map[i][j])
		addi $t1,$t1,1
		j loop_2_begin
	loop_2_end:
	addi $t0,$t0,1
	j loop_1_begin
loop_1_end:

li $t1,0#j=0
addi $t6,$s6,2#m+2方便比较
addi $t5,$s5,1#n+1
li $t3,1#常数1
loop_3_begin:
	beq $t1,$t6,loop_3_end
	cal($t2,$0,$t1,$s7)
	sw $t3,map($t2)#map[0][j] = 1
	cal($t2,$t5,$t1,$s7)
	sw $t3,map($t2)#map[n + 1][j] = 1
	addi $t1,$t1,1
	j loop_3_begin
loop_3_end:

li $t0,0
addi $t5,$s5,2
addi $t6,$s6,1
loop_4_begin:
	beq $t0,$t5,loop_4_end
	cal($t2,$t0,$0,$s7)
	sw $t3,map($t2)#map[i][0] = 1
	cal($t2,$t0,$t6,$s7)
	sw $t3,map($t2)#map[i][m + 1] = 1
	addi $t0,$t0,1
	j loop_4_begin
loop_4_end:

scanInt($s1)
scanInt($s2)
scanInt($s3)
scanInt($s4)
cal($t2,$s1,$s2,$s7)
sw $t3,visit($t2)#visit[start_i][start_j] = 1
move $a0,$s1#传参
move $a1,$s2#传参
jal DFS#调用函数
printInt($s0)
exit
#main结束

DFS:
push($ra)#地址入栈
push($a0)#参数入栈
push($a1)
if:
bne $a0,$s3,else
bne $a1,$s4,else
addi $s0,$s0,1#way_count++
pop($a1)
pop($a0)
pop($ra)
jr $ra

else:
subi $t0,$a0,1
cal($t1,$t0,$a1,$s7)
lw $t2,map($t1)
lw $t3,visit($t1)
if1:
	bne $t2,$0,if2
	bne $t3,$0,if2
	li $t4,1
	sw $t4,visit($t1)
	push($t1)
	subi $a0,$a0,1
	jal DFS
	addi $a0,$a0,1
	pop($t1)
	sw $0,visit($t1)

if2:
	addi $t0,$a0,1
	cal($t1,$t0,$a1,$s7)
	lw $t2,map($t1)
	lw $t3,visit($t1)
	bne $t2,$0,if3
	bne $t3,$0,if3
	li $t4,1
	sw $t4,visit($t1)
	push($t1)
	addi $a0,$a0,1
	jal DFS
	subi $a0,$a0,1
	pop($t1)
	sw $0,visit($t1)

if3:
	subi $t0,$a1,1
	cal($t1,$a0,$t0,$s7)
	lw $t2,map($t1)
	lw $t3,visit($t1)
	bne $t2,$0,if4
	bne $t3,$0,if4
	li $t4,1
	sw $t4,visit($t1)
	push($t1)
	subi $a1,$a1,1
	jal DFS
	addi $a1,$a1,1
	pop($t1)
	sw $0,visit($t1)

if4:
	addi $t0,$a1,1
	cal($t1,$a0,$t0,$s7)
	lw $t2,map($t1)
	lw $t3,visit($t1)
	bne $t2,$0,end
	bne $t3,$0,end
	li $t4,1
	sw $t4,visit($t1)
	push($t1)
	addi $a1,$a1,1
	jal DFS
	subi $a1,$a1,1
	pop($t1)
	sw $0,visit($t1)

end:
pop($a1)
pop($a0)
pop($ra)
jr $ra
#DFS结束

