return {
    "mason-org/mason.nvim",
    opts = {},

    config = function(_, opts)
        require("mason").setup(opts)

        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local servers = {
            lua_ls = {
                cmd = { "lua-language-server" },
                filetypes = { "lua" },
                root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim", "require" } },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            },
            clangd = {
                cmd = { "clangd" },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
            },
            pyright = {
                cmd = { "pyright-langserver", "--stdio" },
                filetypes = { "python" },
                root_markers = {
                    "pyproject.toml",
                    "setup.py",
                    "setup.cfg",
                    "requirements.txt",
                    "Pipfile",
                    "pyrightconfig.json",
                    ".git",
                },
            },
            ts_ls = {
                cmd = { "typescript-language-server", "--stdio" },
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
                root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
            },
            html = {
                cmd = { "vscode-html-language-server", "--stdio" },
                filetypes = { "html" },
                root_markers = { "package.json", ".git" },
            },
            cssls = {
                cmd = { "vscode-css-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                root_markers = { "package.json", ".git" },
            },
            rust_analyzer = {
                cmd = { "rust-analyzer" },
                filetypes = { "rust" },
                root_markers = { "Cargo.toml", ".git" },
                settings = {
                    ["rust-analyzer"] = {
                        check = { command = "clippy" },
                    },
                },
            },
        }

        vim.lsp.config("*", { capabilities = capabilities })

        for name, config in pairs(servers) do
            vim.lsp.config(name, config)
        end

        vim.lsp.enable({ "lua_ls", "clangd", "pyright", "ts_ls", "html", "cssls", "rust_analyzer" })

        local group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = group,
            callback = function(event)
                local opts = { buffer = event.buf, silent = true }
                vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to Declaration" }))
                vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to References" }))
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Action" }))
                vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line Diagnostics" }))
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
            end,
        })
    end,
}
