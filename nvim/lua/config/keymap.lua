vim.g.mapleader = ' '
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>")

-- Yoink to clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Diagnostics
vim.keymap.set("n", "<leader>[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>le", vim.diagnostic.setloclist)

-- Quickfix navigation
vim.keymap.set('n', '<C-Down>', "<cmd>cnext<CR>zz")
vim.keymap.set('n', '<C-Up>', "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>i", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
end, { desc = "Toggle inlay hint" })

-- Stuff with buffers
vim.keymap.set('n', '<leader>so', "<cmd>only<CR>zz")
vim.keymap.set('n', '<leader>bdd', "<cmd>bd<CR>zz")
vim.keymap.set('n', '<leader>bda', "<cmd>%bd<CR>zz")
vim.keymap.set('n', '<leader>bd.', "<cmd>%bd|e #|normal`\"<CR>zz",
	{ desc = "Delete all but the current buffer and maintain position in buffer" })

-- todo comments
vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.keymap.set("n", "<leader>tt", "<cmd>TodoQuickFix<CR>zz")

vim.keymap.set("n", "<leader>tw", function()
	require("twilight").toggle()
end, { desc = "Toggle twilight" })

vim.keymap.set("n", "<leader>tz", function()
	require("zen-mode").toggle()
end, { desc = "Toggle zen mode" })
