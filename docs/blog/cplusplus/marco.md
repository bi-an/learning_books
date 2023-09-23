# 预定义宏

## C标准预定义宏

* `__LINE__`
* `__func__`
* `__FILE__`
* `NDEBUG`：参考[_DEBUG和NDEBUG的区别](https://stackoverflow.com/questions/2290509/debug-vs-ndebug)，其中，`_DEBUG`是Visual Studio定义的，`NDEBUG`是C/C++标准。

## GNU C预定义宏

[官方文档](https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html)


* `__COUNTER__`: 扩展为从`0`开始的连续整数值，每次在源码中出现，则加`1`。不同源文件的`__COUNTER__`互不影响。

  可以用来生成唯一的命名。
  参考[链接](https://stackoverflow.com/questions/652815/has-anyone-ever-had-a-use-for-the-counter-pre-processor-macro)。

  ```cpp
  #define CONCAT_IMPL(x,y) x##y
  #define CONCAT(x,y) CONCAT_IMPL(x,y)
  #define VAR(name) CONCAT(name,__COUNTER__)
  int main() {
      int VAR(myvar); // 展开为 int myvar0;
      int VAR(myvar); // 展开为 int myvar1;
      int VAR(myvar); // 展开为 int myvar2;
  }
  ```

