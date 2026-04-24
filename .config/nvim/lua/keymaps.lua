local keymap = vim.keymap.set

-- Setup Keymaps Neovim --

-- Set leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Relativenumber toggle
keymap("n", "<leader>tr", ":set relativenumber!<CR>", { desc = "Toggle Relativenumber", silent = true })    -- Space t r

-- General clear highlights
keymap("n", "<Esc>", ":noh<CR>", { desc = "General Clear Highlights", silent = true })

-- Resize pane
keymap("n", "<A-=>", "<C-w>+", { desc = "Make Window Taller" })     -- Alt =
keymap("n", "<A-->", "<C-w>-", { desc = "Make Window Shorter" })    -- Alt -
keymap("n", "<A-,>", "<C-w>>", { desc = "Make Window Wider" })      -- Alt ,
keymap("n", "<A-.>", "<C-w><", { desc = "Make Window Narrower" })   -- Alt .

-- Move on pane
keymap("n", "<C-K>", "<C-w>k", { desc = "Move To Upper Pane" })     -- Ctrl k
keymap("n", "<C-J>", "<C-w>j", { desc = "Move To Bottom Pane" })    -- Ctrl j
keymap("n", "<C-H>", "<C-w>h", { desc = "Move To Left Pane" })      -- Ctrl h
keymap("n", "<C-L>", "<C-w>l", { desc = "Move To Right Pane" })     -- Ctrl l

-- Set move line
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Line(s) Up (Visual mode)", silent = true })        -- Alt k
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Line(s) Down (Visual mode)", silent = true })    -- Alt j

-- Buffer navigation
keymap("n", "<leader>bh", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous Buffer", silent = true })
keymap("n", "<leader>bl", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer", silent = true })
keymap("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer", silent = true })

-- Folding
keymap("n", "zC", function() require("ufo").closeAllFolds() end, { desc = "Close All Folds", silent = true })
keymap("n", "zO", function() require("ufo").openAllFolds() end, { desc = "Open All Folds", silent = true })
keymap("n", "zp", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end, { desc = "Peek Fold", silent = true })

-- Indentation
keymap("n", "<Tab>", ">>", { desc = "Indent Line (Normal mode)" })              -- Tab
keymap("n", "<S-Tab>", "<<", { desc = "Unindent Line (Normal mode)" })          -- Shift Tab
keymap("v", "<Tab>", ">gv", { desc = "Indent Selection (Visual mode)" })        -- Tab
keymap("v", "<S-Tab>", "<gv", { desc = "Unindent Selection (Visual mode)" })    -- Shift Tab
