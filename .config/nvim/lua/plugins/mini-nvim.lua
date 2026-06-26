return {
    "nvim-mini/mini.nvim",

    config = function()
        -- Auto pairs
        local pairs = require("mini.pairs")
        pairs.setup({})

        -- Surround
        local surround = require("mini.surround")
        surround.setup({
            mappings = {
                add = "ys",
                delete = "ds",
                replace = "cs",
                find = "ysf",
                find_left = "ysF",
            },
        })
        -- Move lines/selection (normal & visual: Alt+hjkl)
        local move = require("mini.move")
        move.setup({})


        -- Indent scope animation
        local indentscope = require("mini.indentscope")
        indentscope.setup({
            draw = {
                animation = function() return 0 end,
            },
            symbol = "▏",
        })

        -- Jump to any visible position
        local jump2d = require("mini.jump2d")
        jump2d.setup({
            mappings = {
                start_jumping = "s",
            },
        })

        -- Comment code
        local comment = require("mini.comment")
        comment.setup({
            ignore_blank_line = true,
        })
        vim.keymap.set("n", "<leader>/", "gcc", { remap = true, desc = "Toggle Comment (Normal mode)" })    -- Space /
        vim.keymap.set("v", "<leader>/", "gc", { remap = true, desc = "Toggle Comment (Visual mode)" })     -- Space /
    end
}
