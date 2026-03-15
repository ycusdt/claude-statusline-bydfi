# Claude Code Statusline API Stats

在 Claude Code 状态栏显示 API 使用统计信息。

## 预览

```
🤖 Opus 4.6 | 🧠 19,236 (10%) | 💰 $2.55 today / $18.78 used / $281.22 left | 📥 5.3M in / 📤 82K out
```

## 快速安装

```bash
curl -fsSL https://raw.githubusercontent.com/Woaiyc121/claude-statusline-bydfi/main/install.sh | bash
```

## 安装后配置

1. 编辑 `~/.local/bin/api-stats`
2. 修改 `API_ID` 变量为你的 API ID：
   ```python
   API_ID = "your-api-id-here"  # <-- 替换成你的 API ID
   ```
3. 重启 Claude Code

## 获取 API ID

1. 登录 https://www.claudecodeserver.top
2. 进入你的 API 统计页面
3. 从 URL 中复制 `apiId` 参数
   - 例如：`?apiId=8aae0f61-xxxx-xxxx-xxxx`

## 数据说明

| 字段 | 来源 | 说明 |
|------|------|------|
| 🤖 模型 | ccusage | 当前使用的模型 |
| 🧠 上下文 | ccusage | 本地会话的上下文使用量 |
| 💰 费用 | API | 今日费用 / 已用 / 剩余 |
| 📥📤 Tokens | API | 总输入/输出 token 用量 |

## 手动安装

如果自动安装失败，可以手动安装：

```bash
# 1. 创建目录
mkdir -p ~/.local/bin

# 2. 下载脚本
curl -fsSL https://raw.githubusercontent.com/Woaiyc121/claude-statusline-bydfi/main/api-stats -o ~/.local/bin/api-stats
chmod +x ~/.local/bin/api-stats

# 3. 安装依赖
pip3 install cloudscraper

# 4. 安装 ccusage (如果没有)
npm install -g ccusage

# 5. 编辑脚本，填入你的 API_ID
nano ~/.local/bin/api-stats

# 6. 配置 Claude Code
# 编辑 ~/.claude/settings.json，添加：
# "statusLine": {
#   "type": "command",
#   "command": "/Users/你的用户名/.local/bin/api-stats"
# }
```

## 故障排除

**状态栏显示 "API N/A"**
- 检查网络连接
- 确认 API ID 正确
- 可能是 Cloudflare 暂时拦截

**状态栏没有上下文信息 (🧠)**
- 这是正常的，新会话开始时没有上下文数据
- 随着对话进行会自动显示

**找不到 ccusage 命令**
- 运行：`npm install -g ccusage`

## 卸载

```bash
rm ~/.local/bin/api-stats
# 然后编辑 ~/.claude/settings.json，移除 statusLine 配置
```

## License

MIT
