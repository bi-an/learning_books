## makefile同名目标处理方式

参考：

* [链接](https://blog.csdn.net/lixiangminghate/article/details/50448664)
* [链接](https://stackoverflow.com/questions/43718595/two-targets-with-the-same-name-in-a-makefile)

[makefile将命令结果赋值给变量](https://stackoverflow.com/questions/2019989/how-to-assign-the-output-of-a-command-to-a-makefile-variable)

## Makefile中短划线

```makefile
all:
	-/bin/rm -rf *.log
```

其中，"`-/bin/rm`"的短划线"`-`"是一个特殊前缀，表示忽略命令执行过程的错误。

## 为每个源文件生成一个可执行程序

```makefile
SRCS = $(wildcard *.c)

all: $(SRCS:.c=)

# Unnecessary, as the default rules are adequate.
.c:
	gcc $(CPFLAGS) $< -o $@
```

最后两行其实不需要，默认规则已经足够了。

其中，`$(SRCS:.c=.o)`表示将变量`SRCS`中的每个单词（以空格分割）中的`.c`替换为`.o`。以上代码则是将所有`.c`都去掉。
