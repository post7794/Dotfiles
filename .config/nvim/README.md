# Neovim 配置

基于 [lazy.nvim](https://github.com/folke/lazy.nvim) 的 Neovim 配置，使用 Catppuccin Mocha 主题。

## 插件列表

| 插件 | 功能 |
|------|------|
| [blink.cmp](https://github.com/saghen/blink.cmp) | 自动补全 |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Buffer 标签栏 |
| [catppuccin](https://github.com/catppuccin/nvim) | 主题 |
| [colorizer](https://github.com/norcalli/nvim-colorizer.lua) | 颜色代码高亮 |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 代码格式化 |
| [fidget.nvim](https://github.com/j-hui/fidget.nvim) | LSP 进度动画 |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | 模糊查找 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git 标记 |
| [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim) | 缩进线 |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 插件管理 |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | 状态栏 |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | LSP/格式化工具管理 |
| [mini.nvim](https://github.com/nvim-mini/mini.nvim) | 自动配对 / 环绕 / 注释 / 缩进作用域 |
| [noice.nvim](https://github.com/folke/noice.nvim) | 命令行/通知 UI 美化 |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | 通知弹窗 |
| [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) | 代码折叠 |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | 文件管理器 |
| [rainbow-delimiters](https://github.com/HiPhish/rainbow-delimiters.nvim) | 彩虹括号 |
| [render-markdown](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown 渲染 |
| [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) | Rust 增强 |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | Dashboard / 大文件 / 快速打开 |
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | 终端 |
| [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法高亮 |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | 图标 |

## 快捷键

Leader 键：`Space`

### 通用

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Esc` | Normal | 清除搜索高亮 |
| `Tab` | Normal | 缩进当前行 |
| `Shift+Tab` | Normal | 反缩进当前行 |
| `Tab` | Visual | 缩进选中行 |
| `Shift+Tab` | Visual | 反缩进选中行 |
| `Alt+k` | Visual | 上移选中行 |
| `Alt+j` | Visual | 下移选中行 |

### 窗口

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Ctrl+h` | Normal | 跳转到左边窗口 |
| `Ctrl+l` | Normal | 跳转到右边窗口 |
| `Ctrl+k` | Normal | 跳转到上边窗口 |
| `Ctrl+j` | Normal | 跳转到下边窗口 |
| `Alt+=` | Normal | 增大窗口高度 |
| `Alt+-` | Normal | 减小窗口高度 |
| `Alt+,` | Normal | 增大窗口宽度 |
| `Alt+.` | Normal | 减小窗口宽度 |

### Buffer

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Space+bh` | Normal | 上一个 Buffer |
| `Space+bl` | Normal | 下一个 Buffer |
| `Space+bd` | Normal | 关闭当前 Buffer |

### 文件 / 搜索

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Space+e` | Normal | 打开/切换 Oil 侧边栏光标 |
| `Space+ff` | Normal | 查找文件 |
| `Space+fg` | Normal | 全局搜索（Live Grep） |

### 终端

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Space+`` | Normal | 打开/关闭底部终端 |
| `Esc` | Terminal | 退出终端模式 |

### LSP

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `K` | Normal | 悬停文档 |
| `gd` | Normal | 跳转到定义 |
| `gD` | Normal | 跳转到声明 |
| `gr` | Normal | 跳转到引用 |
| `gi` | Normal | 跳转到实现 |
| `Space+rn` | Normal | 重命名符号 |
| `Space+ca` | Normal | 代码操作 |
| `Space+d` | Normal | 行诊断信息浮窗 |
| `[d` | Normal | 上一个诊断 |
| `]d` | Normal | 下一个诊断 |

### Rust（仅 .rs 文件生效）

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Space+rr` | Normal | 运行 target |
| `Space+rd` | Normal | 调试 target |
| `Space+rh` | Normal | 悬停操作（类型/run/doctest） |
| `Space+re` | Normal | 展开宏 |
| `Space+ro` | Normal | 打开 Cargo.toml |
| `Space+rp` | Normal | 跳转到父模块 |
| `Space+rc` | Normal | Crate 依赖图 |
| `Space+rs` | Normal | 结构化搜索替换 |

### 代码折叠

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `zC` | Normal | 关闭所有折叠 |
| `zO` | Normal | 打开所有折叠 |
| `zp` | Normal | 预览折叠内容（无折叠时显示悬停文档） |

### 代码格式化

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Space+gf` | Normal / Visual | 格式化代码 |

### 注释

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Space+/` | Normal | 切换当前行注释 |
| `Space+/` | Visual | 切换选中行注释 |

### 其他

| 快捷键 | 模式 | 功能 |
|--------|------|------|
| `Space+tr` | Normal | 切换相对行号 |

### 补全（blink.cmp super-tab 预设）

| 快捷键 | 功能 |
|--------|------|
| `Tab` | 选择下一个 / 确认补全 |
| `Shift+Tab` | 选择上一个 |
| `Ctrl+Space` | 打开补全菜单 / 打开文档 |
| `Ctrl+e` | 关闭补全菜单 |
| `Ctrl+k` | 切换签名帮助 |

### Oil 文件管理器

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+s` | 垂直分屏打开文件 |
| `Enter` | 目录则进入，文件则在编辑区打开 |
| `q` | 关闭侧边栏 |
| `-` | 返回上级目录 |
| `g.` | 切换隐藏文件 |

### Dashboard 启动页

| 快捷键 | 功能 |
|--------|------|
| `n` | 新建文件 |
| `f` | 查找文件 |
| `t` | 全局搜索 |
| `u` | 更新插件 |
| `l` | 打开 Lazy |
| `q` | 退出 |

## LSP 服务器

通过 Mason 自动安装：

- **lua_ls** — Lua
- **clangd** — C / C++
- **pyright** — Python
- **ts_ls** — TypeScript / JavaScript
- **html** — HTML
- **cssls** — CSS
- **rust_analyzer** — Rust

## 格式化工具

- **stylua** — Lua
- **clang-format** — C / C++
- **black** — Python
- **prettier** — JavaScript / HTML / CSS
- **rustfmt** — Rust
