# `tar`

    选项：
    -c, --create
        create a new archive.

    -x, --extract, --get
        Extract files from an archive.

    -z, --gzip, --gnuzip, --ungzip
        Filter the archive through `gzip`(1).

    -Z, --compress, --uncompress
        Filter the archive through `compress`(1).

    -A, --catenate, --concatenate
        Append archive to the end of another archive.

        Compressed archives cannot be concatenated.

    -v, --verbose
    
    -f ARCHIVE

    -t, --list
        List the contents of an archive.

    打包：
    tar czvf dest src1 src2...
    其中，dest是生成的文件名（不是目录），src可以是目录或文件。
    tar czvf file.tar.gz /etc *.txt

    解包：
    tar zxvf file

# `compress`

    compress/uncompress
        -c
        makes compress/uncompress write to the standard output; no files are changed.

    zcat
        is identical to `uncompress -c`.

