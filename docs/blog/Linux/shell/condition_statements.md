# 条件语句

## `if`

参考[文档](https://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html)。

`=`、`==`、`-eq`区别（参考[链接](https://stackoverflow.com/questions/20449543/shell-equality-operators-eq)）：

* `=`和`==`：用于字符串比较。`==`限定于bash中，POSIX使用`=`。在bash中，`=`和`==`相同，`=`最好与bash内置的`test`命令一起使用以确保POSIX一致性。
* `-eq`：用于数字比较。与`-lt`、`-le`、`-gt`、`-ge`、`-ne`属于同一个家族。