local ok, nvim_lsp = pcall(require, "lspconfig")
if not ok then
	return
end

local on_attach = function(client, bufnr)
	-- Mappings
	local opts = { noremap = true, silent = true }
	local function buf_set_keymap(lhs, rhs)
		vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
	end

	buf_set_keymap("<leader>vd", "<cmd>lua vim.lsp.buf.definition()<CR>")
	buf_set_keymap("<leader>vh", "<cmd>lua vim.lsp.buf.hover()<CR>")
	buf_set_keymap("<leader>vi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	buf_set_keymap("<leader>vsh", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	buf_set_keymap("<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>")
	buf_set_keymap("<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	buf_set_keymap("<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	buf_set_keymap("<leader>vsd", "<cmd>lua vim.diagnostic.open_float(nil, {})<CR>")
	buf_set_keymap("<leader>vp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
	buf_set_keymap("<leader>vn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
	buf_set_keymap("<space>vf", "<cmd>lua vim.lsp.buf.format{ async = true }<CR>")
end

-- Required for html/cssls because Microsoft
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function config(_config)
	return vim.tbl_deep_extend("force", {
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
	["lua_ls"] = function()
		nvim_lsp.lua_ls.setup(config({
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
		}))
	end,
	["jdtls"] = function() end, -- Use nvim-jdtls instead
	["html"] = function()
		nvim_lsp.html.setup(config({
			capabilities = capabilities,
		}))
	end,
	["cssls"] = function()
		nvim_lsp.cssls.setup(config({
			capabilities = capabilities,
		}))
	end,
})

-- LSPs not installed with mason.nvim
nvim_lsp.gdscript.setup(config())
nvim_lsp.ccls.setup(config())

-- Null LS
local null_ls = require("null-ls")
local b = null_ls.builtins

null_ls.setup({
	sources = {
		b.formatting.prettierd,
		b.formatting.shfmt,
		b.formatting.black.with({ extra_args = { "--fast", "--line-length", "79" } }),
		b.formatting.isort,
		b.formatting.stylua,
		b.formatting.clang_format,
		b.formatting.asmfmt,

		-- b.diagnostics.eslint_d,
		-- b.diagnostics.flake8,
	},
	on_attach = on_attach,
})
