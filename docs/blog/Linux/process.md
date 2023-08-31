# 进程和线程

参考资料：

Linux manunal page: `man pthreads`

## 相关函数

### 获取进程ID和线程ID

* `getpid`
* `syscall(__NR_gettid)` 或 `syscall(SYS_gettid)` - [参考](https://stackoverflow.com/questions/22351033/difference-between-nr-gettid-and-sys-gettid)
* `pthread_self`

```cpp
auto pid = getpid();
auto tid = syscall(__NR_gettid);
char program[64];
auto n = readlink("/proc/self/exe", program, sizeof(program) - 1);
```

