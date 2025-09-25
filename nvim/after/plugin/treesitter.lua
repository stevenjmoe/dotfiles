local configs = require("nvim-treesitter.configs")

configs.setup({
	highlight = { enable = true },
	indent = { enable = true },
	ensure_installed = { "lua" },
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class start" },
				["]o"] = "@loop.*",
				["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]F"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[["] = "@class.outer",
				["[s"] = { query = "@local.scope", query_group = "locals", desc = "Previous scope" },
				["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
				["[]"] = "@class.outer",
			},
			goto_next = {
				["]c"] = "@conditional.outer",
			},
			goto_previous = {
				["[c"] = "@conditional.outer",
			}
		},
	},
})
