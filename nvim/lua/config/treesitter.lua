local filetypes = { 'fsharp', 'sql', 'cs', 'lua', 'rust', 'svelte', 'javascript', 'typescript', 'css', 'ocaml', 'elixir', 'gleam' }

vim.api.nvim_create_autocmd('FileType', {
	pattern = filetypes,
	callback = function()
		vim.treesitter.start()
	end
})
