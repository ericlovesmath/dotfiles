local nnoremap = require("keymap").nnoremap

-- nnoremap("<leader>r", ":w<CR>:vsp<CR>:term javac %:p;java %:p<CR><C-\\><C-n>")
nnoremap("<leader>r", ":w<CR>:vsp<CR>:term javac %:p:h/*.java && java %:p<CR><C-\\><C-n>")

-- Java Test Debugger Keybinds
nnoremap("<leader>df", ":lua require('jdtls').test_class()<CR>")
nnoremap("<leader>dm", ":lua require('jdtls').test_nearest_method()<CR>")

-- Debugger installation location
local MASON = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/"
local JDTLS = MASON .. "jdtls/bin/jdtls"
local JAVA_DEBUG = MASON .. "java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
local JAVA_TEST = MASON .. "java-test/extension/server/*.jar"

-- JDTLS Bundles
local bundles = { vim.fn.glob(JAVA_DEBUG) }
vim.list_extend(bundles, vim.split(vim.fn.glob(JAVA_TEST), "\n"))

require("jdtls").start_or_attach({
	cmd = { JDTLS },
	root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
	init_options = {
		bundles = bundles,
	},
	on_attach = function(client, bufnr)
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end,
})
