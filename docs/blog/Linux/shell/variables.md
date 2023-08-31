# 变量（variables）


## 引用变量

* `$var` - 表示引用变量`var`。
* `${}` - 一种消除歧义的机制，也用来引用变量。比如`${var}test`表示变量`var`的内容跟上`test`，而`$vartest`则表示`vartest`变量。

## 变量作用域（scope）

* 局部（local）- 在shell函数中加上`local`关键字的变量为[局部变量](https://www.linuxtopia.org/online_books/advanced_bash_scripting_guide/localvar.html)。
* 全局（global）- shell中变量默认为全局可见（当前shell可见）。
* 环境（environment）

Example：

```bash
#!/bin/bash
# Global and local variables inside a function.

func ()
{
local loc_var=23       # Declared as local variable.
echo                   # Uses the 'local' builtin.
echo "\"loc_var\" in function = $loc_var"
global_var=999         # Not declared as local.
                        # Defaults to global. 
echo "\"global_var\" in function = $global_var"
}  

func

# Now, to see if local variable "loc_var" exists outside function.

echo
echo "\"loc_var\" outside function = $loc_var"
                                    # $loc_var outside function = 
                                    # No, $loc_var not visible globally.
echo "\"global_var\" outside function = $global_var"
                                    # $global_var outside function = 999
                                    # $global_var is visible globally.
echo				      

exit 0
#  In contrast to C, a Bash variable declared inside a function
#+ is local *only* if declared as such.
```

## 特殊变量

参考[链接](https://linuxhandbook.com/bash-special-variables/)。

| Special Variable |                                 Description                                |
|:----------------:|:--------------------------------------------------------------------------:|
| `$0`             | Gets the name of the current script.                                       |
| `$#`             | Gets the number of arguments passed while executing the bash script.       |
| `$*`             | Gives you a string containing every command-line argument.                 |
| `$@`             | It stores the list of every command-line argument as an array.             |
| `$1-$9`          | Stores the first 9 arguments.                                              |
| `$?`             | Gets the status of the last command or the most recently executed process. |
| `$!`             | Shows the process ID of the last background command.                       |
| `$$`             | Gets the process ID of the current shell.                                  |
| `$-`             | It will print the current set of options in your current shell.            |
| `!$`             | the "end" of the previous command.[1]                                      |
| `[@]`            | 与`$*`类似，比如`${LIST[*]}`将变量`LIST`的内容作为单个参数。[2]            |
| `[*]`            | 与`$@`类似，比如`${LIST}[@]`将变量`LIST`的内容作为一个参数列表。[2]        |

[1]: https://unix.stackexchange.com/questions/88642/what-does-mean
[2]: https://unix.stackexchange.com/questions/135010/what-is-the-difference-between-and-when-referencing-bash-array-values

Example:

```bash
LIST=(1 2 3)
for i in "${LIST[@]}"; do
    echo "example.$i" # print three times
done
```

```bash
LIST=(1 2 3)
for i in "${LIST[*]}"; do
    echo "example.$i" # print only once
done
```

测试环境变量是否存在：
参考[链接](https://java2blog.com/bash-check-if-environment-variable-is-set/)

