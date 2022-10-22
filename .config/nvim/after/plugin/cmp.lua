local ok, cmp = pcall(require, "cmp")
if not ok then
	return
end

-- Setup nvim-cmp.
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
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	},
	sources = {
		{ name = "ultisnips" },
		{ name = "nvim_lsp" },
		-- { name = 'nvim_lsp', keyword_length = 3 },
		-- { name = 'nvim_lsp', max_item_count = 10, keyword_length = 3 },
		{ name = "path" },
	},
})
