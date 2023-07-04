# 常见shell命令

* `screen` - 虚拟终端管理器。

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

* `cd`
    - `cd -` - 返回上一个目录。