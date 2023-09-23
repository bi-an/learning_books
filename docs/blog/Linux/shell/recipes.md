## 相关符号

* `$()` - 与 `` `command` ``相同

## 常见shell命令

`echo`

```bash
echo -e "Hello\nWorld"#-e支持换行，使用printf命令更好
echo *
echo o*
echo ~
```

[链接](https://flaviocopes.com/linux-command-echo/)


## bash数据类型

array

    a=(a1 a2 a3)

## 特殊符号（Punctuation Marks）

See: `man bash` --> `EXPANSION` section

    !
    ${!parameter} 取变量$parameter的值作为变量名。
    ${}
    $()
    ``
    #
    $var
    {1..5}