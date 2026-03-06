---
name: uninstall-mac-input-method
description: Uninstall third-party input methods on macOS. Use when the user wants to remove, clean up, or completely uninstall Chinese input methods such as WeChat (WeType), Sogou (搜狗), Baidu (百度), Squirrel/Rime (鼠须管), LogInput (落格), or iFlytek (讯飞) input methods from their Mac.
作者: 蓝衣剑客 v：lanyijianke1992
---

# Mac 第三方输入法彻底卸载

Completely remove third-party input methods from macOS, including all residual files.

## General Workflow

1. **Remove from Input Sources**: System Settings → Keyboard → Input Sources → select target → click "-"
2. **Kill processes**: Use `killall <ProcessName>` or Activity Monitor to force quit
3. **Delete files**: Remove app, support files, preferences, and caches using the paths below
4. **Reboot** (recommended) to fully clear system input method cache

## Input Method Registry

### WeChat / 微信输入法 (WeType)

| Type | Path |
|------|------|
| App | `/Library/Input Methods/WeType.app` |
| Support | `~/Library/Application Support/WeType` |
| HTTP Storage | `~/Library/HTTPStorages/com.tencent.inputmethod.wetype` |
| Preferences | `~/Library/Preferences/com.tencent.inputmethod.wetype.plist` |

Process name: `WeType`

```bash
sudo rm -rf "/Library/Input Methods/WeType.app"
rm -rf ~/Library/Application\ Support/WeType
rm -rf ~/Library/HTTPStorages/com.tencent.inputmethod.wetype
rm -rf ~/Library/Preferences/com.tencent.inputmethod.wetype.plist
```

---

### Sogou / 搜狗输入法

| Type | Path |
|------|------|
| App | `/Library/Input Methods/SogouInput.app` |
| Support | `~/Library/Application Support/SogouInput` |
| HTTP Storage | `~/Library/HTTPStorages/com.sogou.inputmethod.sogou` |
| Preferences | `~/Library/Preferences/com.sogou.inputmethod.sogou.plist` |
| Task Manager | `~/Library/Preferences/com.sogou.SogouTaskManager.plist` |

Process name: `SogouInput`

```bash
sudo rm -rf "/Library/Input Methods/SogouInput.app"
rm -rf ~/Library/Application\ Support/SogouInput
rm -rf ~/Library/HTTPStorages/com.sogou.inputmethod.sogou
rm -rf ~/Library/Preferences/com.sogou.inputmethod.sogou.plist
rm -rf ~/Library/Preferences/com.sogou.SogouTaskManager.plist
```

---

### Baidu / 百度输入法

| Type | Path |
|------|------|
| App | `/Library/Input Methods/BaiduIM.app` |
| Support | `~/Library/Application Support/BaiduIM` |
| HTTP Storage | `~/Library/HTTPStorages/com.baidu.inputmethod.BaiduIM` |
| Preferences | `~/Library/Preferences/com.baidu.inputmethod.BaiduIM.plist` |

Process name: `BaiduIM`

```bash
sudo rm -rf "/Library/Input Methods/BaiduIM.app"
rm -rf ~/Library/Application\ Support/BaiduIM
rm -rf ~/Library/HTTPStorages/com.baidu.inputmethod.BaiduIM
rm -rf ~/Library/Preferences/com.baidu.inputmethod.BaiduIM.plist
```

---

### Squirrel / 鼠须管 (Rime)

| Type | Path |
|------|------|
| App | `/Library/Input Methods/Squirrel.app` |
| Config | `~/Library/Rime` |
| HTTP Storage | `~/Library/HTTPStorages/im.rime.inputmethod.Squirrel` |
| Preferences | `~/Library/Preferences/im.rime.inputmethod.Squirrel.plist` |

Process name: `Squirrel`

```bash
sudo rm -rf "/Library/Input Methods/Squirrel.app"
rm -rf ~/Library/Rime
rm -rf ~/Library/HTTPStorages/im.rime.inputmethod.Squirrel
rm -rf ~/Library/Preferences/im.rime.inputmethod.Squirrel.plist
```

---

### LogInput / 落格输入法

| Type | Path |
|------|------|
| App | `/Library/Input Methods/落格输入法 3.app` |
| Support | `~/Library/Application Support/com.logcg.inputmethod.LogInputMac3` |
| Preferences | `~/Library/Preferences/com.logcg.inputmethod.LogInputMac3.plist` |

Process name: `LogInputMac3`

```bash
sudo rm -rf "/Library/Input Methods/落格输入法 3.app"
rm -rf ~/Library/Application\ Support/com.logcg.inputmethod.LogInputMac3
rm -rf ~/Library/Preferences/com.logcg.inputmethod.LogInputMac3.plist
```

---

### iFlytek / 讯飞输入法

No exact paths documented. Follow this discovery pattern:

```bash
# Find app
ls "/Library/Input Methods/" | grep -i fly
# Find support files
ls ~/Library/Application\ Support/ | grep -i fly
# Find preferences
ls ~/Library/Preferences/ | grep -i iflytek
# Find HTTP storage
ls ~/Library/HTTPStorages/ | grep -i iflytek
```

Then delete each discovered path with `rm -rf`.

---

## Scan Script

To auto-detect installed third-party input methods, run the scan script:

```bash
scripts/scan_input_methods.sh
```

## Important Notes

- Deleting apps in `/Library/Input Methods/` requires `sudo` (admin password).
- Files in `~/Library/...` do NOT require sudo.
- Always kill the input method process BEFORE deleting files.
- Reboot after uninstall to clear macOS input method cache.
- If unsure about a path, check existence with `ls` before deleting.
