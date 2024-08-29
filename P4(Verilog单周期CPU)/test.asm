.data
arry:.space 4096

.text
jal next

end:
addi $t1,$0,1
add $s3,$s3,$t1
sll $t2,$t0,2
lui $1,0x00008f6f
ori $t3,$1,0x0000f3f9
sw $t3,arry($t2)
addi $t2,$t2,1
sb $s3,arry($t2)
addi $t2,$t2,1
addi $t0,$t0,1
lb $t3,arry($t2)
sll $t2,$t0,2
sw $t3,arry($t2)
addi $t0,$t0,1
beq $t1,$s3,end
j exit

next:
addi $s0,$0,10
addi $s1,$0,1
addi $t1,$0,0
addi $s2,$0,2
loop_1_begin:
    slt $t4,$t0,$s0
    beq $t4,$0,loop_1_end
    sll $t2,$t0,2
    lui $1,0x0000ffff
    ori $t3,$1,0x0000ffff
    sw $t3,arry($t2)
    add $t0,$t0,$s1
    sllv $t2,$t0,$s2
    sub $t3,$t2,$s1
    sw $t3,arry($t2)
    addi $t0,$t0,1
    j loop_1_begin
loop_1_end:
jr $ra
exit: