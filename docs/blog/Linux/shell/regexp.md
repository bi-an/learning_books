# 引言

本章记录正则表达式相关语法。

## 模式（patterns）

- `glob` : 主要用于匹配带有通配符的文件路径。其匹配字符串的能力比正则表达式弱。

  它最初是贝尔实验室 Unix 系统上的一个名叫 glob 的命令（glob 是 global 的缩写），用于展开命令行中的通配符。后来系统提供了该功能的 C 语言库函数glob()，知名的 shell 解释器就使用了该接口，shell 脚本和命令行中使用的 glob 模式匹配功能便源自于此。——见[博客](https://juejin.cn/post/6844904077801816077)。

- `regexp` : 正则表达式。

## 命令`grep`

### `grep`选项

* `--exclude=GLOB` : 排除符合GLOB通配符条件的特定文件。A file-name glob can use `*`, `?`, and `[...]` as wildcards, and `\` to quote a wildcard or backslash character literally.
* `--include=GLOB` : 搜索符合GLOB通配符条件的特定文件。

  e.g. `grep -rn --include='*.后缀名' "检索词"` --- 参考[链接](https://www.02405.com/archives/1749)

* `--exclude-from=FILE`
* `--exclude-dir=DIR`
* `-r` : 递归搜索每个目录下的所有文件。只有当符号链接在命令行上时，才跟踪链接。该选项和`-d recurse`等价。
* `-R` : 和`-r`相同，区别在于本选项跟踪所有的符号链接。
* `--include=GLOB` : 只搜索与GLOB匹配的文件。