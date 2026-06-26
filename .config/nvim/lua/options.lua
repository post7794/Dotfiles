local opt = vim.opt

-- Setup Options Neovim --

opt.laststatus = 3
opt.showmode = false
opt.undofile = true

-- Line numbers
opt.number = true                   -- Display line numbers
opt.relativenumber = true            -- Display relative line numbers
opt.numberwidth = 2                 -- Set min number column width

-- Display and UI
opt.cursorline = true               -- Highlight cursor line
opt.fillchars = { eob = " " }       -- Hide "~" on empty buffer lines
opt.wrap = false                    -- Disable wrap line
opt.sidescroll = 1                  -- Scroll 1-char horizontally
opt.sidescrolloff = 5               -- Keep 5-char margin
opt.signcolumn = "yes"
opt.winborder = "rounded"
opt.splitbelow = true
opt.splitright = true
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Set tab = 4 space
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Set color
opt.termguicolors = true

-- Clipboard: OSC 52 for copy (instant), win32yank for paste (WT doesn't support OSC 52 read)
vim.g.clipboard = {
    name = "OSC 52 + win32yank",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = true,
}
opt.clipboard = "unnamedplus"
