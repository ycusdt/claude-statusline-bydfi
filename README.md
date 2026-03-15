# Claude Code Statusline API Stats

在 Claude Code 状态栏显示 API 使用统计信息。

## 预览

```
🤖 Opus 4.6 (1M context) | 🧠 26k █░░░░░░░13% | 💰 $9.93 today : $273.85 left | 📥 6.0M in : 120K out
```

## 功能

- 🤖 **动态显示当前模型** - 自动识别模型名称和上下文窗口大小
- 🧠 **每会话上下文跟踪** - 每个窗口显示自己会话的实际上下文使用量
- 💰 **费用统计** - 今日费用 / 剩余费用
- 📥📤 **Token 用量** - 总输入/输出 token 用量
- 自动识别 1M/200K 等不同上下文窗口

## 系统要求

- macOS / Linux
- Python 3.6+
- **推荐终端**: iTerm2 (不建议使用 macOS 原生终端)

## 快速安装

```bash
curl -fsSL https://raw.githubusercontent.com/Woaiyc121/claude-statusline-bydfi/main/install.sh | bash
```

## 安装后配置

**重要：安装完成后必须做以下配置！**

### 1. 填入 API ID

编辑 `~/.local/bin/api-stats`，修改 `API_ID` 变量：

```python
API_ID = "your-api-id-here"  # <-- 替换成你的 API ID
```

### 2. 重启 Claude Code

关闭当前 Claude Code 会话，重新启动即可看到效果。

## 获取 API ID

1. 登录 https://www.claudecodeserver.top
2. 进入你的 API 统计页面
3. 从 URL 中复制 `apiId` 参数
   - 例如：`?apiId=8aae0f61-xxxx-xxxx-xxxx`

## 终端推荐

**推荐使用 iTerm2**，不建议使用 macOS 原生终端 (Terminal.app)。

安装 iTerm2：
```bash
# 如果有 Homebrew
brew install --cask iterm2

# 或者直接下载: https://iterm2.com/downloads.html
```

iTerm2 优势：
- 更好的字体渲染
- 支持真彩色
- 更强大的分屏功能
- 更好的 Unicode/Emoji 支持

## 数据说明

| 字段 | 来源 | 说明 |
|------|------|------|
| 🤖 模型 | stdin | 当前使用的模型（含上下文大小） |
| 🧠 上下文 | transcript | 本会话的实际上下文使用量 |
| 💰 费用 | API | 今日费用 / 剩余费用 |
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

# 4. 编辑脚本，填入你的 API_ID
nano ~/.local/bin/api-stats

# 5. 配置 Claude Code
# 编辑 ~/.claude/settings.json，添加：
# "statusLine": {
#   "type": "command",
#   "command": "/Users/你的用户名/.local/bin/api-stats"
# }
```

## 替换 API ID

如果你有多个 API 或需要更换，只需：

1. 编辑 `~/.local/bin/api-stats`
2. 找到 `API_ID = "xxx"` 这一行
3. 替换成新的 API ID
4. 保存文件
5. 重启 Claude Code

## 故障排除

**状态栏显示 "API N/A"**
- 检查网络连接
- 确认 API ID 正确
- 可能是 Cloudflare 暂时拦截

**状态栏没有上下文信息 (🧠)**
- 这是正常的，新会话开始时没有上下文数据
- 随着对话进行会自动显示

**上下文百分比不准确**
- 确保重启了 Claude Code 窗口
- 脚本需要从 stdin 获取正确的会话信息

**状态栏不显示或显示错误**
- 确认 Python 3 已安装：`python3 --version`
- 确认 cloudscraper 已安装：`pip3 install cloudscraper`
- 检查脚本权限：`chmod +x ~/.local/bin/api-stats`

## 卸载

```bash
rm ~/.local/bin/api-stats
# 然后编辑 ~/.claude/settings.json，移除 statusLine 配置
```

## 给 AI 的配置说明

如果你让其他 AI 帮你安装配置此工具，请确保：

1. 运行安装命令
2. 修改 `~/.local/bin/api-stats` 中的 `API_ID`
3. 推荐使用 iTerm2 而非 macOS 原生终端
4. 重启 Claude Code 生效

## License

MIT
