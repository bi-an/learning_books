# 两台机器通过RSA密钥访问

1. 生成密钥

    ssh-keygen

2. 机器A需要登录到机器B上

    将A的公钥（位于~/.ssh/id_rsa.pub文件中）追加到B机器的~/.ssh/authorized_keys文件（如果B机器上没有这个文件则新建一个）中。

3. 机器A登录到机器B的命令：

    ssh username@hostname