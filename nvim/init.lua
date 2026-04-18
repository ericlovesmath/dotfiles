--[[
    Eric Lee's Neovim Configuration
    Email: me@ericchanlee.com
    Github: https://github.com/ericlovesmath
--]]

vim.loader.enable()

require("config.options")
require("config.mappings")
require("config.runner")
require("config.llm")
require("config.utils")

require("plugins.bar")
require("plugins.cmp")
require("plugins.colors")
require("plugins.dap")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.utils")
