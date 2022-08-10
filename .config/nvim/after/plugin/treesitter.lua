local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
	return
end

treesitter.setup({
	-- ensure_installed = "maintained",
	highlight = {
		enable = true,
	},
	--[[ indent = {
	    enable = true,
	    disable = {"python"}
	}, ]]
})
