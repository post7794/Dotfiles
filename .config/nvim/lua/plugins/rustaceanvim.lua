return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,

	config = function()
		vim.g.rustaceanvim = {
			tools = {
				hover_actions = {
					replace_builtin_hover = true,
				},
			},
		}

		local group = vim.api.nvim_create_augroup("rust-keymaps", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = "rust",
			callback = function(event)
				local opts = { buffer = event.buf, silent = true }
				vim.keymap.set("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, vim.tbl_extend("force", opts, { desc = "Rust Run" }))
				vim.keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end, vim.tbl_extend("force", opts, { desc = "Rust Debug" }))
				vim.keymap.set("n", "<leader>re", function() vim.cmd.RustLsp("expandMacro") end, vim.tbl_extend("force", opts, { desc = "Rust Expand Macro" }))
				vim.keymap.set("n", "<leader>ro", function() vim.cmd.RustLsp("openCargo") end, vim.tbl_extend("force", opts, { desc = "Rust Open Cargo.toml" }))
				vim.keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, vim.tbl_extend("force", opts, { desc = "Rust Parent Module" }))
				vim.keymap.set("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end, vim.tbl_extend("force", opts, { desc = "Rust Crate Graph" }))
				vim.keymap.set("n", "<leader>rs", function() vim.cmd.RustLsp("ssr") end, vim.tbl_extend("force", opts, { desc = "Rust SSR" }))
				vim.keymap.set("n", "<leader>rh", function() vim.cmd.RustLsp({ "hover", "actions" }) end, vim.tbl_extend("force", opts, { desc = "Rust Hover Actions" }))
			end,
		})
	end,
}
