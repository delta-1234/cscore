#闰年
![图 1](images/a437fb5303fe0ce5bb75a5b1dcfb07758dfbe7816c9b76a40479d373e1e205db.png)  

#矩阵转化
![图 2](images/db65a2c1b3f79bd884189e47c2400425d80d78c79f9edaf1b2882495ae184645.png)  

![图 3](images/a6d2c2ec9eb72540d8738501455f02f451a0b7365d45383d3c4907157e570426.png)  

#哈密顿回路
![图 4](images/2bfb3d644190237d497c45cce748e42cd44b70b491fbb1e274d80cbe0e0ff1d8.png)  

![图 5](images/5c1e0735562075dfeb1bd9c861ca08251e252570f01dcab0b9ff3c21eb84086f.png)  

![图 6](images/4cbb888529d14ab40e4d234e98bb8a18ab56a2a439ba9ce28a763f1ab8486c33.png)  

##参考C代码
```C
#include <stdio.h>
int G[8][8];    // 采用邻接矩阵存储图中的边
int book[8];    // 用于记录每个点是否已经走过
int m, n, ans;

void dfs(int x) {
    book[x] = 1;
    int flag = 1, i;
    // 判断是否经过了所有的点
    for (i = 0; i < n; i++) {
        flag &= book[i];
    }
    // 判断是否形成一条哈密顿回路
    if (flag && G[x][0]) {
        ans = 1;
        return;
    }
    // 搜索与之相邻且未经过的边
    for (i = 0; i < n; i++) {
        if (!book[i] && G[x][i]) {
            dfs(i);
        }
    }
    book[x] = 0;
}

int main() {
    scanf("%d%d", &n, &m);
    int i, x, y;
    for (i = 0; i < m; i++) {
        scanf("%d%d", &x, &y);
        G[x - 1][y - 1] = 1;
        G[y - 1][x - 1] = 1;
    }
    // 从第0个点（编号为1）开始深搜
    dfs(0);
    printf("%d", ans);
    return 0;
}
```