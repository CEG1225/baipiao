#!/bin/bash

# 创建一个空的临时文件
> temp_ips.txt

while read line; do
  # 检查每一行的第一个字符是否为数字
  if [[ $line =~ ^[0-9] ]]; then
    # 如果是数字，就将这一行写入到临时文件中
    echo $line >> temp_ips.txt
  else
    # 如果不是数字，就忽略这一行，即删除
    echo "Ignoring: $line"
  fi
done < ip.txt

# 将临时文件覆盖原文件，从而只保留以数字开头的行
mv temp_ips.txt ipip.txt

# 打印结束信息
echo "Filtering complete. Non-numeric leading lines removed."
