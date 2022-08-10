local ok, project = pcall(require, "project_nvim")
if not ok then
	return
end

project.setup({
	manual_mode = false,
	detection_methods = { "lsp", "pattern" },
	-- detection_methods = { "lsp" },
	show_hidden = false,
})
