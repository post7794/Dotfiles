return {
    "folke/flash.nvim",

    opts = {
        search = {
            multi_window = false,
        },
        modes = {
            char = { enabled = false },
        },
    },

    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", nowait = true },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", nowait = true },
    },
}
