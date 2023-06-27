- Whitespace

Makefile对空格的处理似乎是：从第一个非空格字符开始，到明确的截止符（比如换行、'#'注释标记、逗号、括号等）为止。测试如下：

```makefile
a =   b   #注意末尾有3个空格
$(warning a=$(a)c)

find = $(findstring a  , a  b ) # 注意，2个'a'之后都有2个空格，
$(warning find=$(find)$$)

find1 = $(findstring a  , a b ) #注意：第一个'a'之后有2个空格，第二个'a'之后只有1个空格。
$(warning find1=$(find1)$$)
```

结果：

```text
Makefile:2: a=b   c
Makefile:5: find=a   $
Makefile:8: find1= $
```

- 模式匹配

模式匹配时会先忽略目录，文件名匹配完成之后再加上目录。见[10.5.4 How Patterns Match](https://www.gnu.org/software/make/manual/html_node/Pattern-Match.html)

例如：

```makefile
%.o : e%t.c
	@echo matched:$*
```

文件如下：

```text
|-- Makefile
`-- src
    |-- eat.c
```

执行make命令：

```bash
make src/a.o
```

结果：

```text
matched:src/a
```