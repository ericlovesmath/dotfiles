local dap = require("dap")

local Remap = require("keymap")
local nnoremap = Remap.nnoremap

-- Debugger installation location
local MASON = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/"
local CODELLDB = MASON .. "codelldb/codelldb"

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = CODELLDB,
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = { vim.fn.stdpath("data") .. "/dap/vscode-firefox-debug/dist/adapter.bundle.js" },
}

dap.configurations.typescript = {
	{
		name = "Debug with Firefox",
		type = "firefox",
		request = "launch",
		reAttach = true,
		url = "http://localhost:3000",
		webRoot = "${workspaceFolder}",
		firefoxExecutable = "/Applications/Firefox.app/Contents/MacOS/firefox",
	},
}

require("nvim-dap-virtual-text").setup()

require("dapui").setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			-- You can change the order of elements in the sidebar
			elements = {
				-- { id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.30 },
				{ id = "scopes", size = 0.35 },
				{ id = "watches", size = 0.35 },
			},
			size = 40,
			position = "left",
		},
		{
			elements = { "repl" },
			size = 1,
			position = "bottom",
		},
	},
	floating = {
		max_height = nil,
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
})

vim.fn.sign_define("DapBreakpoint", { text = "●" })
vim.fn.sign_define("DapStopped", { text = "" })

nnoremap("<leader>d_", ":lua require('dap').disconnect();require('dap').close();require('dap').run_last()<CR>")
nnoremap("<leader>db", ":lua require('dap').toggle_breakpoint()<CR>")
nnoremap("<leader>ds", ":lua require('dap').terminate()<CR>")
nnoremap("<leader>dn", ":lua require('dap').continue()<CR>")
nnoremap("<leader>dt", ":lua require('dap').repl.open({}, 'vsplit')<CR><C-w>l")

nnoremap("<leader>dk", ":lua require('dap').up()<CR>")
nnoremap("<leader>dj", ":lua require('dap').down()<CR>")

-- nnoremap <S-k> :lua require'dap'.step_out()<CR>
-- nnoremap <S-l> :lua require'dap'.step_into()<CR>
-- nnoremap <S-j> :lua require'dap'.step_over()<CR>

nnoremap("<leader>dt", ":lua require('dapui').toggle()<CR>")
nnoremap("<leader>dh", ":lua require('dapui').eval()<CR>")
nnoremap("<leader>dv", ":lua require('dapui').float_element()<CR>")

-- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
