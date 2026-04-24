return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        require("bufferline").setup({
            options = {
                diagnostics = "nvim_lsp",
                always_show_bufferline = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                separator_style = "slant",
            },
        })
    end,
}
