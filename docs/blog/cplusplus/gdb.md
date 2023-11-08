# gdb调试

本文档记录gdb相关实践经验。

## gdb实现原理

参考[链接](https://www.zhihu.com/people/bi-an-60-46)。

## gdb命令

* `thread apply [threadno] [all] args` - 将命令传递给一个或多个线程，参见[链接](https://developer.apple.com/library/archive/documentation/DeveloperTools/gdb/gdb/gdb_5.html)。
比如，`thread apply all continue`表示将`continue`命令传递给所有线程，也就是让所有线程都继续运行。

* `rbreak` - Set a breakpoint for all functions matching REGEXP. 参考[链接](https://blog.csdn.net/zdl1016/article/details/8708077)。

    e.g. `rbreak file.C:.*` - 给file.C的所有函数加上断点。

* `info`
  - `info inferior` - 可以查看当前调试的进程的PID。另外一种方法是在gdb命令行中直接调用C函数：`print (int)getpid()`。参考：[链接](https://www.qiniu.com/qfans/qnso-36704270)。
  - `info source` - 当前调试的源文件路径。
  - `info proc` - [当前进程信息](https://sourceware.org/gdb/onlinedocs/gdb/Process-Information.html)。
    - `info proc files` - 当前进程打开的文件（和文件描述符）。
* `attach` - 连接到正在运行的进程。与`gdb -p`效果相同。
* `detach` - 取消连接的进程。
* `handle <signal> print pass nostop` - 捕获信号（比如`SIGSEGV`）并且忽略它。`handle <signal nostop`。
* `set` - 修改变量的值，比如`set x=10`（或`set var x=10`）将变量`x`的值改为`10`。参考[博客](https://blog.csdn.net/yasi_xi/article/details/12784507)。
* `show directories`
* `print` - gdb默认设置打印字符串的长度为200；更改打印最大长度：`set print elements <number-of-elements>`，`0`表示unlimited.
* `ptype <variable name>` - 打印变量类型。


### 断点

添加断点：

    break file:line_no

查看断点：

    info break

删除第2个断点：

    delete 2


#### 条件断点

参考：[博客](http://c.biancheng.net/view/8255.html)。

`break ... if cond`


#### 观察断点

#### 捕捉断点

try...catch


### 打印长度的限制

* Value sizes - 参考：[文档](https://sourceware.org/gdb/onlinedocs/gdb/Value-Sizes.html)

  ```
  set max-value-size bytes
  set max-value-size unlimited
  ```

* 打印字符长度限制

  gdb默认设置打印字符串的长度为200；更改打印最大长度：`set print elements`


# coredump

gdb命令：`gcore`。

参考：https://man7.org/linux/man-pages/man5/core.5.html

# WSL（windows虚拟机）无法使用gdb

[解决方法](https://github.com/microsoft/WSL/issues/8516)：

安装[PPA的daily build版本](https://launchpad.net/~ubuntu-support-team/+archive/ubuntu/gdb)

  sudo add-apt-repository ppa:ubuntu-support-team/gdb
  sudo apt update
  sudo apt install gdb
