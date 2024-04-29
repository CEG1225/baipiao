#!/bin/bash

# 跳过第一行，然后处理每一行
tail -n +2 AS0-0-HKG.csv | while IFS=',' read -r ip port others
do
    # 将第一列和第二列中间加上冒号，并写入到TXT文件中
    echo "${ip}:${port}" >> youxuan.txt
done
