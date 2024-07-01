#!/bin/bash

# 定义一个函数，用于测试指定 IP 和端口的 TCP 连接状态
tcping() {
    local ip=$1
    local port=$2
    local start_time=$(date +%s%3N)
    timeout 1 bash -c "cat < /dev/null > /dev/tcp/$ip/$port" 2>/dev/null
    if [ $? -eq 0 ]; then
        local end_time=$(date +%s%3N)
        local duration=$((end_time - start_time))
        echo "$duration"
    else
        echo "timeout"
    fi
}

# 定义输入文件和输出文件的路径
input_file="ip.txt"
output_file="iptest.txt"

# 定义一个函数，用于停止 OpenClash
stop_openclash() {
    /etc/init.d/openclash stop
    echo "OpenClash 已停止"
}

# 定义一个函数，用于启动 OpenClash
start_openclash() {
    /etc/init.d/openclash start
    echo "OpenClash 已启动"
}

# 停止 OpenClash
stop_openclash

# 如果输出文件存在，则清空它
> "$output_file"

# 定义一个数组用于存储IP和端口组合及其对应的时间
declare -A ip_times

# 逐行读取输入文件中的 IP 和端口组合
while IFS= read -r line; do
    # 提取 IP 和端口
    ip=$(echo "$line" | cut -d':' -f1)
    port=$(echo "$line" | cut -d':' -f2 | cut -d'#' -f1)

    # 测试 TCP 连接状态
    duration=$(tcping "$ip" "$port")

    # 只记录没有超时的IP和端口
    if [ "$duration" != "timeout" ]; then
        ip_times["$ip:$port"]=$duration
    fi
done < "$input_file"

# 按ping时间排序并获取前20个IP和端口
for ip_port in $(printf "%s\n" "${!ip_times[@]}" | sort -n -t':' -k2 | head -n 20); do
    echo "$ip_port#${ip_times[$ip_port]}" >> "$output_file"
done

# 启动 OpenClash
start_openclash

sleep 15

echo "TCP ping 测试完成。结果已保存到 $output_file"
