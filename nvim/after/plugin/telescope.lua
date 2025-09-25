local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Search files" })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>pz', builtin.grep_string, { desc = "Grep string" })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = "Search open buffers" })
vim.keymap.set('n', '<leader>pk', builtin.keymaps, { desc = "Search keymaps" })
vim.keymap.set('n', '<leader>pht', builtin.help_tags, { desc = "Search help tags" })
vim.keymap.set('n', '<leader>po', builtin.oldfiles, { desc = "Search oldfiles" })
vim.keymap.set('n', '<leader>pc', builtin.commands, { desc = "Search commands" })
vim.keymap.set('n', '<leader>ph', builtin.search_history, { desc = "Search command history" })
vim.keymap.set('n', '<leader>pq', builtin.quickfix, { desc = "Search quickfix" })
vim.keymap.set('n', '<leader>px', builtin.registers, { desc = "Search registers" })
vim.keymap.set('n', '<leader>ps', builtin.spell_suggest, { desc = "Spell suggest" })
vim.keymap.set('n', '<leader>p/', builtin.current_buffer_fuzzy_find, { desc = "Current buffer fuzzy find" })
vim.keymap.set('n', '<leader>pt', "<CMD>TodoTelescope<CR>", { desc = "Search TODO comments" })

vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, { desc = "Search document symbols" })
vim.keymap.set('n', '<leader>ws', builtin.lsp_dynamic_workspace_symbols, { desc = "Search workspace symbols" })

-- Search neovim config files
vim.keymap.set('n', '<leader>pa', function()
	builtin.find_files { cwd = vim.fn.stdpath('config') }
end, { desc = "Search neovim config" })

-- LSP picker mappings
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = "Search LSP references" })
vim.keymap.set('n', '<leader>pe', builtin.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = "Search implementations" })
vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = "Search definitions" })

require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = require('telescope.actions').select_horizontal,
				["<C-s>"] = require('telescope.actions').select_vertical,
			},
			n = {
				["<C-h>"] = require('telescope.actions').select_horizontal,
				["<C-s>"] = require('telescope.actions').select_vertical,
			},
		}
	},
	pickers = {
		find_files = {
			theme = "dropdown"
		},
		live_grep = {
			theme = "dropdown"
		},
		grep_string = {
			theme = "dropdown"
		},
		buffers = {
			theme = "dropdown"
		},
		keymaps = {
			theme = "dropdown"
		},
		quickfix = {
			theme = "dropdown"
		},
		current_buffer_fuzzy_find = {
			theme = "dropdown"
		},
	},
}
