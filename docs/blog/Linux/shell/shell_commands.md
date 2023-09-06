## 相关符号

* `$()` - 与 `` `command` ``相同

## 常见shell命令

`screen` - 虚拟终端管理器。

  - 会话保存和恢复：使用`screen`新建一个终端，会清屏；当离开`screen` 终端（detach或exit）时，上一次的终端界面可以被恢复。

  - 分离会话：`screen`创建的会话可以在后台运行，detach方法参见[博客](https://www.cnblogs.com/mingerlcm/p/12848511.html)。即使父级终端退出，detached会话也不会停止，之后新开一个虚拟终端，使用`screen -r`可以恢复会话。

    ```bash
    screen # 创建screen终端
    # 按下 ctrl-A-Z 三个键，screen终端与父终端分离
    exit # 退出父终端
    ```

    新开一个终端：
    ```bash
    screen -r # screen终端被恢复
    ```

    **注意：** 这和使用`&`或`ctrl-Z`创建的后台进程不同，如果父terminal退出，则后台进程会收到`HUP`信号而退出。

`cd`
    - `cd -` - 返回上一个目录。

`ftp`

    SYNOPSIS
        tnftp [-46AadefginpRtVv?] [-N netrc] [-o output] [-P port] [-q quittime] [-r retry] [-s srcaddr] [-T dir,max[,inc]] [-x xfersize] [[user@]host [port]] [[user@]host:[path][/]] [file:///path] [ftp://[user[:password]@]host[:port]/path[/][;type=type]] [http://[user[:password]@]host[:port]/path] [https://[user[:password]@]host[:port]/path] ...
        
        tnftp -u url file ...

  - 参考：[FTP获取文件](https://juejin.cn/s/ftp%20%E8%8E%B7%E5%8F%96%E6%96%87%E4%BB%B6)
  - 命令行输入`ftp`，进入ftp客户端。
  - FTP命令：
    - `open host [port]`
    - `get remote-file [local-file]`
    - `cd`
    - `ls`
    - `binary` - Set the file transfer type to support binary image transfer.
    - `bye` - Terminate the FTP session with the remote server and exit ftp. An end of file will also terminate the session and exit.

  例如以下URL：
    
    ftp://aaa:bbb@ftp.adbc.com/out/a.txt

  在这个URL中，aaa是用户名，bbb是密码，ftp.adbc.com是FTP服务器域名，out/a.txt是文件路径和文件名。这个URL可以用于连接到FTP服务器并下载a.txt文件。

* [LSF命令](https://zhuanlan.zhihu.com/p/283973455)
  - `bjobs`

`fg` - bash内置命令，后台进程移动到前台。`fg --help`查看帮助。`/path/to/command &`会新建一个后台进程。

`bg` - bash内置命令，前台进程移动到后台。可以使用`ctrl-Z`先将进程suspend，然后使用`bg %job_num`将其切换到后台运行。

`jobs -l` - bash内置命令，查看所有jobs。

`type` - 查看一个命令是否是bash内置。

`less` - 比`more`功能更多，不支持语法高亮。语法高亮插件见[链接](https://unix.stackexchange.com/questions/90990/less-command-and-syntax-highlighting)。

  ESC-u 取消搜索高亮（该快捷键对manual page同样适用）。

`apt-cache search` - RedHat上等价命令为`yum --cacheonly list`。

`tr` - translate or delete characters.

[三个锁定文件命令](https://juejin.cn/s/linux%20%E6%96%87%E4%BB%B6%E9%94%81%20%E5%91%BD%E4%BB%A4)
* https://xie.infoq.cn/article/85434854ec0e21068a3312927

[锁定文件命令chattr](https://www.jianshu.com/p/6c786a8621d7)

`lsattr` - 只对`ext`文件系统有效，对`nfs`之类文件系统无效，可以通过`df -T`打印文件系统的类型。

`flock` - 读写锁。例如测试时可以通过`flock <filename> cat`持有锁，然后等待`cat`的输入，也就是实现持锁等待。

`ps`

`pstree`

`pidof`

`pgrep` - 打印与模式字符串匹配的进程的ID。

  For example,

    $ pgrep -u root sshd

  will only list the processes called sshd AND owned by root.  On the other hand,

    $ pgrep -u root,daemon

  will list the processes owned by root OR daemon.

`find`

  * 任务1：将上级目录的所有的内容创建成软链接。

  ```bash
  #File: do_all.sh
  mkdir -p subdir
  cd subdir
  find .. -maxdepth 1 ! -name do_all.sh -type f -exec sh -c 'ln -sf {} `basename {}`' \;
  ```

  解析：

  - `-maxdepth 1` - 最大递归查找深度为`1`。这一点很重要，否则递归查找进入subdir之后，会陷入死循环。
  - `! -name do_all.sh` - 除了do_all.sh文件本身。
  - `-type f` - 只查找普通文件（不包含软链接）。
  - `-exec` - 后面跟需要执行的子命令，这里的子命令为`sh -c`，这里`sh -c`是必须的，否则无法解析`` `basename {}` ``（即先执行`basename`命令，将结果返回给`ln`）。可能原因是`-exec`的命令体无法识别`` `<subcommand>` ``的语法，也许这种语法是`bash`内置的。
  - `\;` - `find`的`-exec`选项必须以`;`结尾，但是`;`会被`bash`认为是整条`find`命令的结束标记，而不是`-exec`的子命令体的结束标记，所以需要转义（escape）。

  * `-exec` 中 `{} \;` 和 `{} +` 的区别：

    `{} \;`: 对每个 find 的结果都执行一次 `-exec` 后的命令；
    `{} +`: 将所有 find 的结果作为参数一次性传递给 `-exec` 后的命令。这种情况下，`-exec` 后的命令只执行了 1 次（存疑：`man page` 的说法为“命令被调用的次数远远少于搜索出的文件名”）。

tail

    -f, --follow[={name|descriptor}]
    output appended data as the file grows;

    an absent option argument means 'descriptor'

ptack

  ```bash
  while true; do
    sleep 1 &
    ...your stuff here...
    wait # for sleep
  done
  ```

echo

    -e 
    echo *
    echo o*
    echo ~

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