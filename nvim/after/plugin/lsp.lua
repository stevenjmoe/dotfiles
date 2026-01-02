require('flutter-tools').setup {}

local servers = {
	lua_ls = {
		settings = {
			Lua = {
				inlayHints = { enable = true },
				runtime = {
					version = 'LuaJIT'
				},
				diagnostics = {
					globals = { 'vim' },
				},
				workspace = {
					library = {
						vim.env.VIMRUNTIME,
					}
				}
			}
		},
	},
	html = {
		settings = {
			filetypes = { 'html', 'templ' },
		}
	},
	htmx = {
		filetypes = { 'html', 'templ' },
	},
	tailwindcss = {
		filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte" },
		settings = {
			tailwindCSS = {
				includeLanguages = {
					templ = "html",
				},
			}
		}
	},
	ocamllsp = {
		settings = {
			extendedHover = { enable = true },
			codelens = { enable = true },
			inlayHints = { enable = true },
			syntaxDocumentation = { enable = true },
		},

		filetypes = {
			"ocaml",
			"ocaml.interface",
			"ocaml.menhir",
			"ocaml.cram",
			"ocaml.mlx",
			"ocaml.ocamllex",
			"reason",
		}
	},
	ts_ls = {
		settings = {
			javascript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = false,
				},
			},
			typescript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = false,
				},
			}
		},
	},
	gopls = {},
	svelte = {},
	rust_analyzer = {},
	omnisharp = {
		cmd = { "dotnet", "/home/steven/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll" }
	},
	rescriptls = {},
	zls = {},
	marksman = {},
	-- omnisharp = {
	-- 	cmd = {
	-- 		"dotnet",

	-- 		vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll",
	-- 		"--languageserver",
	-- 	},
	-- },
	angularls = {},
	clangd = {},
	kotlin_language_server = {},
}

local ensure_installed = {
	"stylua",
	"lua_ls",
}

local servers_to_install = vim.tbl_filter(function(key)
	local t = servers[key]
	if type(t) == "table" then
		return not t.manual_install
	else
		return t
	end
end, vim.tbl_keys(servers))

require('mason').setup({})

vim.list_extend(ensure_installed, servers_to_install)
require("mason-tool-installer").setup { ensure_installed = ensure_installed }

for name, config in pairs(servers) do
	local capabilities = require('blink.cmp').get_lsp_capabilities()
	if config == true then
		config = {}
	end
	config = vim.tbl_deep_extend("force", {}, {
		capabilities = capabilities,
	}, config)

	require('lspconfig')[name].setup(config)
	require('lspconfig').gleam.setup({})
end

local disable_semantic_tokens = {
	lua = true,
}

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'LSP actions',
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(false)
		end

		local settings = servers[client.name]
		if type(settings) ~= "table" then
			settings = {}
		end

		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
		vim.keymap.set('i', '<C-space>', vim.lsp.buf.completion)
		vim.keymap.set('n', '<leader>fd', vim.lsp.buf.format)
		vim.keymap.set('n', 'H', vim.lsp.buf.hover)
		vim.keymap.set('n', '<C-H>', vim.lsp.buf.signature_help)
		vim.keymap.set('i', '<C-H>', vim.lsp.buf.signature_help)

		vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
		vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration)
		vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation)

		local filetype = vim.bo[bufnr].filetype
		if disable_semantic_tokens[filetype] then
			client.server_capabilities.semanticTokensProvider = nil
		end
		-- Override server capabilities
		if settings.server_capabilities then
			for k, v in pairs(settings.server_capabilities) do
				if v == vim.NIL then
					---@diagnostic disable-next-line: cast-local-type
					v = nil
				end

				client.server_capabilities[k] = v
			end
		end
	end,
})

-- Workaround for annoying rust-analyzer client error.
-- Hopefully it's fixed and this can be removed
for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
	local default_diagnostic_handler = vim.lsp.handlers[method]
	vim.lsp.handlers[method] = function(err, result, context, config)
		if err ~= nil and err.code == -32802 then
			return
		end
		return default_diagnostic_handler(err, result, context, config)
	end
end
