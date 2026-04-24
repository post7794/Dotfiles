return {
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },

        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "lua-language-server",
                    "clangd",
                    "pyright",
                    "typescript-language-server",
                    "html-lsp",
                    "css-lsp",
                    "stylua",
                    "clang-format",
                    "black",
                    "prettier",
                    "rust-analyzer",
                },
            })
        end
    },

    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },

        config = function()
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    c = { "clang_format" },
                    cpp = { "clang_format" },
                    python = { "black" },
                    javascript = { "prettier" },
                    html = { "prettier" },
                    css = { "prettier" },
                    rust = { "rustfmt" },
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>gf", function()
                conform.format({ async = true, lsp_fallback = true })
            end, { desc = "Format Code" })
        end
    }
}
