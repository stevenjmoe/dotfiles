require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		sql = { "sql_formatter" },
	},
	formatters = {
		sql_formatter = {
			command = vim.fn.stdpath("data") .. "/mason/bin/sql-formatter",
			args = { "--language", "sqlite" },
			stdin = true,
		},
	},
})

vim.keymap.set("n", "<leader>fd", function()
	require("conform").format({ timeout_ms = 5000 })
end, { desc = "" })
