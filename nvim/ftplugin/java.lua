-- Debugger installation location
local MASON = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/"
local JDTLS = MASON .. "jdtls/bin/jdtls"
local JAVA_DEBUG = MASON .. "java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
local JAVA_TEST = MASON .. "java-test/extension/server/*.jar"

-- JDTLS Bundles
local bundles = { vim.fn.glob(JAVA_DEBUG) }
vim.list_extend(bundles, vim.split(vim.fn.glob(JAVA_TEST), "\n"))

local jdtls = require("jdtls")
jdtls.start_or_attach({
    cmd = { JDTLS },
    root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
    init_options = {
        bundles = bundles,
    },
    on_attach = function(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()
    end,
})

-- Java Test Debugger Keybinds
vim.keymap.set("n", "<leader>df", jdtls.test_class)
vim.keymap.set("n", "<leader>dm", jdtls.test_nearest_method)
