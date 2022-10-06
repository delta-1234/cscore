.text
li $v0,5
syscall#读入一个int整数n

move $s0,$v0#将整数n保存在s0寄存器
li $t0,100
li $t1,4
li $t2,400
div $s0,$t0#n/100
mfhi $t3#将余数保存在t3中
beq $t3,$0,if_else1#如果t3等于0，即n%100==0则跳转到if_else1
div $s0,$t1#n/4
mfhi $t3
beq $t3,$0,if_else2#如果t3等于0，即n%4==0且n%100！=0，则跳转到if_else2
li $a0,0#输出0，不是闰年
li $v0,1
syscall
li $v0,10
syscall#结束程序

if_else2:#即n%100!=0&&n%4==0
li $a0,1
li $v0,1
syscall#输出1，是闰年
li $v0,10
syscall#结束程序

if_else1:#n%100==0
div $s0,$t2#n/400
mfhi $t3
beq $t3,$0,if_else3#如果n%400==0跳转if_else3
li $a0,0#输出0，不是闰年
li $v0,1
syscall
li $v0,10
syscall#结束程序

if_else3:
li $a0,1
li $v0,1
syscall#输出1，是闰年
li $v0,10
syscall#结束程序
