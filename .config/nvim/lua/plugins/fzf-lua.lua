return {
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        config = function()
            local fzf = require("fzf-lua")
            fzf.setup({
                files = {
                    hidden = true,
                    no_ignore = true,
                },
                grep = {
                    hidden = true,
                    no_ignore = true,
                },
            })

            vim.keymap.set("n", "<leader>ff", function()
                fzf.files({ hidden = true, no_ignore = true })
            end, { desc = "Find Files" })

            vim.keymap.set("n", "<leader>fg", function()
                fzf.live_grep({ hidden = true, no_ignore = true })
            end, { desc = "Live Grep" })
        end,
    }
}
