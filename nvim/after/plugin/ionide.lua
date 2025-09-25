-- Basic Ionide settings
--vim.g.fsharp_automatic_sln_loading = 1
--vim.g.fsharp_map_namespaces = 1
--vim.g.fsharp_map_typecheck = 1
--vim.g.fsharp_map_gotodecl = 1
--vim.g.fsharp_map_gotonext = 1

--vim.g.fsharp_diagnostic_mode = "all"
--vim.g.fsharp_resolve_namespaces = 1
--vim.g.fsharp_enable_reference_code_lens = 1
--vim.g.fsharp_enable_analyzers = 1

vim.g["fsharp#fsautocomplete_command"] = { "dotnet", "fsautocomplete" }

-- File type specific settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fsharp",
	callback = function()
		-- Indentation settings
		vim.bo.expandtab = true
		vim.bo.shiftwidth = 4
		vim.bo.softtabstop = 4
		vim.bo.tabstop = 4
		vim.bo.commentstring = "// %s"
	end
})
