local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local start_cmd = { "java", "-jar", vim.fn.expand("~/.flix/flix.jar"), "lsp" }

-- Set Flix as the filetype for *.flix files
vim.filetype.add({
	extension = {
		flix = "flix",
	},
})

-- Add the flix language server
if not configs.flix then
	configs.flix = {
		default_config = {
			cmd = start_cmd,
			filetypes = { "flix" },
			root_dir = function(fname)
				-- Search for flix.toml/flix.jar upwards recursively, with a fallback to the current directory
				local root_dir = vim.fs.dirname(vim.fs.find({ "flix.toml", "flix.jar" }, { path = fname, upward = true })
						[1])
					or vim.fs.dirname(fname)
				local flix_jar_path = vim.fs.joinpath(root_dir, "flix.jar")
				-- Make sure flix.jar is found in the root directory, otherwise return nil to prevent the LSP server from starting
				if vim.loop.fs_stat(flix_jar_path) == nil then
					print("Failed to start the LSP server: flix.jar not found in project root (" .. root_dir .. ")!\n")
					return nil
				end
				return root_dir
			end,
			settings = {},
		},
	}
end

-- Setup the flix server
lspconfig.flix.setup({
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	on_attach = function(client, bufnr)
		print("Flix LSP attached to buffer " .. bufnr)

		-- Automatically refresh LSP codelens on certain events
		vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
			pattern = "<buffer>",
			callback = function()
				vim.lsp.codelens.refresh({ bufnr = bufnr })
			end,
		})

		-- Function to run the Flix program using a Java command
		local runMain = function(command, context)
			vim.cmd("split | terminal java -jar flix.jar run")
		end

		-- Register the function as an LSP command for Flix
		client.commands["flix.runMain"] = runMain

		-- Setup shortcuts
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		--vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		--vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, bufopts)
		--vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		--vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		--vim.keymap.set("n", "<leader>h", vim.lsp.buf.document_highlight, bufopts)
		--vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		--vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		--vim.keymap.set('i', '<C-a>', '<C-x><C-o>', bufopts)
		--vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
		--vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, bufopts)
		--vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, bufopts)
		--vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, bufopts)
	end,
	flags = {},
})
