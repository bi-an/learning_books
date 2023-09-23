# 写Makefiles

> 原文链接：[第3章 写Makefiles](https://www.gnu.org/software/make/manual/html_node/Makefiles.html)

## Makefiles包含什么

Makefile包含5种成分：显式规则（explicit rules）、隐式规则（implicit rules）、变量定义（variable definitions）、指令（directives）、注释（comments）。

    注意：在引用变量或调用函数时，要注意空格。

```makefile
#abc后面有两个空格
#所以变量var的内容是"abc  "
var=abc  
#var2之后、'#'符号之前，有3个空格
#var2的内容是"abc   "
var2=abc   #之后是注释
```


## 给你的Makfile起什么名字

默认情况下，make通过以下顺序查找makefile文件，只执行找到的第一个makefile：

    GNUmakefile， makefile, Makefile

Tip: 要想构建整个project，或想要执行所有的makefiles，可以在makefiles中要求执行`make`命令。

```makefile
#This is GNUmakefile
all:
    make -f makefile
    make -f Makefile
    cd subdir; make;
```
