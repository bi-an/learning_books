## 命令

pstack

```bash
while true; do
sleep 1 &
...your stuff here...
wait # for sleep
done
```

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