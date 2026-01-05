vim.api.nvim_create_autocmd("FileType", {
	pattern = "sql",
	desc = "Keymaps for sql files (while open in dadbod)",

	callback = function()
		vim.keymap.set("n", "<leader>ql", ":.DB<CR>", { silent = true, desc = "Execute query on the current line." })
		vim.keymap.set("v", "<leader>q", ":DB<CR>", { silent = true, desc = "Execute selection." })
	end
})
