local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "<leader>vd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "<leader>vh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<leader>vi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<leader>vsh", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "<leader>vsd", "<cmd>lua vim.diagnostic.open_float(nil, {})<CR>", opts)
	buf_set_keymap("n", "<leader>vp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<leader>vn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<space>vf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	-- 0.8.0 buf_set_keymap('n', '<space>vf', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)
end

-- Required for html/cssls because Microsoft :/
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = capabilities,
		on_attach = on_attach,
	}, _config or {})
end

-- Mason.nvim config
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
	function(server_name)
		nvim_lsp[server_name].setup(config())
	end,
	["sumneko_lua"] = function()
		nvim_lsp.sumneko_lua.setup({
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = vim.split(package.path, ";"),
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
					},
				},
			},
		})
	end,
})

-- LSPs not installed with mason.nvim
nvim_lsp.gdscript.setup(config())

-- Prepare for Ultisnips config
vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"

-- Setup nvim-cmp.
local cmp = require("cmp")
cmp.setup({
	performance = {
		debounce = 150,
	},
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<Plug>(ultisnips_jump_forward)", true, true, true),
					"m",
					true
				)
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
			elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<Plug>(ultisnips_jump_backward)", true, true, true),
					"m",
					true
				)
			else
				fallback()
			end
		end,
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = {
		{ name = "ultisnips" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		-- { name = 'nvim_lsp', max_item_count = 10, keyword_length = 3 },
	},
})

local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
	b.formatting.prettierd,
	b.formatting.shfmt,
	b.formatting.black.with({ extra_args = { "--fast", "--line-length", "79" } }),
	b.formatting.isort,
	b.formatting.stylua,

	b.diagnostics.eslint_d,
	-- b.diagnostics.flake8,

	b.hover.dictionary,
}

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
})
