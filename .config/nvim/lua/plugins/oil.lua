return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("oil").setup({
            default_file_explorer = true,
            columns = {
                "icon",
            },
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                ["q"] = function()
                    vim.cmd.close()
                end,
                ["<CR>"] = function()
                    local oil = require("oil")
                    local entry = oil.get_cursor_entry()
                    if not entry then
                        return
                    end
                    if entry.type == "directory" then
                        oil.select()
                        return
                    end
                    local dir = oil.get_current_dir()
                    if not dir then
                        return
                    end
                    -- Open file in the adjacent window but keep cursor in oil
                    local oil_win = vim.api.nvim_get_current_win()
                    vim.cmd.wincmd("l")
                    if vim.api.nvim_get_current_win() ~= oil_win then
                        vim.cmd.edit(vim.fn.fnameescape(dir .. entry.name))
                        vim.fn.win_gotoid(oil_win)
                    end
                end,
            },
        })

        local oil_buf = nil

        vim.keymap.set("n", "<leader>e", function()
            if oil_buf and vim.api.nvim_buf_is_valid(oil_buf) and #vim.fn.win_findbuf(oil_buf) > 0 then
                local oil_win = vim.fn.win_findbuf(oil_buf)[1]
                if vim.api.nvim_get_current_win() == oil_win then
                    vim.cmd.wincmd("p")
                else
                    vim.fn.win_gotoid(oil_win)
                end
                return
            end
            vim.cmd("leftabove vsplit")
            vim.cmd("vertical resize 25")
            require("oil").open()
            oil_buf = vim.api.nvim_get_current_buf()
        end, { desc = "Open Oil File Manager", silent = true })
    end,
}
