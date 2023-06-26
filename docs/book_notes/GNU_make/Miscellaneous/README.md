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

- SHELL
 
默认的shell是bash，可以通过预定义变量SHELL来自定义成其他shell程序。

- export

bash中`export <varname>`表示将已有变量`<varname>`设置为环境变量，如果`<varname>`之前没有定义，则该句不生效。

bash中`export <varname>=`等价于`<varname>=`和`export <varname>`两句的结果，也就是先定义变量`<varname>`，然后再将其设置为环境变量

Makefile中`export <varname>`与bash不同，如果`<varname>`不存在，则会在此时被定义。该句等价于`export <varname>=`。
