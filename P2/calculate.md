# 字符统计

## 具体要求

- 首先读取字符个数数n（不超过100），然后再依次读取n个小写字母字符。
- 统计每个字符出现次数。
- 最终将计算出的结果输出，若干行，每行一个字符，一个数字，表示这个字符出现了多少次，没出现过的不输出，按照字符第一次出现顺序输出。
- 步数限制为100,000
- 请使用syscall结束程序
  
## 解题思路

没什么说的直接看C代码

```C
#include<stdio.h>
int num[26];
int order[26];
int main()
{
	char str;
	int n;
	scanf("%d ",&n);
	int i,j;
	for(i=0;i<26;i++)
	order[i]=-1;
	for(i=0,j=0;i<n;i++)
	{
		scanf("%c",&str);
		getchar();
		if(num[str-'a']==0)
		{
			order[j]=str-'a';
			j++;
		}
		num[str-'a']++;
	}
	for(i=0;i<26;i++)
	{
		if(order[i]!=-1)
		{
			printf("%c",order[i]+'a');
			printf(" %d\n",num[order[i]]);
		}
	}
}
```

## MIPS

```mips
.macro exit
li $v0,10
syscall
.end_macro

.macro scanInt(%d)
li $v0,5
syscall
move %d,$v0
.end_macro

.macro scanChar(%s)
li $v0,12
syscall
move %s,$v0
.end_macro

.macro printInt(%d)
move $a0,%d
li $v0,1
syscall
.end_macro

.macro printChar(%s)
move $a0,%s
li $v0,11
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

.data
num: .space 104
order: .space 104
space: .asciiz " "
enter: .asciiz "\n"

.text
li $s0,0#n
scanInt($s0)
li $t1,0#str
li $t0,0#i=0
li $s1,26
li $s2,-1
loop_0_begin:
	beq $t0,$s1,loop_0_end
	sll $t2,$t0,2
	sw $s2,order($t2)
	addi $t0,$t0,1
	j loop_0_begin
loop_0_end:

li $t0,0#i=0
li $t3,0#j=0
loop_1_begin:
	beq $t0,$s0,loop_1_end
	scanChar($t1)
	subi $t1,$t1,97#str-'a'
	sll $t2,$t1,2
	lw $t4,num($t2)#num[str-'a']
	bne $t4,$0,else1
	sll $t5,$t3,2
	sw $t1,order($t5)#order[j]=str-'a'
	addi $t3,$t3,1
	else1:
	lw $t4,num($t2)
	addi $t4,$t4,1
	sw $t4,num($t2)
	addi $t0,$t0,1
	j loop_1_begin
loop_1_end:

li $t0,0
loop_2_begin:
	beq $t0,$s1,loop_2_end
	sll $t1,$t0,2
	lw $t2,order($t1)#order[i]
	beq $t2,$s2,else
	addi $t3,$t2,97
	sll $t2,$t2,2
	lw $t4,num($t2)
	printChar($t3)
	printSpace
	printInt($t4)
	printEnter
	else:
	addi $t0,$t0,1
	j loop_2_begin
loop_2_end:
exit
```
