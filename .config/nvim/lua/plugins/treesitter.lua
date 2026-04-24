return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").setup({
            auto_install = true,
            ensure_installed = {
                "bash",
                "lua",
                "c",
                "cpp",
                "python",
                "javascript",
                "typescript",
                "tsx",
                "html",
                "css",
                "markdown",
                "markdown_inline",
                "rust",
            },
        })

        vim.treesitter.language.register("bash", { "sh", "zsh" })
        vim.treesitter.language.register("javascript", { "javascriptreact" })
        vim.treesitter.language.register("tsx", { "typescriptreact" })

        local group = vim.api.nvim_create_augroup("user-treesitter-start", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            pattern = {
                "bash",
                "c",
                "cpp",
                "css",
                "html",
                "javascript",
                "javascriptreact",
                "lua",
                "markdown",
                "python",
                "sh",
                "typescript",
                "typescriptreact",
                "zsh",
            },
            callback = function(event)
                vim.treesitter.start(event.buf)
            end,
        })
    end,
}
