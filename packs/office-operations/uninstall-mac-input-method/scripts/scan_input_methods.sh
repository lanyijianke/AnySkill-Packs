#!/bin/bash
# Scan for installed third-party input methods on macOS
# Usage: bash scripts/scan_input_methods.sh
# 作者: 蓝衣剑客 v：lanyijianke1992
set -euo pipefail

# Define known input methods: name|process|app_path|support_path|pref_pattern
INPUT_METHODS=(
  "WeChat (WeType)|WeType|/Library/Input Methods/WeType.app|~/Library/Application Support/WeType|com.tencent.inputmethod.wetype"
  "Sogou (搜狗)|SogouInput|/Library/Input Methods/SogouInput.app|~/Library/Application Support/SogouInput|com.sogou.inputmethod.sogou"
  "Baidu (百度)|BaiduIM|/Library/Input Methods/BaiduIM.app|~/Library/Application Support/BaiduIM|com.baidu.inputmethod.BaiduIM"
  "Squirrel/Rime (鼠须管)|Squirrel|/Library/Input Methods/Squirrel.app|~/Library/Rime|im.rime.inputmethod.Squirrel"
  "LogInput (落格)|LogInputMac3|/Library/Input Methods/落格输入法 3.app|~/Library/Application Support/com.logcg.inputmethod.LogInputMac3|com.logcg.inputmethod.LogInputMac3"
  "iFlytek (讯飞)|iFlyInput|/Library/Input Methods/iFlyInput.app|~/Library/Application Support/iFlyInput|com.iflytek"
)

echo "=========================================="
echo "  macOS 第三方输入法扫描器"
echo "  Third-party Input Method Scanner"
echo "=========================================="
echo ""

found_any=false

for entry in "${INPUT_METHODS[@]}"; do
  IFS='|' read -r name process app_path support_path pref_pattern <<< "$entry"
  
  # Expand ~ in paths
  expanded_app="$app_path"
  expanded_support="${support_path/#\~/$HOME}"
  
  found=false
  details=""
  
  # Check app
  if [ -e "$expanded_app" ]; then
    found=true
    details+="    ✅ App:     $app_path\n"
  fi
  
  # Check support files
  if [ -e "$expanded_support" ]; then
    found=true
    details+="    ✅ Support: $support_path\n"
  fi
  
  # Check preferences
  pref_files=$(find "$HOME/Library/Preferences" -name "${pref_pattern}*" 2>/dev/null || true)
  if [ -n "$pref_files" ]; then
    found=true
    while IFS= read -r pf; do
      details+="    ✅ Pref:    ~/Library/Preferences/$(basename "$pf")\n"
    done <<< "$pref_files"
  fi
  
  # Check HTTP storages
  http_files=$(find "$HOME/Library/HTTPStorages" -maxdepth 1 -name "${pref_pattern}*" 2>/dev/null || true)
  if [ -n "$http_files" ]; then
    found=true
    while IFS= read -r hf; do
      details+="    ✅ HTTP:    ~/Library/HTTPStorages/$(basename "$hf")\n"
    done <<< "$http_files"
  fi
  
  # Check running process
  running=""
  if pgrep -x "$process" > /dev/null 2>&1; then
    running=" ⚠️  RUNNING"
  fi
  
  if [ "$found" = true ]; then
    found_any=true
    echo "🔍 $name$running"
    echo -e "$details"
  fi
done

# Check for any other unknown input methods
echo "------------------------------------------"
echo "📂 All apps in /Library/Input Methods/:"
ls -1 "/Library/Input Methods/" 2>/dev/null | while read -r app; do
  echo "    $app"
done

if [ "$found_any" = false ]; then
  echo ""
  echo "✨ No known third-party input methods found!"
fi

echo ""
echo "=========================================="
