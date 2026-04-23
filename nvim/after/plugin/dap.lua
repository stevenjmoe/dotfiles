local dap, dapui = require("dap"), require('dapui')

dap.adapters.cs = {
	type = "executable",
	command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/netcoredbg',
	args = { '--interpreter=vscode' },
}

dap.configurations.cs = {
	{
		type = "cs",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			return vim.fn.input('Path to dll: ', vim.fn.getcwd(), 'file')
		end,
	},
	{
		type = "cs",
		name = "attach - netcoredbg",
		request = "attach",
		processId = '${command:pickProcess}'
	}
}
dap.adapters.ocamlearlybird = {
	type = 'executable',
	command = 'ocamlearlybird',
	args = { 'debug' }
}
dap.configurations.ocaml = {
	{
		name = 'OCaml Debug test.bc',
		type = 'ocamlearlybird',
		request = 'launch',
		program = '${workspaceFolder}/_build/default/test/test.bc',
	},
	{
		name = 'OCaml Debug main.bc',
		type = 'ocamlearlybird',
		request = 'launch',
		program = '${workspaceFolder}/_build/default/bin/main.bc',
	},
	{
		name = 'OCaml Debug debug.bc',
		type = 'ocamlearlybird',
		request = 'launch',
		program = '${workspaceFolder}/_build/default/debug/debug.bc',
	},
}
dap.configurations.fsharp = {
	{
		type = "cs",
		name = "launch - netcoredbg",
		request = "launch",
		program = function()
			os.execute("dotnet build")
			local co = coroutine.running()

			require("telescope.builtin").find_files({
				prompt_title = "Select DLL",
				cwd = vim.fn.getcwd(),
				no_ignore = true,
				find_command = { "rg", "--files", "--no-ignore", "-g", "**/bin/**/*.dll" },
				attach_mappings = function(prompt_bufnr)
					local actions = require("telescope.actions")
					local action_state = require("telescope.actions.state")

					actions.select_default:replace(function()
						local entry = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						local path = entry.path or entry.filename or entry.value
						coroutine.resume(co, path)
					end)

					return true
				end,
			})
			return coroutine.yield()
		end,
	},
	{
		type = "cs",
		name = "attach - netcoredbg",
		request = "attach",
		processId = '${command:pickProcess}'
	}
}


-- keymaps
vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = "DAP continue" })
vim.keymap.set('n', '<F1>', function() dap.restart() end, { desc = "DAP restart" })
vim.keymap.set('n', '<F2>', function() dap.terminate() end, { desc = "DAP terminate" })
vim.keymap.set('n', '<F8>', function() dap.step_over() end, { desc = "DAP step over" })
vim.keymap.set('n', '<F9>', function() dap.step_into() end, { desc = "DAP step into" })
vim.keymap.set('n', '<F10>', function() dap.step_out() end, { desc = "DAP step out" })
vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end, { desc = "DAP open repl" })
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = "DAP run last" })

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
	mappings = {
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	controls = {
		enabled = true,
		element = "repl",
		icons = {
			pause = "pause",
			play = "play",
			step_into = "into",
			step_over = "over",
			step_out = "out",
			step_back = "back",
			run_last = "↻",
			terminate = "□",
		},
	},
	layouts = { {
		elements = {
			{ id = "repl", size = 1 },
		},
		position = "bottom",
		size = 12
	} },
})

dap.listeners.before.attach.dapui_config = function()
	dapui.open({ reset = true })
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open({ reset = true })
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- dapui keymaps
vim.keymap.set({ 'v', 'n' }, '<Leader>de', function() dapui.eval() end, { desc = "DAPUI eval" })

vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
	require('dap.ui.widgets').hover()
end, { desc = "DAPUI hover" })

vim.keymap.set({ 'v' }, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end, { desc = "DAPUI preview" })

vim.keymap.set({ 'n' }, '<Leader>dB', function()
	dapui.float_element("breakpoints", { enter = true })
end, { desc = "DAPUI breakpoints" })

vim.keymap.set('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end, { desc = "DAPUI widgets" })

vim.keymap.set('n', '<Leader>dz', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end, { desc = "DAPUI scopes" })

vim.keymap.set('n', '<Leader>dc', function()
	dapui.float_element("console")
end, { desc = "DAPUI Console" })

vim.keymap.set('n', '<Leader>dw', function()
	dapui.float_element("watches", { enter = true })
end, { desc = "DAPUI Watches" })

vim.keymap.set('n', '<Leader>dr', function()
	dapui.float_element("repl")
end, { desc = "DAPUI repl" })

vim.keymap.set('n', '<Leader>do', function()
	dapui.open({ reset = true })
end, { desc = "DAPUI reopen and reset windows." })
