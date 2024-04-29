
#https://sub.kaiche.tk/?token=auto


function parse_link() {
    while IFS= read -r link; do
        ip_and_port=$(echo "$link" | awk -F'[@#?]' '{print $2}')
        echo "$ip_and_port"
    done < $1 > $2
}

function download_and_decode() {
    curl -A "v2rayN/6.31" "$1" -o $2
    base64 -d $2 > $3
}

download_and_decode "https://cfno1.pages.dev/sub" "no2.txt" "no1.txt"
parse_link "no1.txt" "no.txt"
echo "CF.NO.1-------OK!"

download_and_decode "https://vless.fxxk.dedyn.io/sub?host=peng.peng.com&uuid=8d606ee1-afd8-4064-a6d2-2b4fec0d632d&path=sbed" "cm2.txt" "cm1.txt"
parse_link "cm1.txt" "cm.txt"
echo "CMLIU--------OK!"

download_and_decode "https://3k.fxxk.dedyn.io/sub?host=peng.peng.com&uuid=8d606ee1-afd8-4064-a6d2-2b4fec0d632d&path=sbed" "3k2.txt" "3k1.txt"
parse_link "3k1.txt" "3k.txt"
echo "3k----OK!"

download_and_decode "https://moistr.freenods.sbs/free?host=peng.peng.com&uuid=8d606ee1-afd8-4064-a6d2-2b4fec0d632d&path=sbed" "m2.txt" "m1.txt"
parse_link "m1.txt" "m.txt"
echo "MOISTR---------OK!"

download_and_decode "https://cm.godns.onflashdrive.app/sub?host=peng.peng.com&uuid=8d606ee1-afd8-4064-a6d2-2b4fec0d632d&path=sbed" "tc2.txt" "tc1.txt"
parse_link "tc1.txt" "tc.txt"
echo "TIANCHENG------------OK!"

download_and_decode "http://sub.kaiche.tk/?token=auto" "otc2.txt" "otc1.txt"
parse_link "otc1.txt" "otc.txt"
echo "OTC-----------OK!"

download_and_decode "http://urls.freedonscf.cfd/HappyHour" "MM2.txt" "MM1.txt"
parse_link "MM1.txt" "MM.txt"
echo "MM-----------OK!"

cat no.txt cm.txt 3k.txt m.txt tc.txt otc.txt MM.txt > /root/result/ip.txt


#生成notls.txt

# 文件路径
file_path="/root/result/ip.txt"

# 定义要删除的端口号列表
PORTS=(80 8080 8880 2052 2082 2086 2095)

# 输出文件路径
output_file="/root/result/notls.txt"

# 清空输出文件
> "$output_file"

# 遍历 IP 地址列表文件
while IFS= read -r line; do
    # 检查是否包含要删除的端口号
    should_delete=false
    for port in "${PORTS[@]}"; do
        if [[ $line == *":$port"* ]]; then
            should_delete=true
            break
        fi
    done

    # 如果包含要删除的端口号，则将该行写入输出文件
    if [ "$should_delete" = true ]; then
        echo "$line" >> "$output_file"
    fi
done < "$file_path"











# 文件路径
file_path="/root/result/ip.txt"

# 定义要删除的端口号列表
PORTS=(80 8080 8880 2052 2082 2086 2095)

# 临时文件用于存储处理后的内容
tmp_file=$(mktemp)

# 遍历 IP 地址列表文件
while IFS= read -r line; do
    # 检查是否包含要删除的端口号
    should_delete=false
    for port in "${PORTS[@]}"; do
        if [[ $line == *":$port"* ]]; then
            should_delete=true
            break
        fi
    done

    # 如果不包含要删除的端口号，则写入临时文件
    if [ "$should_delete" = false ]; then
        echo "$line" >> "$tmp_file"
    fi
done < "$file_path"

# 将临时文件内容覆盖回原始文件
mv "$tmp_file" "$file_path"

echo "删除notls的节点!!"


cd /root/result && sort ip.txt | uniq > temp_ip.txt && mv temp_ip.txt ip.txt




/etc/init.d/openclash stop     #停止openclashclash

echo " 停止openclashclash"
#########################################################检测可用性


##!/bin/bash

# 输入文件和输出文件
input_file="/root/result/ip.txt"
output_file="/root/result/ipip.txt"

# 删除之前的输出文件（如果存在）
rm -f "$output_file"

# 逐行读取IP地址列表，并使用多线程进行检测
while IFS= read -r ip; do
    ip=$(echo "$ip" | tr -d '\r')  # 去除可能的Windows换行符
    if [[ ! -z "$ip" ]]; then
        # 检测可用性并筛选可用IP
        (
            if timeout 2 bash -c "echo >/dev/tcp/$(echo "$ip" | cut -d: -f1)/$(echo "$ip" | cut -d: -f2)" &>/dev/null; then
                echo "IP地址 $ip 可用"
                echo "$ip" >> "$output_file"
            else
                echo "IP地址 $ip 不可用"
            fi
        ) &
    fi
done < "$input_file"

# 等待所有后台任务完成
wait

echo "已检测完毕，可用IP地址已导出到 $output_file 文件中"




/etc/init.d/openclash restart

echo "重新启动请等待 15 秒"

sleep 15

cd /root/result &&  bash de.sh && git config --global credential.helper store && git add . && git commit -m "Add new feature" && git push origin main



# 定义你的Telegram bot API token和chat id
apiToken="6532289967:AAG-yTx-Msn7cPyTeWa0ziYpkqI5s3FHw3w"
chatId="6749413935"

# 遍历/root/result目录中的所有文件，并发送到Telegram
for file in /root/result/ipip.txt; do
    if [ -f "$file" ]; then
        curl -F chat_id=${chatId} -F document=@${file} "https://api.telegram.org/bot${apiToken}/sendDocument"
    fi
done


rm /root/3k.txt
rm /root/3k1.txt
rm /root/3k2.txt


rm /root/m.txt
rm /root/m1.txt
rm /root/m2.txt


rm /root/MM.txt
rm /root/MM1.txt
rm /root/MM2.txt

rm /root/cm.txt
rm /root/cm1.txt
rm /root/cm2.txt

rm /root/otc.txt
rm /root/otc1.txt
rm /root/otc2.txt

rm /root/tc.txt
rm /root/tc1.txt
rm /root/tc2.txt

rm /root/no.txt
rm /root/no1.txt
rm /root/no2.txt
