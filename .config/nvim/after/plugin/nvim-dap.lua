local dap = require('dap')

dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = {vim.fn.stdpath("data") .. '/dap/vscode-firefox-debug/dist/adapter.bundle.js'},
}

dap.adapters.java = function(callback)
  callback({
    type = 'server';
    host = '127.0.0.1';
  })
end

dap.configurations.java = {
  {
    type = 'java';
    request = 'attach';
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
}

dap.configurations.typescript = {
  {
  name = 'Debug with Firefox',
  type = 'firefox',
  request = 'launch',
  reAttach = true,
  url = 'http://localhost:3000',
  webRoot = '${workspaceFolder}',
  firefoxExecutable = '/Applications/Firefox Nightly.app/Contents/MacOS/firefox'
  -- firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox'
  },
}

-- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

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
          -- Provide as ID strings or tables with "id" and "size" keys
          -- { id = "breakpoints", size = 0.25 },
          { id = "stacks", size = 0.30 },
          { id = "scopes", size = 0.35 },
          { id = "watches", size = 0.35 },
        },
        size = 50,
        position = "left", -- Can be "left", "right", "top", "bottom"
      },
      {
        elements = { "repl" },
        size = 10,
        position = "bottom", -- Can be "left", "right", "top", "bottom"
      },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

--[[ local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end ]]

require("nvim-dap-virtual-text").setup()

vim.cmd[[
nnoremap <leader>d_ :lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>
nnoremap <leader>db :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <leader>ds :lua require'dap'.terminate()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>dt :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
" nnoremap <S-k> :lua require'dap'.step_out()<CR>
" nnoremap <S-l> :lua require'dap'.step_into()<CR>
" nnoremap <S-j> :lua require'dap'.step_over()<CR>
nnoremap <leader>dk :lua require'dap'.up()<CR>
nnoremap <leader>dj :lua require'dap'.down()<CR>


nnoremap <leader>dt :lua require("dapui").toggle()<CR>
nnoremap <leader>dh :lua require("dapui").eval()<CR>
nnoremap <leader>dv :lua require("dapui").float_element()<CR>

" nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>

" Plug 'nvim-telescope/telescope-dap.nvim'
" lua << EOF
" require('telescope').setup()
" require('telescope').load_extension('dap')
" EOF
" nnoremap <leader>df :Telescope dap frames<CR>
" nnoremap <leader>dc :Telescope dap commands<CR>
" nnoremap <leader>db :Telescope dap list_breakpoints<CR>

" theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
" let g:dap_virtual_text = v:true
]]
