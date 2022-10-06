# CRC校验

![图 1](images/1f06297cba739ee2c25293db39ad18eefe480bde7d25b32665e02c3f1b3220f2.png)  

# GRF

![图 2](images/f0c039200fdb4dff927ebac2fcd21efb5e37b7acf320cc1fc2ce27781f046d67.png)  

![图 3](images/48b6ef12f81d3deb0e3cf417267e3cebf97b6ca659272cf7c89db02b9fab2d76.png)  

# ftoi（附加题）

![图 4](images/d5599c4b283e96fede3f238e003e66a06ce975ae9ba00b78b6833e776d872c4a.png)  

![图 5](images/84e5f74a27d08bb24e8edf389022b0ec2c4effedad855c904861f1ba834289d2.png)  

![图 6](images/ae41b53742fbdcc6b158ec053d82117d406d46534d6c2c448476114587a76f70.png)  

## 思路
此题看似复杂，但实际上分析过后，只有Normalized情况下整数部分才大于0，要注意E的计算过程中，exponent-011111为无符号减，最大值只有8，所以不用担心左移溢出。解决无符号减法，我采用的是异或后取反的方法。

# navigation

![图 7](images/dc26c207392bded7743039ac658edf4411ad3f8c1f9b5afdb3f48bb4ff9b3a0a.png)  

![图 8](images/ac1d95eff65552c323160f7bba5d542e1302de9f8f84251a1999a6156c6dd192.png)  

## 思路
为了避免过多的状态，我将其分两部分，一部分为位置状态，另一部分为撞墙判断，通过比较前后两个位置状态是否相等来判断是否撞墙。

# fsm

![图 9](images/02d43738e323e053e152665bc2b20b5a43d5f249c4c3dd154bd2917c334464b0.png)  

![图 10](images/3b146ac4507a81e96926a2e4cec3faa1cf008cb2d41db4c078e7328467107cd1.png)  

![图 11](images/00269cdbaaa78237267d4f4e11ac8ce86faecff4560eee6e4e442094b8bfc3ae.png)  

**注意Mealy和Moore的区别**