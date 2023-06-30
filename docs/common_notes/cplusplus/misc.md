# 杂项

记录代码小技巧。

## 环境变量

* `environ` - 用户环境，一个全局变量。头文件 `<unistd.h>`。可以通过 `man environ` 查看手册。

    ```cpp
    #include <unistd.h>
    #include <iostream>
    using namespace std;

    int main() {
        cout << "program environment: " << endl;
        for (char** entry = environ; *entry; ++entry) {
            cout << *entry << endl;
        }
    }
    ```

* `getenv` - 获取环境变量。头文件 `<stdlib.h>`。
* `setenv` - 设置环境变量。头文件 `stdlib.h`。

## printf打印

* 非打印字符 - 参见 [Escape sequeneces](https://en.cppreference.com/w/cpp/language/escape).

    ```cpp
    char str[] = "\x1E"; // "0x1E" 是一个非打印字符
    ```

