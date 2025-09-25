local detail = false
local oil = require('oil')
oil.setup({
	delete_to_trash = true,
	view_options = {
		show_hidden = true,
	},
	keymaps = {
		["td"] = {
			desc = "Toggle file detail view",
			callback = function()
				detail = not detail
				if detail then
					oil.set_columns({ "icon", "permissions", "size", "mtime" })
				else
					oil.set_columns({ "icon" })
				end
			end,
		},
	},
})
