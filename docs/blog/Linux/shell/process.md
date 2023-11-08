## 命令

pstack - print a stack trace of running processes

```bash
while true; do
sleep 1 &
...your stuff here...
wait # for sleep
done
```

pmap - report memory map of a process

nm - list symbols from object files

top

Refer to [here](https://www.maketecheasier.com/linux-top-explained/)

[Virtual memory](https://serverfault.com/questions/138427/what-does-virtual-memory-size-in-top-mean)

[sort ascending](https://stackoverflow.com/questions/18579361/top-unix-command-ascending-order)
[scroll down](https://askubuntu.com/questions/10521/how-to-scroll-in-the-terminal-app-top):
    
    key      equivalent-key-combinations
    Up       alt + \      or  alt + k
    Down     alt + /      or  alt + j
    Left     alt + <      or  alt + h
    Right    alt + >      or  alt + l (lower case L)
    PgUp     alt + Up     or  alt + ctrl + k
    PgDn     alt + Down   or  alt + ctrl + j
    Home     alt + Left   or  alt + ctrl + h
    End      alt + Right  or  alt + ctrl + l

[top + grep](https://unix.stackexchange.com/questions/165214/how-to-view-a-specific-process-in-top):
    top -p `pgrep "java"`
    top | grep

free

smem

## 文件系统

/proc/iomem

/proc/self/exe

/proc/\<pid\>/exe

## 函数

[glic Functions](https://www.gnu.org/software/libc/manual/html_node/Backtraces.html)

    backtrace
    backtrace_symbols
    backtrace_symbols_fd

```cpp
#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>

void print_trace() {
    static const int SIZE = 10;

    void* buffer[SIZE];
    char** strings;
    int size, i;

    size = backtrace(buffer, SIZE);
    strings = backtrace_symbols(buffer, size);
    if (strings != NULL) {
        printf("Obtained %d stack frames.\n", size);
        for (i = 0; i < size; ++i)
            printf("%s\n", strings[i]);
        free(strings);
    }
}
```

ptrace - process trace