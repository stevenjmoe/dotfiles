vim.api.nvim_create_autocmd("FileType", {
	pattern = "sql",
	desc = "Keymaps for sql files (while open in dadbod)",

	callback = function()
		vim.keymap.set("n", "<leader>ql", ":.DB<CR>", { silent = true, desc = "Execute query on the current line." })
		vim.keymap.set("v", "<leader>q", ":DB<CR>", { silent = true, desc = "Execute selection." })

		vim.keymap.set("n", "<leader>qp", function()
			local keys = vim.api.nvim_replace_termcodes("vip<Esc>", true, false, true)
			vim.api.nvim_feedkeys(keys, "nx", false)
			vim.cmd("'<,'>DB")
		end, { silent = true, desc = "Execute paragraph." })
	end
})
