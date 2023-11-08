## 性能分析

### CPU时间

Function's CPU time:

    * Inclusive time: total cpu time, include all functions it calls.
    * Exclusive time: only the time used by the function itself, exclusive all its children.

    Refer to [here](https://stackoverflow.com/questions/15760447/what-is-the-meaning-of-incl-cpu-time-excl-cpu-time-incl-real-cpu-time-excl-re/74426370).

1. Wall time: total time the process used, containing IO time.
2. CPU usage (CPU利用率) = CPU time / Wall time.
3. real/user/system time
   * **Real** is wall clock time - time from start to finish of the call. This is all elapsed time including time slices used by other processes and time the process spends blocked (for example if it is waiting for I/O to complete).
   * **User** is the amount of CPU time spent in user-mode code (outside the kernel) within the process. This is only actual CPU time used in executing the process. Other processes and time the process spends blocked do not count towards this figure.
   * **Sys** is the amount of CPU time spent in the kernel within the process. This means executing CPU time spent in system calls within the kernel, as opposed to library code, which is still running in user-space. Like 'user', this is only CPU time used by the process. See below for a brief description of kernel mode (also known as 'supervisor' mode) and the system call mechanism.

    Refer to [here](https://stackoverflow.com/questions/556405/what-do-real-user-and-sys-mean-in-the-output-of-time1).

4. CPU 时间可能大于墙上时间：

   这是因为 CPU 时间是所有 CPU 核的运行时间的累加和，墙上时间则是实际的时间。此时 CPU 利用率大于 100%. （这是自己的理解）

### 计时工具

``` bash
$ /usr/bin/time -p ls
```

Or,

``` bash
$ time ls
```

其中（参考[链接](https://ostechnix.com/how-to-find-the-execution-time-of-a-command-or-process-in-linux/)），

``` bash
$ type -a time
time is a shell keyword
time is /usr/bin/time
```

#### 释疑

1. Is CPU time in flame graph sum of all the CPU time? Or is it the wall time when CPU works?


### 性能分析工具

Oracle Developer Studio：

[Performance Analyzer](https://www.oracle.com/application-development/technologies/developerstudio-features.html#performance-analyzer-tab)：[手册](https://docs.oracle.com/cd/E77782_01/html/E77798/afagg.html#OSSPAgrkam)

[Thread Analyzer](https://www.oracle.com/application-development/technologies/developerstudio-features.html#thread-analyzer-tab)

[gprof](https://ftp.gnu.org/old-gnu/Manuals/gprof-2.9.1/html_mono/gprof.html): [使用方法](https://blog.csdn.net/luronggui/article/details/118141262)

## 内存分析

### 内存分析工具

[AddressSanitizer](https://github.com/google/sanitizers/wiki/AddressSanitizer)