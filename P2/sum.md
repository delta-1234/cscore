# 阶乘连加

## 具体要求

- 输出格式：

  - 输入只包含1行，有1个正整数n

- 数据结构：
  
  - `0<n<100`

- 功能要求
  
  - 输出从1到n的阶乘的连加，即$$\sum_{i=1}^{n} i!$$
  - 由于位数太多，只要求输出这个数的后32位所代表的无符号十进制数，只输出1行
  
- 提示
  
  - 输出无符号数不能使用常见的1号syscall，请查阅帮助文档寻找输出无符号数的syscall号
  
## 解题思路

```C
#include<stdio.h>
int main()
{
	unsigned s=1,sum=0;
	int n,i;
	scanf("%d",&n);
	for(i=1;i<=n;i++)
	{
		s*=i;
		sum+=s;
	}
	printf("%u",sum);
}
```

## MIPS代码

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
```