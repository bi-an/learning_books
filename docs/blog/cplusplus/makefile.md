# Makefile笔记

## makefile同名目标处理方式：

参考
* [链接](https://blog.csdn.net/lixiangminghate/article/details/50448664)
* [链接](https://stackoverflow.com/questions/43718595/two-targets-with-the-same-name-in-a-makefile)

[makefile将命令结果赋值给变量](https://stackoverflow.com/questions/2019989/how-to-assign-the-output-of-a-command-to-a-makefile-variable)

# Makefile中短划线

    all:
    	-/bin/rm -rf *.log

其中，`-/bin/rm`的短划线（`-`）是一个特殊前缀，表示忽略命令执行过程的错误。