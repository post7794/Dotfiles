# Dotfiles

个人 Arch Linux Hyprland 桌面环境配置文件，通过 [GNU Stow](https://www.gnu.org/software/stow/) 管理。

## 包含的配置

| 类别 | 应用 | 配置路径 |
|------|------|----------|
| 窗口管理器 | Hyprland | `.config/hypr/` |
| 锁屏 | hyprlock + hypridle | `.config/hypr/hyprlock.conf`, `hypridle.conf` |
| 状态栏 | Waybar | `.config/waybar/` |
| 启动器 | Rofi | `.config/rofi/` |
| 通知中心 | SwayNC | `.config/swaync/` |
| 登出菜单 | wlogout | `.config/wlogout/` |
| 终端 | Ghostty | `.config/ghostty/` |
| 编辑器 | Neovim | `.config/nvim/` |
| 音频可视化 | cava | `.config/cava/` |
| Shell | Zsh | `.zshrc` |
| 终端复用 | Tmux | `.tmux.conf` |
| 提示符 | Oh My Posh | `.config/ohmyposh/` |
| 字体 | fontconfig | `.config/fontconfig/` |
| 辅助脚本 | viegphunt | `.config/viegphunt/` |

## 配色

全局配色定义在 `.config/colors/` 下，所有组件统一使用 Kanagawa 风格色板：

| 变量 | 色值 | 用途 |
|------|------|------|
| background | `#1e1e2e` | 主背景 |
| foreground | `#cdd6f4` | 主文字 |
| pink | `#f5c2e7` | 强调/活动工作区 |
| purple | `#cba6f7` | 电池/装饰 |
| red | `#f38ba8` | 紧急/关闭 |
| orange | `#fab387` | 音量 |
| yellow | `#f9e2af` | 蓝牙 |
| green | `#a6e3a1` | 网络 |
| blue | `#89b4fa` | 时钟 |

> 边框和阴影颜色已调整为 Kanagawa 配色（`#DCD7BA`/`#363646`/`#1F1F28`）。

## 辅助脚本

| 脚本 | 功能 |
|------|------|
| `app_launcher.sh` | Rofi 应用启动器 |
| `zh_launcher.sh` | 中文 fzf 应用启动器 |
| `clipboard_launcher.sh` | 剪贴板历史 (cliphist + rofi) |
| `emoji_launcher.sh` | Emoji 选择器 (rofi) |
| `wallpaper_select.sh` | Rofi 壁纸选择 → awww 切换 |
| `wallpaper_random.sh` | 随机壁纸切换 |
| `wallpaper_effects.sh` | 生成壁纸缩略图供 hyprlock 使用 |
| `wifi_menu.sh` | Rofi WiFi 连接菜单 (nmcli) |
| `show_desktop.sh` | 显示桌面 (Hyprland special workspace) |
| `pin_hidden_desktop.sh` | 固定隐藏桌面窗口到当前工作区 |
| `switch_hidden_desktop.sh` | 切换隐藏桌面与当前工作区 |
| `key_hints.sh` | 快捷键速查 (yad) |
| `gtkthemes.sh` | 应用 GTK 主题/图标/光标/字体 |
| `setcursor.sh` | 设置 macOS 风格光标 |
| `install_archpkg.sh` | 软件包安装列表 |
| `backup_config.sh` | Stow 前备份已有配置 |

## Neovim 插件

使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理：

| 插件 | 功能 |
|------|------|
| kanagawa | 主题 |
| blink.cmp | 自动补全 |
| mason + nvim-lsp | LSP (lua_ls, clangd, pyright, ts_ls, html, cssls, rust_analyzer) |
| conform + mason-tool-installer | 格式化 (stylua, clang-format, black, prettier) |
| fzf-lua | 文件搜索/实时 grep |
| oil.nvim | 文件管理器 |
| nvim-treesitter | 语法高亮 |
| nvim-ufo | 代码折叠 |
| noice + nvim-notify | UI 美化 |
| snacks.nvim | Dashboard |
| bufferline | Buffer 标签栏 |
| lualine | 状态栏 |
| mini.nvim | 补全对/包围/缩进/注释 |
| toggleterm | 终端 |
| gitsigns | Git 标记 |
| rustaceanvim | Rust 开发 |
| indent-blankline | 缩进线 |
| colorizer | 颜色预览 |
| rainbow-delimiters | 彩虹括号 |
| render-markdown | Markdown 渲染 |
| fidget | LSP 进度 |

## 部署

配合 [Arch-Hyprland](https://github.com/post7794/Arch-Hyprland) 安装脚本使用，或手动部署：

```bash
cd ~/dotfiles
stow -t ~ .
```

## 目录结构

```
.
├── .config/
│   ├── cava/              # 音频可视化
│   ├── colors/            # 全局配色
│   ├── fontconfig/        # 字体配置
│   ├── ghostty/           # 终端
│   ├── hypr/              # Hyprland + hyprlock + hypridle
│   ├── nvim/              # Neovim
│   ├── ohmyposh/          # 提示符主题
│   ├── rofi/              # 启动器
│   ├── swaync/            # 通知中心
│   ├── viegphunt/         # 辅助脚本
│   ├── waybar/            # 状态栏
│   └── wlogout/           # 登出菜单
├── .stow-local-ignore
├── .tmux.conf
└── .zshrc
```
