## Whitespace

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


## 模式匹配

模式匹配时会先忽略目录，文件名匹配完成之后再加上目录。见[10.5.4 How Patterns Match](https://www.gnu.org/software/make/manual/html_node/Pattern-Match.html)。

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


## 变量SHELL
 
默认的shell是bash，可以通过预定义变量SHELL来自定义成其他shell程序。

## 关键词export

bash中`export <varname>`表示将已有变量`<varname>`设置为环境变量，如果`<varname>`之前没有定义，则该句不生效。

bash中`export <varname>=`等价于`<varname>=`和`export <varname>`两句的结果，也就是先定义变量`<varname>`，然后再将其设置为环境变量

Makefile中`export <varname>`与bash不同，如果`<varname>`不存在，则会在此时被定义。该句等价于`export <varname>=`。

## 等号

四种等号：`=`, `:=`, `?=`, `+=`。参考[这里](https://stackoverflow.com/questions/448910/what-is-the-difference-between-the-gnu-makefile-variable-assignments-a)。

官方文档：[6.2 The Two Flavours of Variables](https://www.gnu.org/software/make/manual/html_node/Flavors.html#Flavors)

### Lazy Set

    VARIABLE = value

Normal setting of a variable, but any other variables mentioned with the value field are recursively expanded with their value at the point at which the variable is used, not the one it had when it was declared

### Immediate Set

    VARIABLE := value

Setting of a variable with simple expansion of the values inside - values within it are expanded at declaration time.

### Lazy Set If Absent

    VARIABLE ?= value

Setting of a variable only if it doesn't have a value. value is always evaluated when VARIABLE is accessed. It is equivalent to

    ifeq ($(origin VARIABLE), undefined)
        VARIABLE = value
    endif

See the [documentation](https://www.gnu.org/software/make/manual/html_node/Flavors.html#Flavors) for more details.

### Append

    VARIABLE += value

Appending the supplied value to the existing value (or setting to that value if the variable didn't exist)