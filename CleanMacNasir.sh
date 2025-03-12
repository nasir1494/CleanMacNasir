#!/bin/bash
# CleanMacNasir - by Nasir
# GitHub: https://github.com/nasir1494
print_banner() {
  echo "###############################################"
  echo "#                                             #"
  echo "#             CleanMacNasir                   #"
  echo "#             by Nasir                        #"
  echo "#                                             #"
  echo "#   GitHub: https://github.com/nasir1494       #"
  echo "#                                             #"
  echo "###############################################"
}

print_banner

if [[ $EUID -ne 0 ]]; then
  echo "請使用 sudo 執行此腳本以獲取最高管理權限！"
  exit 1
fi

paths=(
  "$HOME/Library/Logs"
  "$HOME/Library/Containers"
  "$HOME/Library/Application Support"
  "$HOME/Library/Cookies"
  "/Library/Logs"
  "/Library/Containers"
  "/Library/Application Support"
  "/Library/Cookies"
)

echo "警告：這工具將會清除下列的所有內容，請先備份所有重要資料ㄛ："
for path in "${paths[@]}"; do
  echo " - $path"
done

read -p "請確認是否繼續 (輸入 [y] 確認)： " confirm
if [[ "$confirm" != "y" ]]; then
  echo "取消操作。"
  exit 0
fi
shopt -s dotglob

for path in "${paths[@]}"; do
  if [ -d "$path" ]; then
    echo "正在清理: $path"
    rm -rf "$path"/*
    echo "已清空: $path"
  else
    echo "目錄不存在: $path"
  fi
done
shopt -u dotglob

echo "所有垃圾檔案均已清空。"
