local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- color scheme
	"rebelot/kanagawa.nvim",

	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ "neovim/nvim-lspconfig" },
	{ 'L3MON4D3/LuaSnip' },


	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},

	{ "nvim-treesitter/nvim-treesitter",            build = ":TSUpdate" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },

	-- git
	{ 'tpope/vim-fugitive' },
	"mbbill/undotree",
	{ 'WhoIsSethDaniel/mason-tool-installer.nvim' },
	{
		'stevearc/conform.nvim',
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		},
		formatters_by_ft = {
			lua = { 'stylua' },
		}
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		'christoomey/vim-tmux-navigator',
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-H>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-J>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-K>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-L>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"ionide/Ionide-vim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		ft = { "fsharp" },
		build = function()
			vim.fn.system({ "dotnet", "tool", "install", "--global", "fsautocomplete" })
		end,
	},
	{
		'rescript-lang/vim-rescript',
		tag = "v2.1.0"
	},
	{
		'nvim-flutter/flutter-tools.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
		config = true,
	},
	{ 'mfussenegger/nvim-dap' },
	{
		"rcarriga/nvim-dap-ui",
		dependencies =
		{
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio"
		}
	},
	{
		'saghen/blink.cmp',
		dependencies = {
			'rafamadriz/friendly-snippets',
			{ "saghen/blink.compat", lazy = true, version = false },
		},

		version = 'v0.*',
		opts = {
			keymap = { preset = 'default' },

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono'
			},
			sources = {
				-- compat = { "obsidian", "obsidian_new", "obsidian_tags" },
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"dadbod",
					"obsidian",
					"obsidian_new",
					"obsidian_tags",
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					obsidian = {
						name = "obsidian",
						module = "blink.compat.source",
					},
					obsidian_new = {
						name = "obsidian_new",
						module = "blink.compat.source",
					},
					obsidian_tags = {
						name = "obsidian_tags",
						module = "blink.compat.source",
					},
				},
			},
			signature = { enabled = true },
			cmdline = {
				enabled = true,
				keymap = nil,
				sources = function()
					local type = vim.fn.getcmdtype()
					-- Search forward and backward
					if type == '/' or type == '?' then return { 'buffer' } end
					-- Commands
					if type == ':' then return { 'cmdline' } end
					return {}
				end,
			}
		},
	},
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
	},
	{ "tpope/vim-dadbod" },
	{
		'kristijanhusak/vim-dadbod-ui',
		dependencies = {
			{
				'tpope/vim-dadbod',
				lazy = true
			},
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
	{
		"folke/zen-mode.nvim",
		opts = {
		}
	},
	{
		"folke/twilight.nvim",
		opts = {
		}
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		}
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
})
